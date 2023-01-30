//
//  Page.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 1/2/23.
//

import Foundation

struct Page: Equatable {
    let pages: Int
}

// MARK: - Decodable

extension Page: Decodable {}
