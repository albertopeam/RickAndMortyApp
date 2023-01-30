//
//  CharactersPaginationState.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 31/1/23.
//

import Foundation

struct CharactersPaginationState: Equatable {
    let total: Int?
    let loaded: [Int]
    
    var next: Int? {
        if let last = loaded.last {
            if let total = total, last >= total {
                return nil
            } else {
                return last + 1
            }
        } else {
            return 1
        }
    }
    
    var hasNext: Bool {
        next != nil
    }
}
