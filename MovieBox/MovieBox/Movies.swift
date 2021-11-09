//
//  Movies.swift
//  MovieBox
//
//  Created by Mariano Manuel on 4/18/21.
//

import SwiftUI

struct Movies: View {
    @State var Started: Bool = false
    @State var MarzDeveloper: String = "Kah"
    @State var showSettings: Bool = false
    @State var spanishLang: Bool = false
    @State var showAudience: Bool = false
    @State var nowPlaying: String = "NOW PLAYING"
    @State var classOrder: String = "POPULAR"
    @State var Title: String = "¡Click iForm to Start!"
    @State var MovieSets: Int = 0
    @State var LanguageSetting: String = "Unknown"
    @State var NowPlayingMovieData: [Any] = []
    @State var PopularMovieData: [Any] = []
    @State var TopRatedMovieData: [Any] = []
    @State var NowPlayingMoviePosterData: [Data] = []
    @State var PopularMoviePosterData: [Data] = []
    @State var TopRatedMoviePosterData: [Data] = []
    @State var DataHasLoaded: Bool = false
    private var gridLayout = [GridItem(.fixed(150)), GridItem(.fixed(150))]
    
    var body: some View {
        NavigationView {
            List() {
                Section(header: Text(nowPlaying)) {
                    ScrollView(.horizontal) {
                        HStack {
                            if !DataHasLoaded {
                                ForEach((0..<20)) { (_) in
                                    NavigationLink(
                                        destination: Details(),
                                        label: {
                                            Image(systemName: "questionmark.app")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100)
                                        })
                                }
                            } else {
                                ForEach((0..<20)) { (i) in
                                    if NowPlayingMoviePosterData.count == 20 {
                                        NavigationLink(
                                            destination: Details(),
                                            label: {
                                                Image(uiImage: UIImage(data: NowPlayingMoviePosterData[i])!)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100)
                                            })
                                    } else {
                                        NavigationLink(
                                            destination: Details(),
                                            label: {
                                                Image(systemName: "questionmark.app")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100)
                                            })
                                    }
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text(classOrder)) {
                    ScrollView {
                        LazyVGrid(columns: gridLayout) {
                            ForEach((0..<20)) { (j) in
                                if PopularMoviePosterData.count == 20 {
                                    NavigationLink(
                                        destination: Details(),
                                        label: {
                                            Image(uiImage: UIImage(data: PopularMoviePosterData[j])!)
                                                .resizable()
                                                .scaledToFit()
                                        })
                                } else {
                                    NavigationLink(
                                        destination: Details(),
                                        label: {
                                            Image(systemName: "questionmark.app")
                                                .resizable()
                                                .scaledToFit()
                                        })
                                }
                            }
                            /*if PopularMoviePosterData.count == 20 {
                                exit(0)
                            } else {
                                ForEach((0..<20), id: \.self) { (_) in
                                    Image(systemName: "questionmark.app")
                                        .resizable()
                                        .scaledToFit()
                                    
                                }
                                /*ForEach(0..<20, id: \.self) { (_) in
                                    HStack {
                                        VStack {
                                            Image(systemName: "questionmark.app")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .padding()
                                            /*Image(uiImage: UIImage(data: imageData[index])!)
                                                .font(.system(size: 30))
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(20)*/
                                        }
                                    }
                                }*/
                            }*/
                        }
                    }

                    /*ScrollView {
                        LazyVGrid(columns: gridLayout) {
                            if !DataHasLoaded {
                                ForEach(0..<20) { _ in
                                    NavigationLink(
                                        destination: Details(),
                                        label: {
                                            Image(systemName: "questionmark.app")
                                                .resizable()
                                                .scaledToFit()
                                        })
                                }
                            } else {
                                ForEach(0..<20) { j in
                                    if PopularMoviePosterData.count == 20 {
                                        NavigationLink(
                                            destination: Details(),
                                            label: {
                                                Image(uiImage: UIImage(data: PopularMoviePosterData[j])!)
                                                    .resizable()
                                                    .scaledToFit()
                                            })
                                    } else {
                                        NavigationLink(
                                            destination: Details(),
                                            label: {
                                                Image(systemName: "questionmark.app")
                                                    .resizable()
                                                    .scaledToFit()
                                            })
                                    }
                                }
                            }
                        }
                    }*/
                }
            }
            .navigationBarTitle(Title)
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        Started = true
                        Title = "MovieBox"
                        showSettings = true
                    },
                    label: {
                               Image(systemName: "info.circle")
                    })
                }
            })
            .sheet(isPresented: $showSettings, onDismiss: {
                if Started {
                    LoadMovieDatabaseContentBabylonAPI(taskNumber: 1) { (MovieInfo1) in
                        if let MovieInfo1 = MovieInfo1 {
                            NowPlayingMovieData = MovieInfo1
                            DispatchQueue.global().async {
                            var images: [Data] = []
                            for i in 0..<NowPlayingMovieData.count {
                                let movie = NowPlayingMovieData[i] as! [String: Any]
                            let poster_path = movie["poster_path"] as! String
                                let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                let imageURL = URL(string: strURL)!
                                do {
                                    let data = try Data(contentsOf: imageURL)
                                    images.append(data)
                                } catch  {
                                    print(error)
                                }
                                
                            }
                                DispatchQueue.main.sync {
                                    NowPlayingMoviePosterData = images
                                }
                            }
                        }
                    }
                    
                    LoadMovieDatabaseContentBabylonAPI(taskNumber: 2) { (MovieInfo2) in
                        if let MovieInfo2 = MovieInfo2 {
                            PopularMovieData = MovieInfo2
                            DispatchQueue.global().async {
                            var images: [Data] = []
                            for i in 0..<PopularMovieData.count {
                                let movie = PopularMovieData[i] as! [String: Any]
                            let poster_path = movie["poster_path"] as! String
                                let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                let imageURL = URL(string: strURL)!
                                do {
                                    let data = try Data(contentsOf: imageURL)
                                    images.append(data)
                                } catch  {
                                    print(error)
                                }
                                
                            }
                                DispatchQueue.main.sync {
                                    PopularMoviePosterData = images
                                }
                            }
                        }
                    }
                    
                    LoadMovieDatabaseContentBabylonAPI(taskNumber: 3) { (MovieInfo3) in
                        if let MovieInfo3 = MovieInfo3 {
                            TopRatedMovieData = MovieInfo3
                            DispatchQueue.global().async {
                            var images: [Data] = []
                            for i in 0..<TopRatedMovieData.count {
                                let movie = TopRatedMovieData[i] as! [String: Any]
                            let poster_path = movie["poster_path"] as! String
                                let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                let imageURL = URL(string: strURL)!
                                do {
                                    let data = try Data(contentsOf: imageURL)
                                    images.append(data)
                                } catch  {
                                    print(error)
                                }
                                
                            }
                                DispatchQueue.main.sync {
                                    TopRatedMoviePosterData = images
                                    DataHasLoaded = true
                                }
                            }
                        }
                    }
                }
            }) {
                Settings(Started: $Started, Developer: $MarzDeveloper, spanishLang: $spanishLang, showAudience: $showAudience, nowPlaying: $nowPlaying, classOrder: $classOrder, MovieSets: $MovieSets, Language: $LanguageSetting)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func LoadMovieDatabaseContentBabylonAPI(taskNumber: Int, completeData: @escaping ([Any]?) -> Void) {
        print("Loading Movies")
        //Example API Call              ' /3/movie/now_playing?api_key=5bbf70742ff5480a08fefe89bd22d7f3&language=en
        let APIMovieLock_Key = "?api_key=5bbf70742ff5480a08fefe89bd22d7f3"
        let baseURL = "https://api.themoviedb.org/3/movie/"
        var movieType = "?"
        movieType = "now_playing"
        var languageSetting = "&language=?"
        if LanguageSetting == "English" {
            languageSetting = "&language=en"
        } else if LanguageSetting == "Español" {
            languageSetting = "&language=es"
        }
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        var dataTask2: URLSessionDataTask?
        var dataTask3: URLSessionDataTask?
        
        if taskNumber == 1 {
            let movieServiceURL = baseURL+movieType+APIMovieLock_Key+languageSetting
            dataTask?.cancel() //Poes
            guard let urlLink = URL(string: movieServiceURL) else { return }
            print("Configured URL and DataSession")
            dataTask = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
                print("Started Data Task")
                if let error = error {
                    print("Error Found")
                    print(error.localizedDescription)
                } else if let data = data {
                    print("Retrieving Data")
                    var response: [String: Any]?
                    do {
                        if #available(iOS 15.0, *) {
                            response = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .json5Allowed, .fragmentsAllowed]) as? [String: Any]
                        } else {
                            // Fallback on earlier versions
                            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        }
                    } catch _ as NSError { return }
                    guard let information = response!["results"] as? [Any] else { return }
                    DispatchQueue.main.async {
                        completeData(information)
                    }
                }
            })
            dataTask?.resume()
        } else if taskNumber == 2 {
            movieType = "popular"
            let movieServiceURL = baseURL+movieType+APIMovieLock_Key+languageSetting
            dataTask2?.cancel() //Poes
            guard let urlLink = URL(string: movieServiceURL) else { return }
            print("Configured URL and DataSession")
            dataTask2 = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
                print("Started Data Task")
                if let error = error {
                    print("Error Found")
                    print(error.localizedDescription)
                } else if let data = data {
                    print("Retrieving Data")
                    var response: [String: Any]?
                    do {
                        if #available(iOS 15.0, *) {
                            response = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .json5Allowed, .fragmentsAllowed]) as? [String: Any]
                        } else {
                            // Fallback on earlier versions
                            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        }
                    } catch _ as NSError { return }
                    guard let information = response!["results"] as? [Any] else { return }
                    DispatchQueue.main.async {
                        completeData(information)
                    }
                }
            })
            dataTask2?.resume()
        } else if taskNumber == 3 {
            movieType = "top_rated"
            let movieServiceURL = baseURL+movieType+APIMovieLock_Key+languageSetting
            dataTask3?.cancel() //Poes
            guard let urlLink = URL(string: movieServiceURL) else { return }
            print("Configured URL and DataSession")
            dataTask3 = defaultSession.dataTask(with: urlLink, completionHandler: { data, response, error in
                print("Started Data Task")
                if let error = error {
                    print("Error Found")
                    print(error.localizedDescription)
                } else if let data = data {
                    print("Retrieving Data")
                    var response: [String: Any]?
                    do {
                        if #available(iOS 15.0, *) {
                            response = try JSONSerialization.jsonObject(with: data, options: [.allowFragments, .json5Allowed, .fragmentsAllowed]) as? [String: Any]
                        } else {
                            // Fallback on earlier versions
                            response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        }
                    } catch _ as NSError { return }
                    guard let information = response!["results"] as? [Any] else { return }
                    DispatchQueue.main.async {
                        completeData(information)
                    }
                }
            })
            dataTask3?.resume()
        }
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
