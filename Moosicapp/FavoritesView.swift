//
//  FavoritesView.swift.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 10/12/24.
//

import SwiftUI
import MusicKit

struct FavoritesView: View {
    @Binding var favorites: [Song]

    
    
    var body: some View {
        
        
        List {
            if favorites.isEmpty {
                Text("No favorites yet!")
                    .foregroundColor(.gray)
            } else {
                ForEach(favorites, id: \.id) { song in
                    SongCardView(song: song)
                }
                
            }
        }
        .navigationTitle("Favorites")
        .background(.black)
       
    }
    
    
}



