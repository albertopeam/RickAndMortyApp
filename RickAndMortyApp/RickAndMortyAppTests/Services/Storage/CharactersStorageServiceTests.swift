//
//  CharactersStorageServiceTests.swift
//  RickAndMortyAppTests
//
//  Created by albertopeam on 2/2/23.
//

import XCTest
@testable import RickAndMortyApp

final class CharactersStorageServiceTests: XCTestCase {
    
    private var sut: CharactersStorageServiceAdapter!
    private var userDefaultsMock: UserDefaultsMock!
    private var isGridLayoutKey: String!

    override func setUpWithError() throws {
        try super.setUpWithError()
        userDefaultsMock = .init()
        isGridLayoutKey = "Characters.isGridKey"
        sut = .init(defaults: userDefaultsMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        userDefaultsMock = nil
        isGridLayoutKey = nil
        sut = nil
    }

    func testGet() throws {
        _ = sut.isGrid
        
        XCTAssertEqual(userDefaultsMock.getBoolKey, isGridLayoutKey)
    }
    
    func testSetFalse() throws {
        sut.isGrid = false
        XCTAssertEqual(userDefaultsMock.setBoolKey, isGridLayoutKey)
        XCTAssertFalse(try XCTUnwrap(userDefaultsMock.setBoolValue))
    }
    
    func testSetTrue() throws {
        sut.isGrid = true
        XCTAssertEqual(userDefaultsMock.setBoolKey, isGridLayoutKey)
        XCTAssertTrue(try XCTUnwrap(userDefaultsMock.setBoolValue))
    }
}
