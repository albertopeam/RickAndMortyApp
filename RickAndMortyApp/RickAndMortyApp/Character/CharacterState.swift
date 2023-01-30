//
//  CharacterState.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 30/1/23.
//

import SwiftUI

struct CharacterState {
    let character: Character
    var showName: Bool = false
    
    var name: String {
        showName ? character.name : ""
    }

    var openIcon: String {
        showName ? "chevron.compact.right": "chevron.compact.left"
    }
    
    var statusColor: Color {
        switch character.status {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return Color(UIColor.systemGray)
        }
    }
}
