//
//  Stream+Tests.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 1/2/23.
//

@testable import RickAndMortyApp

extension Stream {
    func values() async -> [T] {
        var values: [T] = .init()
        for await value in self {
            values.append(value)
        }
        return values
    }
    
    func first() async throws -> T {
        if let value = await values().first {
            return value
        } else {
            throw Error.moreThanOneValue
        }
    }
}

extension Stream {
    enum Error: Swift.Error {
        case moreThanOneValue
    }
}
