//
//  DeezerClientTests.swift
//  TidalChallengeTests
//
//  Created by Zofia Drabek on 06.04.23.
//

import XCTest
@testable import TidalChallenge

final class TidalChallengeTests: XCTestCase {
    var mockAPIClient: MockAPIClient!
    var deezerClient: DeezerClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPIClient = MockAPIClient()
        deezerClient = DeezerClient()
        deezerClient.apiClient = mockAPIClient
    }

    func testSearchArtists() async throws {
        mockAPIClient.responseJSON = """
            {
              "data": [
                {
                  "id": 10183,
                  "name": "Aloe Blacc",
                  "link": "https://www.deezer.com/artist/10183",
                  "picture": "https://api.deezer.com/artist/10183/image",
                  "picture_small": "https://e-cdns-images.dzcdn.net/images/artist/9c32944158f7eb8870785258e84313ff/56x56-000000-80-0-0.jpg",
                  "picture_medium": "https://e-cdns-images.dzcdn.net/images/artist/9c32944158f7eb8870785258e84313ff/250x250-000000-80-0-0.jpg",
                  "picture_big": "https://e-cdns-images.dzcdn.net/images/artist/9c32944158f7eb8870785258e84313ff/500x500-000000-80-0-0.jpg",
                  "picture_xl": "https://e-cdns-images.dzcdn.net/images/artist/9c32944158f7eb8870785258e84313ff/1000x1000-000000-80-0-0.jpg",
                  "nb_album": 78,
                  "nb_fan": 233407,
                  "radio": true,
                  "tracklist": "https://api.deezer.com/artist/10183/top?limit=50",
                  "type": "artist"
                }
              ],
              "total": 290,
              "next": "https://api.deezer.com/search/artist?q=aloe&index=25"
            }
        """

        let artists = try await deezerClient.searchArtists(for: "abc")

        XCTAssertEqual(mockAPIClient.latestRequest?.endpoint, "/search/artist")
        XCTAssertEqual(mockAPIClient.latestRequest?.method, "GET")
        XCTAssertEqual(mockAPIClient.latestRequest?.headers, [:])
        XCTAssertEqual(mockAPIClient.latestRequest?.parameters, ["q": "abc"])

        XCTAssertEqual(artists, [
            Artist(
                id: 10183,
                imageURL: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/9c32944158f7eb8870785258e84313ff/1000x1000-000000-80-0-0.jpg")!,
                name: "Aloe Blacc"
            )
        ])
    }

    func testLoadAlbums() async throws {
        mockAPIClient.responseJSON = """
            {
              "data": [
                {
                  "id": 294609352,
                  "title": "Homework (25th Anniversary Edition)",
                  "link": "https://www.deezer.com/album/294609352",
                  "cover": "https://api.deezer.com/album/294609352/image",
                  "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/117dcf85bdf0851347403796521d1e9d/56x56-000000-80-0-0.jpg",
                  "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/117dcf85bdf0851347403796521d1e9d/250x250-000000-80-0-0.jpg",
                  "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/117dcf85bdf0851347403796521d1e9d/500x500-000000-80-0-0.jpg",
                  "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/117dcf85bdf0851347403796521d1e9d/1000x1000-000000-80-0-0.jpg",
                  "md5_image": "117dcf85bdf0851347403796521d1e9d",
                  "genre_id": 113,
                  "fans": 9340,
                  "release_date": "1997-01-20",
                  "record_type": "album",
                  "tracklist": "https://api.deezer.com/album/294609352/tracks",
                  "explicit_lyrics": false,
                  "type": "album"
                },
                {
                  "id": 6575789,
                  "title": "Random Access Memories",
                  "link": "https://www.deezer.com/album/6575789",
                  "cover": "https://api.deezer.com/album/6575789/image",
                  "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/311bba0fc112d15f72c8b5a65f0456c1/56x56-000000-80-0-0.jpg",
                  "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/311bba0fc112d15f72c8b5a65f0456c1/250x250-000000-80-0-0.jpg",
                  "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/311bba0fc112d15f72c8b5a65f0456c1/500x500-000000-80-0-0.jpg",
                  "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/311bba0fc112d15f72c8b5a65f0456c1/1000x1000-000000-80-0-0.jpg",
                  "md5_image": "311bba0fc112d15f72c8b5a65f0456c1",
                  "genre_id": 113,
                  "fans": 817420,
                  "release_date": "2013-05-17",
                  "record_type": "album",
                  "tracklist": "https://api.deezer.com/album/6575789/tracks",
                  "explicit_lyrics": false,
                  "type": "album"
                }
              ],
              "total": 34,
              "next": "https://api.deezer.com/artist/27/albums?index=25"
            }
        """

        let artist = Artist(id: 10183, imageURL: URL(string: "/")!, name: "Aloe Blacc")
        let albums = try await deezerClient.loadAlbums(for: artist)

        XCTAssertEqual(mockAPIClient.latestRequest?.endpoint, "/artist/10183/albums")
        XCTAssertEqual(mockAPIClient.latestRequest?.method, "GET")
        XCTAssertEqual(mockAPIClient.latestRequest?.headers, [:])
        XCTAssertEqual(mockAPIClient.latestRequest?.parameters, [:])

        XCTAssertEqual(albums, [
            Album(
                id: 294609352,
                name: "Homework (25th Anniversary Edition)",
                coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/117dcf85bdf0851347403796521d1e9d/1000x1000-000000-80-0-0.jpg")!,
                artistName: "Aloe Blacc"
            ),
            Album(
                id: 6575789,
                name: "Random Access Memories",
                coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/311bba0fc112d15f72c8b5a65f0456c1/1000x1000-000000-80-0-0.jpg")!,
                artistName: "Aloe Blacc"
            ),
        ])
    }

    func testLoadAlbum() async throws {
        mockAPIClient.responseJSON = """
            {
              "id": 302127,
              "title": "Discovery",
              "upc": "724384960650",
              "link": "https://www.deezer.com/album/302127",
              "share": "https://www.deezer.com/album/302127?utm_source=deezer&utm_content=album-302127&utm_term=0_1680900893&utm_medium=web",
              "cover": "https://api.deezer.com/album/302127/image",
              "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg",
              "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/250x250-000000-80-0-0.jpg",
              "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/500x500-000000-80-0-0.jpg",
              "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/1000x1000-000000-80-0-0.jpg",
              "md5_image": "2e018122cb56986277102d2041a592c8",
              "genre_id": 113,
              "genres": {
                "data": [
                  {
                    "id": 113,
                    "name": "Dance",
                    "picture": "https://api.deezer.com/genre/113/image",
                    "type": "genre"
                  }
                ]
              },
              "label": "Daft Life Ltd./ADA France",
              "nb_tracks": 14,
              "duration": 3660,
              "fans": 269975,
              "release_date": "2001-03-07",
              "record_type": "album",
              "available": true,
              "tracklist": "https://api.deezer.com/album/302127/tracks",
              "explicit_lyrics": false,
              "explicit_content_lyrics": 7,
              "explicit_content_cover": 0,
              "contributors": [
                {
                  "id": 27,
                  "name": "Daft Punk",
                  "link": "https://www.deezer.com/artist/27",
                  "share": "https://www.deezer.com/artist/27?utm_source=deezer&utm_content=artist-27&utm_term=0_1680900893&utm_medium=web",
                  "picture": "https://api.deezer.com/artist/27/image",
                  "picture_small": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/56x56-000000-80-0-0.jpg",
                  "picture_medium": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/250x250-000000-80-0-0.jpg",
                  "picture_big": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/500x500-000000-80-0-0.jpg",
                  "picture_xl": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/1000x1000-000000-80-0-0.jpg",
                  "radio": true,
                  "tracklist": "https://api.deezer.com/artist/27/top?limit=50",
                  "type": "artist",
                  "role": "Main"
                }
              ],
              "artist": {
                "id": 27,
                "name": "Daft Punk",
                "picture": "https://api.deezer.com/artist/27/image",
                "picture_small": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/56x56-000000-80-0-0.jpg",
                "picture_medium": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/250x250-000000-80-0-0.jpg",
                "picture_big": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/500x500-000000-80-0-0.jpg",
                "picture_xl": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/1000x1000-000000-80-0-0.jpg",
                "tracklist": "https://api.deezer.com/artist/27/top?limit=50",
                "type": "artist"
              },
              "type": "album",
              "tracks": {
                "data": [
                  {
                    "id": 3135553,
                    "readable": true,
                    "title": "One More Time",
                    "title_short": "One More Time",
                    "title_version": "",
                    "link": "https://www.deezer.com/track/3135553",
                    "duration": 320,
                    "rank": 893141,
                    "explicit_lyrics": false,
                    "explicit_content_lyrics": 0,
                    "explicit_content_cover": 0,
                    "preview": "https://cdns-preview-e.dzcdn.net/stream/c-e77d23e0c8ed7567a507a6d1b6a9ca1b-11.mp3",
                    "md5_image": "2e018122cb56986277102d2041a592c8",
                    "artist": {
                      "id": 27,
                      "name": "Daft Punk",
                      "tracklist": "https://api.deezer.com/artist/27/top?limit=50",
                      "type": "artist"
                    },
                    "album": {
                      "id": 302127,
                      "title": "Discovery",
                      "cover": "https://api.deezer.com/album/302127/image",
                      "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg",
                      "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/250x250-000000-80-0-0.jpg",
                      "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/500x500-000000-80-0-0.jpg",
                      "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/1000x1000-000000-80-0-0.jpg",
                      "md5_image": "2e018122cb56986277102d2041a592c8",
                      "tracklist": "https://api.deezer.com/album/302127/tracks",
                      "type": "album"
                    },
                    "type": "track"
                  },
                  {
                    "id": 3135555,
                    "readable": true,
                    "title": "Digital Love",
                    "title_short": "Digital Love",
                    "title_version": "",
                    "link": "https://www.deezer.com/track/3135555",
                    "duration": 301,
                    "rank": 689436,
                    "explicit_lyrics": false,
                    "explicit_content_lyrics": 0,
                    "explicit_content_cover": 0,
                    "preview": "https://cdns-preview-0.dzcdn.net/stream/c-01ef0c4982c94b86c7c0e6b2a70dde4b-9.mp3",
                    "md5_image": "2e018122cb56986277102d2041a592c8",
                    "artist": {
                      "id": 27,
                      "name": "Daft Punk",
                      "tracklist": "https://api.deezer.com/artist/27/top?limit=50",
                      "type": "artist"
                    },
                    "album": {
                      "id": 302127,
                      "title": "Discovery",
                      "cover": "https://api.deezer.com/album/302127/image",
                      "cover_small": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg",
                      "cover_medium": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/250x250-000000-80-0-0.jpg",
                      "cover_big": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/500x500-000000-80-0-0.jpg",
                      "cover_xl": "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/1000x1000-000000-80-0-0.jpg",
                      "md5_image": "2e018122cb56986277102d2041a592c8",
                      "tracklist": "https://api.deezer.com/album/302127/tracks",
                      "type": "album"
                    },
                    "type": "track"
                  }
                ]
              }
            }
        """

        let album = try await deezerClient.loadAlbum(for: 123)

        XCTAssertEqual(mockAPIClient.latestRequest?.endpoint, "/album/123")
        XCTAssertEqual(mockAPIClient.latestRequest?.method, "GET")
        XCTAssertEqual(mockAPIClient.latestRequest?.headers, [:])
        XCTAssertEqual(mockAPIClient.latestRequest?.parameters, [:])

        XCTAssertEqual(
            album,
            AlbumTracks(
                id: 302127,
                title: "Discovery",
                coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/1000x1000-000000-80-0-0.jpg")!,
                artist: "Daft Punk",
                tracks: [
                    .init(
                        id: 3135553,
                        index: 1,
                        title: "One More Time",
                        duration: 320,
                        artist: "Daft Punk"
                    ),
                    .init(
                        id: 3135555,
                        index: 2,
                        title: "Digital Love",
                        duration: 301,
                        artist: "Daft Punk"
                    ),
                ]
            )
        )
    }
}

final class MockAPIClient: APIClientProtocol {
    struct Request {
        var endpoint: String
        var method: String
        var headers: [String: String]
        var parameters: [String: String]
    }

    var responseJSON = ""
    var latestRequest: Request?

    let jsonDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func fetch<T: APIRequest>(request: T) async throws -> T.Response {
        latestRequest = Request(
            endpoint: request.endpoint,
            method: request.method,
            headers: request.headers,
            parameters: request.parameters
        )

        return try jsonDecoder.decode(T.Response.self, from: Data(responseJSON.utf8))
    }
}
