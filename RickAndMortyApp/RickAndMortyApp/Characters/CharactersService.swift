//
//  CharactersService.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 31/1/23.
//

import SwiftUI

/**
 Interface to interact with Characters API
 */
protocol CharactersService {
    /**
     Get characters paginated
     - Parameters: page, the requested page
     - Returns the characters and the page loaded
     */
    func getCharacters(page: Int) async throws -> CharactersServiceOutput
}

struct CharactersServiceOutput {
    let characters: [Character]
    let page: Page
}

enum CharactersServiceError: LocalizedError {
    case internalError(url: String)
    
    var errorDescription: String? {
        switch self {
        case let .internalError(url):
            return "Internal error creating the URL(string: \(url))"
        }
    }
}
