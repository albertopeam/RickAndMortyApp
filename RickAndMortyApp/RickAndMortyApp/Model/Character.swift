//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 30/1/23.
//

import Foundation

protocol Asd: Equatable {
    var string: String { get }
}

struct Character: Equatable {
    let id: Int
    let image: URL?
    let name: String
    let status: CharacterStatus
}

enum CharacterStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - Decodable

extension Character: Decodable {}

extension CharacterStatus: Decodable {}

// MARK: - Identifiable

extension Character: Identifiable {}
