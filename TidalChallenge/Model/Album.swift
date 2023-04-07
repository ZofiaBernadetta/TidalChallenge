//
//  Album.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 06.04.23.
//

import Foundation

struct Album: Identifiable, Hashable {
    let id: Int
    let name: String
    let coverURL: URL
    let artistName: String
}
