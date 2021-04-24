//
//  Details.swift
//  MovieBox
//
//  Created by Mariano Manuel on 4/18/21.
//

import SwiftUI

struct Details: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "rectangle.portrait")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            Text("Title")
                .font(.largeTitle)
                .bold()
            Text("April 20, 2021 - 4h 20m")
                .padding()
            HStack {
                Spacer()
                Text("Overview:")
                    .font(.title2)
                    .bold()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            Text("This is the overview. It provides a small snippet of the storyline as well information about the setting. The main goal of the overview is to convince the viewer to watch the movie.")
                .padding()
                .multilineTextAlignment(.center)
            Text("Genres: ")
                .padding()
            HStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                Spacer()
            }
        }
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        Details()
    }
}
