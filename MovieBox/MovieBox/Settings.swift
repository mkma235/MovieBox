//
//  Settings.swift
//  MovieBox
//
//  Created by Mariano Manuel on 5/16/21.
//

import SwiftUI

struct Settings: View {
    @Environment (\.presentationMode) var presentationMode
    @Binding var spanishLang: Bool
    @Binding var showAudience: Bool
    @Binding var nowPlaying: String
    @Binding var classOrder: String
    
    var body: some View {
        Form() {
            Section(header: Text("Language / Idioma")) {
                Toggle(isOn: $spanishLang, label: {
                    Text("English / Español")
                })
            }
            .padding()
            Section(header: Text("Classification Order / Orden de clasificación")) {
                Toggle(isOn: $showAudience, label: {
                    Text("Popular / Audience (Audiencia)")
                })
            }
            .padding()
            HStack {
                Spacer()
                Button(action: {
                    if spanishLang {
                        nowPlaying = "ESTRENOS"
                        if showAudience {
                            classOrder = "MAYOR AUDIENCIA"
                        } else {
                            classOrder = "POPULAR"
                        }
                    } else {
                        nowPlaying = "NOW PLAYING"
                        if showAudience {
                            classOrder = "HIGHER AUDIENCE"
                        } else {
                            classOrder = "POPULAR"
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("OK")
                })
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(spanishLang: .constant(false), showAudience: .constant(false), nowPlaying: .constant("NOW PLAYING"), classOrder: .constant("POPULAR"))
    }
}
