//
//  CharactersStorageService.swift
//  RickAndMortyApp
//
//  Created by albertopeam on 2/2/23.
//

import Foundation

struct CharactersStorageServiceAdapter: CharactersStorageService {
    private let defaults: UserDefaults
    private let isGridLayoutKey = "Characters.isGridKey"
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    var isGrid: Bool {
        get {
            return defaults.bool(forKey: isGridLayoutKey)
        }
        set {
            defaults.setValue(newValue, forKey: isGridLayoutKey)
        }
    }
}
