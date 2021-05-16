//
//  Movies.swift
//  MovieBox
//
//  Created by Mariano Manuel on 4/18/21.
//

import SwiftUI

struct Movies: View {
    @State var showSettings: Bool = false
    @State var spanishLang: Bool = false
    @State var showAudience: Bool = false
    @State var nowPlaying: String = "NOW PLAYING"
    @State var classOrder: String = "POPULAR"
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
            .navigationBarTitle("MovieBox")
            .toolbar(content: {
                Button(action: {
                    showSettings = true
                }, label: {
                    Image(systemName: "info.circle")

                })
            })
            .sheet(isPresented: $showSettings) {
                Settings(spanishLang: $spanishLang, showAudience: $showAudience, nowPlaying: $nowPlaying, classOrder: $classOrder)
            }
        }
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
