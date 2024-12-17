//
//  SongCardView.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 10/12/24.
//

import SwiftUI
import MusicKit

struct SongCardView: View {
    let song: Song

    var body: some View {
        
        VStack(alignment: .leading) {
            if let artwork = song.artwork {
                AsyncImage(url: artwork.url(width: 300, height: 300)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                        .frame(width: 300, height: 300)
                }
            }

            Text(song.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            Text(song.artistName)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            
        }
        
    }
}

