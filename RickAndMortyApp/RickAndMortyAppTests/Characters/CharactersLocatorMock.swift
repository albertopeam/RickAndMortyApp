//
//  CharactersLocatorMock.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 1/2/23.
//

import Foundation
@testable import RickAndMortyApp

final class CharactersLocatorMock: CharactersServiceLocator {
    var charactersService: CharactersServiceMock = .init()
    var charactersStorageService: CharactersStorageServiceMock = .init()
    
    func service() -> CharactersService {
        return charactersService
    }
    
    func storageService() -> CharactersStorageService {
        charactersStorageService
    }
}

