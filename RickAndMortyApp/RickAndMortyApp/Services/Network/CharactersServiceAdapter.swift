//
//  CharactersServicePort.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 31/1/23.
//

import Foundation

struct CharactersServiceAdapter: CharactersService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getCharacters(page: Int) async throws -> CharactersServiceOutput {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        guard page > 0, let url = URL(string: urlString) else {
            throw CharactersServiceError.internalError(url: urlString)
        }
        let response = try await httpClient.data(for: url)
        let result = try JSONDecoder().decode(Response.self, from: response.0)
        return CharactersServiceOutput(characters: result.results, page: result.info)
    }
}

private struct Response: Decodable {
    let results: [Character]
    let info: Page
}
