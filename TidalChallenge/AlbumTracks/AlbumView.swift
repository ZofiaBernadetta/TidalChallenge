//
//  AlbumView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import SwiftUI

struct AlbumView: View {
    var album: Album

    @StateObject private var model = AlbumViewViewModel()

    var body: some View {
        Group {
            switch model.state {
            case .loading:
                ProgressView()
            case .album(let album):
                AlbumTracksView(album: album)
            case .failure:
                EmptyContentView {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Failed to load Album.")
                }
            }
        }
        .navigationTitle(album.name)
        .task {
            await model.loadAlbum(albumID: album.id)
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(album: Album(id: 1, name: "+", coverURL: URL(string: "")!, artistName: "Ed Sheeran"))
    }
}
