//
//  DeezerRequests.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import Foundation

struct ArtistSearchRequest: APIRequest {
    var query: String
    let endpoint = "/search/artist"
    let method = "GET"
    var parameters: [String: String] {
        ["q": query]
    }

    let headers = [String: String]()

    struct Response: Codable {
        struct Artist: Codable {
            var id: Int
            var name: String
            var pictureXl: URL
        }

        var data: [Artist]
    }
}

struct ArtistAlbumsRequest: APIRequest {
    var artistID: Int
    var endpoint: String {
        "/artist/\(artistID)/albums"
    }

    let method = "GET"
    let parameters = [String: String]()
    let headers = [String: String]()

    struct Response: Codable {
        struct Album: Codable {
            var id: Int
            var title: String
            var coverXl: URL
        }

        var data: [Album]
    }
}

struct TracksRequest: APIRequest {
    var albumID: Int
    var endpoint: String {
        "/album/\(albumID)"
    }

    let method = "GET"
    let parameters = [String: String]()
    let headers = [String: String]()

    struct Response: Codable {
        struct Artist: Codable {
            var name: String
        }

        struct Track: Codable {
            var id: Int
            var title: String
            var duration: Int
            var artist: TrackArtist
        }

        struct TrackArtist: Codable {
            var name: String
        }

        struct Tracks: Codable {
            var data: [Track]
        }

        var id: Int
        var title: String
        var coverXl: URL
        var tracks: Tracks
        var artist: Artist
    }
}
