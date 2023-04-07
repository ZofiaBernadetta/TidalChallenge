//
//  AlbumCellView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 06.04.23.
//

import SwiftUI

struct AlbumCellView: View {
    let album: Album
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: album.coverURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    Color.clear
                    ProgressView()
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 0.1)
            )

            Text(album.name)
                .font(.headline)
            Text(album.artistName)
                .font(.subheadline)
        }

    }
}

struct AlbumCellView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCellView(album: Album(id: 1, name: "Prince", coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/19cc38f9d69b352f718782e7a22f9c32/56x56-000000-80-0-0.jpg")!, artistName: "Eminem"))
    }
}
