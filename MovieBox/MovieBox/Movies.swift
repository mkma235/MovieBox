//
//  Movies.swift
//  MovieBox
//
//  Created by Mariano Manuel on 4/18/21.
//

import SwiftUI

struct Movies: View {
    @State var MarzDeveloper: String = "Kah"
    @State var showSettings: Bool = false
    @State var spanishLang: Bool = false
    @State var showAudience: Bool = false
    @State var nowPlaying: String = "NOW PLAYING"
    @State var classOrder: String = "POPULAR"
    @State var Title: String = "¡Click iForm to Start!"
    @State var MovieSets: Int = 0
    @State var LanguageSetting: String = "Unknown"
    @State var MovieData: [Any] = []
    private var gridLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            List() {
                Section(header: Text(nowPlaying)) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach((0..<20)) { _ in
                                Image(systemName: "tv")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }
                        }
                    }
                }
                
                Section(header: Text(classOrder)) {
                    ScrollView {
                        LazyVGrid(columns: gridLayout) {
                            ForEach(0..<30) { _ in
                                NavigationLink(
                                    destination: Details(),
                                    label: {
                                        Image(systemName: "rectangle.portrait")
                                            .resizable()
                                            .scaledToFit()
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Title)
            .toolbar(content: {
                Button(action: {
                    Title = "Movies"
                    LoadMovieDatabaseContentBabylonAPI { (MovieInfo) in
                        if let MovieInfo = MovieInfo {
                            MovieData = MovieInfo
                        }
                    }
                    showSettings = true
                }, label: {
                    Image(systemName: "info.circle")
                })
            })
            .sheet(isPresented: $showSettings) {
                Settings(Developer: $MarzDeveloper, spanishLang: $spanishLang, showAudience: $showAudience, nowPlaying: $nowPlaying, classOrder: $classOrder, MovieSets: $MovieSets, Language: $LanguageSetting)
            }
        }
    }
    //completeData: @escaping ([Any]?) -> Void)
    func LoadMovieDatabaseContentBabylonAPI(completeData: @escaping ([Any]?) -> Void) {
        print("Loading Movies")
        //Example API Call              ' /3/movie/now_playing?api_key=5bbf70742ff5480a08fefe89bd22d7f3&language=en
        let APIMovieLock_Key = "?api_key=5bbf70742ff5480a08fefe89bd22d7f3"
        let baseURL = "https://api.themoviedb.org/3/movie/"
        var movieType = "?"
        var languageSetting = "&language=?"
        if MovieSets == 0 {
            movieType = "now_playing"
        } else if MovieSets == 1 {
            movieType = "popular"
        } else if MovieSets == 2 {
            movieType = "top_rated"
        }
        if LanguageSetting == "English" {
            languageSetting = "&language=en"
        } else if LanguageSetting == "Español" {
            languageSetting = "&language=es"
        }
        let movieServiceURL = baseURL+movieType+APIMovieLock_Key+languageSetting
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel() //Poes
        dataTask?.cancel() //Luigi's Casino
        dataTask?.cancel() //Marz&Melvin
        guard let urlLink = URL(string: movieServiceURL) else { return }
        
        dataTask = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                var response: [String: Any]?
                do {
                    enum ReadingOptions {
                        case NSJSONReadingFragmentsAllowed
                        case NSJSONReadingJSON5Allowed
                        case NSJSONReadingTopLevelDictionaryAssumed
                    }
                response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch _ as NSError { return }
                guard let information = response!["results"] as? [Any] else { return }
                DispatchQueue.main.async {
                    completeData(information)
                }
            }
        })
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
