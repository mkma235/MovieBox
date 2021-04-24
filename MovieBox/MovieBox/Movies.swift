//
//  Movies.swift
//  MovieBox
//
//  Created by Mariano Manuel on 4/18/21.
//

import SwiftUI

struct Movies: View {
    private var gridLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            List() {
                Section(header: Text("NOW PLAYING")) {
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
                
                Section(header: Text("POPULAR")) {
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
        }
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
