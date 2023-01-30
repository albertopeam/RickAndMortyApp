//
//  HttpClient.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 1/2/23.
//

import SwiftUI

protocol HttpClient {
    func data(for url: URL) async throws -> (Data, URLResponse)
}

struct HttpClientProxy: HttpClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func data(for url: URL) async throws -> (Data, URLResponse) {
        try await urlSession.data(for: URLRequest.init(url: url))
    }
}
