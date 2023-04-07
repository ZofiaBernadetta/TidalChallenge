//
//  ArtistSearchViewModel.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import Foundation

@MainActor
final class ArtistSearchViewModel: ObservableObject {
    @Published var queryString = "" {
        didSet {
            searchStringChanged()
        }
    }

    @Published var artists = [Artist]()
    @Published var failedToLoadArtists = false
    @Published var isLoading = false

    let deezerClient = DeezerClient()
    var searchTask: Task<Void, Never>?

    private func searchStringChanged() {
        searchTask?.cancel()
        guard queryString != "" else {
            artists = []
            isLoading = false
            return
        }
        searchTask = Task {
            do {
                isLoading = true
                let artists = try await deezerClient.searchArtists(for: queryString)
                guard !Task.isCancelled else { return }
                self.artists = artists
                failedToLoadArtists = false
                isLoading = false
            } catch {
                guard !Task.isCancelled else { return }
                failedToLoadArtists = true
                isLoading = false
            }
        }
    }
}
