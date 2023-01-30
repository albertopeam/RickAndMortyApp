//
//  CharacterStateTests.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 31/1/23.
//

import XCTest
@testable import RickAndMortyApp

final class CharactersStateTests: XCTestCase {
    
    private var character: Character!
    private var pagination: CharactersPaginationState!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        character = .init(id: 1, image: nil, name: "Morty", status: .alive)
        pagination = .init(total: 2, loaded: [1])
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        character = nil
        pagination = nil
    }
    
    // MARK: - gridIcon
    
    func testIsGridShowTableIcon() throws {
        let sut = CharactersState(characters: [], isGrid: true, pagination: pagination, loading: true)
        
        XCTAssertEqual(sut.gridIcon, "rectangle.grid.1x2")
    }
    
    func testIsNotGridIcon() throws {
        let sut = CharactersState(characters: [], isGrid: false, pagination: pagination, loading: true)
        
        XCTAssertEqual(sut.gridIcon, "square.grid.2x2")
    }
    
    // MARK: - columns
    
    func testIsGridShowTwoColumns() throws {
        let sut = CharactersState(characters: [], isGrid: true, pagination: pagination, loading: true)
        
        XCTAssertEqual(sut.columns.count, 2)
    }
    
    func testIsNotGridShowOneColumn() throws {
        let sut = CharactersState(characters: [], isGrid: false, pagination: pagination, loading: true)
        
        XCTAssertEqual(sut.columns.count, 1)
    }
    
    // MARK: - needsToLoadMore
    
    func testNeedsToLoadMore() {
        let sut = CharactersState(characters: [], isGrid: false, pagination: .init(total: 1, loaded: []), loading: true)
        
        XCTAssertTrue(sut.needsToLoadMore)
    }
    
    func testNotNeedsToLoadMore() {
        let sut = CharactersState(characters: [], isGrid: false, pagination: .init(total: 2, loaded: [1, 2]), loading: true)
        
        XCTAssertFalse(sut.needsToLoadMore)
    }
    
    // MARK: - isLoading
    
    func testLoadingTrue() {
        let sut = CharactersState(characters: [], isGrid: false, pagination: pagination, loading: true)
        
        XCTAssertTrue(sut.isLoading)
    }
    
    func testLoadingFalse() {
        let sut = CharactersState(characters: [], isGrid: false, pagination: pagination, loading: false)
        
        XCTAssertFalse(sut.isLoading)
    }
    
    // MARK: - isLoadingFresh
    
    func testCharactersAndLoading() {
        let sut = CharactersState(characters: [character], isGrid: false, pagination: pagination, loading: true)
        
        XCTAssertFalse(sut.isLoadingFresh)
    }
    
    func testCharactersAndNotLoading() {
        let sut = CharactersState(characters: [character], isGrid: false, pagination: pagination, loading: false)
        
        XCTAssertFalse(sut.isLoadingFresh)
    }
    
    func testNotCharactersAndLoading() {
        let sut = CharactersState(characters: [], isGrid: false, pagination: pagination, loading: true)
        
        XCTAssertTrue(sut.isLoadingFresh)
    }
    
    func testNotCharactersAndNotLoading() {
        let sut = CharactersState(characters: [], isGrid: false, pagination: pagination, loading: false)
        
        XCTAssertFalse(sut.isLoadingFresh)
    }
}
