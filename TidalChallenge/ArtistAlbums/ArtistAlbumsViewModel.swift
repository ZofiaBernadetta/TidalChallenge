//
//  ArtistAlbumsViewModel.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import Foundation

@MainActor
final class ArtistAlbumsViewModel: ObservableObject {
    let deezerClient = DeezerClient()
    @Published var state = State.loading

    enum State {
        case loading
        case albums([Album])
        case failure
    }

    func loadAlbums(artist: Artist) async {
        do {
            let albums = try await deezerClient.loadAlbums(for: artist)
            state = .albums(albums)
        } catch {
            state = .failure
        }
    }
}
