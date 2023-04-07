//
//  APIRequest.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

protocol APIRequest {
    associatedtype Response: Decodable
    var endpoint: String { get }
    var method: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
}
