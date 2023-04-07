//
//  AlbumTracks.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import Foundation

struct AlbumTracks: Identifiable, Hashable {
    var id: Int
    var title: String
    var coverURL: URL
    var artist: String
    var tracks: [Track]
}

struct Track: Identifiable, Hashable {
    var id: Int
    var index: Int
    var title: String
    var duration: Int
    var artist: String
}
