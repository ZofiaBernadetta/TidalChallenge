//
//  ArtistCellView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 06.04.23.
//

import SwiftUI

struct ArtistCellView: View {
    let artist: Artist
    
    var body: some View {
        HStack {
            AsyncImage(url: artist.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .mask(Circle())
            .overlay {
                Circle()
                .stroke(.gray.opacity(0.1))
            }
            Text(artist.name)
        }
    }
}

struct ArtistCellView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistCellView(artist: Artist(id: 0, imageURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/fccc34e10bfd8fbe4014c83acf2e3b15/1000x1000-000000-80-0-0.jpg")!, name: "Prince"))
    }
}
