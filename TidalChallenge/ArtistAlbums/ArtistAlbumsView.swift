//
//  ArtistAlbumsView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import SwiftUI

struct ArtistAlbumsView: View {
    var artist: Artist
    @StateObject private var model = ArtistAlbumsViewModel()
    
    var body: some View {
        Group {
            switch model.state {
            case .loading:
                ProgressView()
            case .albums(let albums):
                AlbumsView(albums: albums)
            case .failure:
                EmptyContentView {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Failed to load Albums.")
                }
            }
        }
        .navigationTitle(artist.name)
        .task {
            await model.loadAlbums(artist: artist)
        }
    }
}

struct ArtistsAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistAlbumsView(artist: Artist(id: 1, imageURL: URL(string: "")!, name: ""))
    }
}
