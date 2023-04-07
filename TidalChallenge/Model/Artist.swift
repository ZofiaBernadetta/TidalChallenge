//
//  Artist.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 06.04.23.
//

import Foundation

struct Artist: Identifiable, Hashable {
    let id: Int
    let imageURL: URL
    let name: String
}
