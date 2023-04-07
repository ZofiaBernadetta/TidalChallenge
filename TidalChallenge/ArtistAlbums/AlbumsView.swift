//
//  AlbumsView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 06.04.23.
//

import SwiftUI

struct AlbumsView: View {
    let albums: [Album]
    var columns = [GridItem(.adaptive(minimum: 150), spacing: 16, alignment: .top)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(albums) { album in
                    NavigationLink {
                        AlbumView(album: album)
                    } label: {
                        AlbumCellView(album: album)
                    }
                }
                .buttonStyle(.plain)
            }
            .padding([.leading, .trailing])
        }
    }
}


struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView(albums: [
            Album(id: 123, name: "Discovery", coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!, artistName: "Daft Punk"),
            Album(id: 124, name: "Discovery", coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!, artistName: "Daft Punk"),
            Album(id: 125, name: "Discovery", coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!, artistName: "Daft Punk"),
            Album(id: 126, name: "Discovery", coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!, artistName: "Daft Punk"),
            Album(id: 127, name: "Discovery", coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!, artistName: "Daft Punk"),
            Album(id: 128, name: "Discovery", coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!, artistName: "Daft Punk"),
            ]
        )
    }
}
