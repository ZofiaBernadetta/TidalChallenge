//
//  AlbumViewViewModel.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import Foundation

@MainActor
final class AlbumViewViewModel: ObservableObject {
    let deezerClient = DeezerClient()
    @Published var state = State.loading

    enum State {
        case loading
        case album(AlbumTracks)
        case failure
    }

    func loadAlbum(albumID: Int) async {
        do {
            let album = try await deezerClient.loadAlbum(for: albumID)
            state = .album(album)
        } catch {
            state = .failure
        }
    }
}
