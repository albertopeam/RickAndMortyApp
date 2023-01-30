//
//  CharactersStorageService.swift
//  RickAndMortyApp
//
//  Created by albertopeam on 2/2/23.
//

import Foundation

/**
 Interface to interact with storage related to characters
 */
protocol CharactersStorageService {
    /**
    Gets/Sets the grid layout type: if true is grid, false otherwise
     */
    var isGrid: Bool { get set }
}
