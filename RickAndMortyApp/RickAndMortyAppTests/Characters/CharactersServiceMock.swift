//
//  CharactersServiceLocator.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 1/2/23.
//

import Foundation
@testable import RickAndMortyApp

final class CharactersServiceMock: CharactersService {
    lazy var output: () throws -> CharactersServiceOutput = fallback
    var timesInvoked: Int = 0
    
    func getCharacters(page: Int) async throws -> CharactersServiceOutput {
        timesInvoked += 1
        return try output()
    }
    
    private func fallback() throws -> CharactersServiceOutput {
        throw NSError.init()
    }
}
