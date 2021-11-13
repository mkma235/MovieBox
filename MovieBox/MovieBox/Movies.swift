//
//  Movies.swift
//  MovieBox
//
//  Created by Mariano Manuel on 4/18/21.
//

import SwiftUI

struct Movies: View {
    @State var Started: Bool = false
    @State var MarzDeveloper: String = "Melvin"
    @State var showSettings: Bool = false
    @State var spanishLang: Bool = false
    @State var showAudience: Bool = false
    @State var nowPlaying: String = "NOW PLAYING"
    @State var classOrder: String = "POPULAR"
    @State var Title: String = "¡Click iForm to Start!"
    @State var MovieSets: Int = 0
    @State var LanguageSetting: String = "Unknown"
    @State var NowPlayingMovieInfo: [Any] = []
    @State var PopularMovieInfo: [Any] = []
    @State var TopRatedMovieInfo: [Any] = []
    @State var NowPlayingMoviePosterData: [Data] = []
    @State var PopularMoviePosterData: [Data] = []
    @State var TopRatedMoviePosterData: [Data] = []
    @State var Loaded1: Bool = false
    @State var Loaded2: Bool = false
    @State var Loaded3: Bool = false
    @State var NowPlayingDetailsPosters: [Data] = []
    @State var NowPlayingDetailsTitles: [String] = []
    @State var NowPlayingDetailsReleaseDates: [String] = []
    @State var NowPlayingDetailsMovieOverviews: [String] = []
    @State var PopularDetailsPosters: [Data] = []
    @State var PopularDetailsTitles: [String] = []
    @State var PopularDetailsReleaseDates: [String] = []
    @State var PopularDetailsMovieOverviews: [String] = []
    @State var TopRatedDetailsPosters: [Data] = []
    @State var TopRatedDetailsTitles: [String] = []
    @State var TopRatedDetailsReleaseDates: [String] = []
    @State var TopRatedDetailsMovieOverviews: [String] = []
    @State var ActivityIndicator1: Bool = false
    @State var ActivityIndicator2: Bool = false
    @State var ActivityIndicator3: Bool = false
    
    private var gridLayout = [GridItem(.fixed(150)), GridItem(.fixed(150))]
    
    var body: some View {
        NavigationView {
            ZStack {
                List() {
                    Section(header: Text(nowPlaying)) {
                        ScrollView(.horizontal) {
                            HStack {
                                if !Loaded1 {
                                    ForEach((0..<20)) { (_) in
                                        NavigationLink(
                                            destination: EmptyView(),
                                            label: {
                                                Image(systemName: "questionmark.app")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100)
                                            })
                                    }
                                } else {
                                    ForEach(0..<20){ (i) in
                                        if NowPlayingMoviePosterData.count == 20 {
                                            NavigationLink(
                                                destination: {
                                                    Details(Poster: $NowPlayingDetailsPosters[i], Title: $NowPlayingDetailsTitles[i], ReleaseDate: $NowPlayingDetailsReleaseDates[i], MovieOverview: $NowPlayingDetailsMovieOverviews[i])
                                                },
                                                label: {
                                                    Image(uiImage: UIImage(data: NowPlayingMoviePosterData[i])!)
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
                                        if Loaded1 && Loaded2 && Loaded3 {
                                            if MovieSets == 1 {
                                                NavigationLink(
                                                    destination: {
                                                        Details(Poster: $PopularDetailsPosters[j], Title: $PopularDetailsTitles[j], ReleaseDate: $PopularDetailsReleaseDates[j], MovieOverview: $PopularDetailsMovieOverviews[j])
                                                    },
                                                    label: {
                                                        Image(uiImage: UIImage(data: PopularMoviePosterData[j])!)
                                                            .resizable()
                                                            .scaledToFit()
                                                    })
                                            } else if MovieSets == 2 {
                                                NavigationLink(
                                                    destination: {
                                                        Details(Poster: $TopRatedDetailsPosters[j], Title: $TopRatedDetailsTitles[j], ReleaseDate: $TopRatedDetailsReleaseDates[j], MovieOverview: $TopRatedDetailsMovieOverviews[j])
                                                    },
                                                    label: {
                                                        Image(uiImage: UIImage(data: TopRatedMoviePosterData[j])!)
                                                            .resizable()
                                                            .scaledToFit()
                                                    })
                                            }
                                        } else {
                                            NavigationLink(
                                                destination: EmptyView(),
                                                label: {
                                                    Image(systemName: "questionmark.app")
                                                        .resizable()
                                                        .scaledToFit()
                                                })
                                        }
                                    } else {
                                        NavigationLink(
                                            destination: EmptyView(),
                                            label: {
                                                Image(systemName: "questionmark.app")
                                                    .resizable()
                                                    .scaledToFit()
                                            })
                                    }
                                }
                            }
                        }
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
                                NowPlayingMovieInfo = MovieInfo1
                                DispatchQueue.global().async {
                                    var images: [Data] = []
                                    var titles: [String] = []
                                    var dates: [String] = []
                                    var overviews: [String] = []
                                    for i in 0..<NowPlayingMovieInfo.count {
                                        let movie = NowPlayingMovieInfo[i] as! [String: Any]
                                        let poster_path = movie["poster_path"] as! String
                                        let movieTitle = movie["title"] as! String
                                        let movieReleaseDate = movie["release_date"]
                                        let movieOverview = movie["overview"]
                                        let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                        let imageURL = URL(string: strURL)!
                                        do {
                                            let data = try Data(contentsOf: imageURL)
                                            images.append(data)
                                            titles.append(movieTitle)
                                            dates.append(movieReleaseDate as! String)
                                            overviews.append(movieOverview as! String)
                                        } catch  {
                                            print(error)
                                        }
                                    }
                                    DispatchQueue.main.sync {
                                        ActivityIndicator1 = true
                                        print("A1 On")
                                
                                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
                                            NowPlayingMoviePosterData = images
                                            NowPlayingDetailsPosters = images
                                            NowPlayingDetailsTitles = titles
                                            NowPlayingDetailsReleaseDates = dates
                                            NowPlayingDetailsMovieOverviews = overviews
                                            Loaded1 = true
                                            ActivityIndicator1 = false
                                            print("A1 Off")
                                        }
                                    }
                                }
                            }
                        }
                        
                        LoadMovieDatabaseContentBabylonAPI(taskNumber: 2) { (MovieInfo2) in
                            if let MovieInfo2 = MovieInfo2 {
                                PopularMovieInfo = MovieInfo2
                                DispatchQueue.global().async {
                                    var images: [Data] = []
                                    var titles: [String] = []
                                    var dates: [String] = []
                                    var overviews: [String] = []
                                    for j in 0..<PopularMovieInfo.count {
                                        let movie = PopularMovieInfo[j] as! [String: Any]
                                        let poster_path = movie["poster_path"] as! String
                                        let movieTitle = movie["title"] as! String
                                        let movieReleaseDate = movie["release_date"]
                                        let movieOverview = movie["overview"]
                                        let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                        let imageURL = URL(string: strURL)!
                                        do {
                                            let data = try Data(contentsOf: imageURL)
                                            images.append(data)
                                            titles.append(movieTitle)
                                            dates.append(movieReleaseDate as! String)
                                            overviews.append(movieOverview as! String)
                                        } catch  {
                                            print(error)
                                        }
                                    }
                                    DispatchQueue.main.sync {
                                        ActivityIndicator2 = true
                                        print("A2 On")
                                        
                                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
                                            PopularMoviePosterData = images
                                            PopularDetailsPosters = images
                                            PopularDetailsTitles = titles
                                            PopularDetailsReleaseDates = dates
                                            PopularDetailsMovieOverviews = overviews
                                            Loaded2 = true
                                            ActivityIndicator2 = false
                                            print("A2 Off")
                                        }
                                    }
                                }
                            }
                        }
                        
                        LoadMovieDatabaseContentBabylonAPI(taskNumber: 3) { (MovieInfo3) in
                            if let MovieInfo3 = MovieInfo3 {
                                TopRatedMovieInfo = MovieInfo3
                                DispatchQueue.global().async {
                                    var images: [Data] = []
                                    var titles: [String] = []
                                    var dates: [String] = []
                                    var overviews: [String] = []
                                    for k in 0..<TopRatedMovieInfo.count {
                                        let movie = TopRatedMovieInfo[k] as! [String: Any]
                                        let poster_path = movie["poster_path"] as! String
                                        let movieTitle = movie["title"] as! String
                                        let movieReleaseDate = movie["release_date"]
                                        let movieOverview = movie["overview"]
                                        let strURL = "https://image.tmdb.org/t/p/original/" + poster_path
                                        let imageURL = URL(string: strURL)!
                                        do {
                                            let data = try Data(contentsOf: imageURL)
                                            images.append(data)
                                            titles.append(movieTitle)
                                            dates.append(movieReleaseDate as! String)
                                            overviews.append(movieOverview as! String)
                                        } catch  {
                                            print(error)
                                        }
                                    }
                                    DispatchQueue.main.sync {
                                        ActivityIndicator3 = true
                                        print("A3 On")
                                        
                                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
                                            TopRatedMoviePosterData = images
                                            TopRatedDetailsPosters = images
                                            TopRatedDetailsTitles = titles
                                            TopRatedDetailsReleaseDates = dates
                                            TopRatedDetailsMovieOverviews = overviews
                                            Loaded3 = true
                                            ActivityIndicator3 = false
                                            print("A3 Off")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }) {
                    Settings(Started: $Started, Developer: $MarzDeveloper, spanishLang: $spanishLang, showAudience: $showAudience, nowPlaying: $nowPlaying, classOrder: $classOrder, MovieSets: $MovieSets, Language: $LanguageSetting)
                }
                if ActivityIndicator1 || ActivityIndicator2 || ActivityIndicator3 {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func LoadMovieDatabaseContentBabylonAPI(taskNumber: Int, completeData: @escaping ([Any]?) -> Void) {
        print("Loading Movies")
        //Example API Call - /3/movie/now_playing?api_key=5bbf70742ff5480a08fefe89bd22d7f3&language=en
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
