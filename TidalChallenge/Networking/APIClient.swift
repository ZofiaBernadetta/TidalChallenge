//
//  APIClient.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: APIRequest>(request: T) async throws -> T.Response
}

struct APIClient: APIClientProtocol {
    let baseURL: URL
    let decoder: JSONDecoder

    func fetch<T: APIRequest>(request: T) async throws -> T.Response {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            throw URLError(.badURL)
        }
        components.path = request.endpoint
        components.queryItems = request.parameters.map(URLQueryItem.init)

        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        urlRequest.allHTTPHeaderFields = request.headers


        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard
            let response = response as? HTTPURLResponse,
            200..<300 ~= response.statusCode
        else {
            throw URLError(.badServerResponse)
        }

        return try decoder.decode(T.Response.self, from: data)
    }
}
