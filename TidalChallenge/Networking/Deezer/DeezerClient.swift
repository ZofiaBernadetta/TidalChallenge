//
//  DeezerClient.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import Foundation

final class DeezerClient {
    var apiClient: any APIClientProtocol = APIClient(
        baseURL: URL(string: "https://api.deezer.com")!,
        decoder: {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
    )

    func searchArtists(for query: String) async throws -> [Artist] {
        let response = try await apiClient.fetch(
            request: ArtistSearchRequest(query: query)
        )

        return response.data.map {
            Artist(id: $0.id, imageURL: $0.pictureXl, name: $0.name)
        }
    }

    func loadAlbums(for artist: Artist) async throws -> [Album] {
        let response = try await apiClient.fetch(
            request: ArtistAlbumsRequest(artistID: artist.id)
        )

        return response.data.map {
            Album(id: $0.id, name: $0.title, coverURL: $0.coverXl, artistName: artist.name)
        }
    }

    func loadAlbum(for albumID: Int) async throws -> AlbumTracks {
        let response = try await apiClient.fetch(
            request: TracksRequest(albumID: albumID)
        )

        return AlbumTracks(
            id: response.id,
            title: response.title,
            coverURL: response.coverXl,
            artist: response.artist.name,
            tracks: response.tracks.data.enumerated().map { (index, track) in
                Track(
                    id: track.id,
                    index: index + 1,
                    title: track.title,
                    duration: track.duration,
                    artist: track.artist.name
                )
            }
        )
    }
}
