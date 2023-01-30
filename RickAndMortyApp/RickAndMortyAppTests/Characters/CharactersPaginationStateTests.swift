//
//  CharactersPaginationStateTests.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 31/1/23.
//

import XCTest
@testable import RickAndMortyApp

final class CharactersPaginationStateTests: XCTestCase {
    // MARK: - hasNext
    
    func testNotLoadedAny() {
        let sut = CharactersPaginationState(total: nil, loaded: [])
        
        XCTAssertTrue(sut.hasNext)
    }
    
    func testNotLoadedAll() {
        let sut = CharactersPaginationState(total: 2, loaded: [1])
        
        XCTAssertTrue(sut.hasNext)
    }
    
    func testLoadedAll() {
        let sut = CharactersPaginationState(total: 2, loaded: [1, 2])
        
        XCTAssertFalse(sut.hasNext)
    }
    
    // MARK: - next
    
    func testNotLoadedAnyPage() {
        let sut = CharactersPaginationState(total: nil, loaded: [])
        
        XCTAssertEqual(sut.next, 1)
    }
    
    func testNotLoadedAllPages() {
        let sut = CharactersPaginationState(total: 2, loaded: [1])
        
        XCTAssertEqual(sut.next, 2)
    }
    
    func testLoadedAllPages() {
        let sut = CharactersPaginationState(total: 2, loaded: [1, 2])
        
        XCTAssertNil(sut.next)
    }
}
