//
//  TestState.swift
//  RickAndMortyAppTests
//
//  Created by albertopeam on 2/2/23.
//

import Foundation

struct TestState: Equatable {
    let count: Int

    init() {
        self.count = 0
    }
    
    init(count: Int) {
        self.count = count
    }
}
