//
//  Settings.swift
//  MovieBox
//
//  Created by Mariano Manuel on 5/16/21.
//

import SwiftUI

struct Settings: View {
    @Environment (\.presentationMode) var presentationMode
    @Binding var Started: Bool
    @Binding var Developer: String
    @Binding var spanishLang: Bool
    @Binding var showAudience: Bool
    @Binding var nowPlaying: String
    @Binding var classOrder: String
    @Binding var MovieSets: Int
    @Binding var Language: String
    
    var body: some View {
        Form() {
            Section(header: Text("Language / Idioma")) {
                Toggle(isOn: $spanishLang, label: {
                    Text("English / Español")
                })
            }
            .padding()
            
            Section(header: Text("Classification Order / Orden de Clasificación")) {
                Toggle(isOn: $showAudience, label: {
                    Text("Popular / Top Rated (Premiadas)")
                })
            }
            .padding()
            
            Section(header: Text("Confirm / Confirmar")) {
                HStack {
                    Spacer()
                    Button(action: {
                        if spanishLang {
                        Language = "Español"
                            nowPlaying = "ESTRENOS"
                            if showAudience {
                                classOrder = "PREMIADAS"
                                MovieSets = 2
                            } else {
                                classOrder = "POPULAR"
                                MovieSets = 1
                            }
                        } else {
                            Language = "English"
                            nowPlaying = "NOW PLAYING"
                            if showAudience {
                                classOrder = "TOP RATED"
                                MovieSets = 2
                            } else {
                                classOrder = "POPULAR"
                                MovieSets = 1
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("OK")
                    })
                }
            }
            .padding()
            
            Section(header: Text("Accreditation / Acreditación")) {
                Text("MovieDB")
            }
            .padding()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(Started: .constant(false), Developer: .constant("A"), spanishLang: .constant(true), showAudience: .constant(true), nowPlaying: .constant("B"), classOrder: .constant("C"), MovieSets: .constant(0), Language: .constant("D"))
        
    }
}
