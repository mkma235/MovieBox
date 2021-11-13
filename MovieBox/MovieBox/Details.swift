//
//  Details.swift
//  MovieBox
//
//  Created by Mariano Manuel on 4/18/21.
//

import SwiftUI

struct Details: View {
    @Binding var Poster: Data
    @Binding var Title: String
    @Binding var ReleaseDate: String
    @Binding var MovieOverview: String
    
    var body: some View {
        VStack {
            Group {
                Spacer()
                Image(uiImage: UIImage(data: Poster)!)
                    .resizable()
                    .scaledToFit()
                    .padding()
                Spacer()
                Text(Title)
                    .font(.largeTitle)
                    .bold()
                Text(ReleaseDate)
                    .padding()
                Text("Overview / Visión General: ")
                    .font(.title2)
                    .bold()
                    .padding()
                Spacer()
                Text(MovieOverview)
                    .lineLimit(9)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        Details(Poster: .constant(Data()), Title: .constant("Title"), ReleaseDate: .constant("April 20, 2021"), MovieOverview: .constant("Overview"))
    }
}
