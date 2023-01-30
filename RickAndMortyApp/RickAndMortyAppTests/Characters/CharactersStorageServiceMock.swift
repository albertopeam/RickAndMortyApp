//
//  CharactersStorageServiceMock.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 2/2/23.
//

import Foundation
@testable import RickAndMortyApp

final class CharactersStorageServiceMock: CharactersStorageService {
    var getIsGrid: Bool = false
    var getTimesInvoked: Int = 0
    var setIsGrid: Bool?
    var setTimesInvoked: Int = 0

    var isGrid: Bool {
        get {
            getTimesInvoked += 1
            return getIsGrid
        }
        set {
            setIsGrid = newValue
            setTimesInvoked += 1
        }
    }
}
