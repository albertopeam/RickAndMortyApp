//
//  CharactersReducerTests.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 31/1/23.
//

import XCTest
@testable import RickAndMortyApp

final class CharactersReducerTests: XCTestCase {
    
    private var character: Character!
    private var serviceLocatorMock: CharactersLocatorMock!
    private var sut: CharactersReducer!

    override func setUpWithError() throws {
        try super.setUpWithError()
        character = .init(id: 1, image: nil, name: "Morty", status: .alive)
        serviceLocatorMock = .init()
        sut = .init(serviceLocator: serviceLocatorMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        character = nil
        serviceLocatorMock = nil
        sut = nil
    }

    // MARK: - Toggle layout
    
    func testToggleLayout() async throws {
        let initialState = CharactersState()

        let noGridState = try await sut.reducer(state: initialState, action: .toggleLayout).first()
        XCTAssertFalse(noGridState.isGrid)

        let gridState = try await sut.reducer(state: noGridState, action: .toggleLayout).first()
        XCTAssertTrue(gridState.isGrid)
    }
    
    // MARK: - Load
    
    func testLoadSuccess() async {
        serviceLocatorMock.charactersStorageService.getIsGrid = false
        serviceLocatorMock.charactersService.output = { .init(characters: [self.character], page: .init(pages: 2))}
        
        let states = await sut.reducer(state: .init(), action: .load).values()
        
        XCTAssertEqual(states.first, .init(characters: [], isGrid: false, pagination: .init(total: nil, loaded: []), loading: true))
        XCTAssertEqual(states.dropFirst().first, .init(characters: [character], isGrid: false, pagination: .init(total: 2, loaded: [1]), loading: false))
    }
        
    func testLoadError() async {
        serviceLocatorMock.charactersStorageService.getIsGrid = true
        serviceLocatorMock.charactersService.output = { throw NSError() }
        
        let states = await sut.reducer(state: .init(), action: .load).values()
        
        XCTAssertEqual(states.first, .init(characters: [], isGrid: true, pagination: .init(total: nil, loaded: []), loading: true))
        XCTAssertEqual(states.dropFirst().first, .init(characters: [], isGrid: true, pagination: .init(total: nil, loaded: []), loading: false, error: NSLocalizedString("characters_error", comment: "")))
    }
    
    func testLoadErrorNotRemoveCharacters() async {
        serviceLocatorMock.charactersStorageService.getIsGrid = false
        serviceLocatorMock.charactersService.output = { throw NSError() }
        
        let states = await sut.reducer(state: .init(characters: [character], isGrid: true, pagination: .init(total: 2, loaded: [1]), loading: false), action: .load).values()
        
        XCTAssertEqual(states.first, .init(characters: [character], isGrid: false, pagination: .init(total: 2, loaded: [1]), loading: true))
        XCTAssertEqual(states.dropFirst().first, .init(characters: [character], isGrid: false, pagination: .init(total: 2, loaded: [1]), loading: false, error: NSLocalizedString("characters_error", comment: "")))
    }
    
    // MARK: - Refresh
    
    func testRefreshSuccessFromSuccess() async {
        serviceLocatorMock.charactersStorageService.getIsGrid = false
        serviceLocatorMock.charactersService.output = { .init(characters: [self.character], page: .init(pages: 2))}
        
        let states = await sut.reducer(state: .init(characters: [character], isGrid: false, pagination: .init(total: 2, loaded: [1]), loading: false), action: .refresh).values()
        
        XCTAssertEqual(states.first, .init(characters: [], isGrid: false, pagination: .init(total: nil, loaded: []), loading: true))
        XCTAssertEqual(states.dropFirst().first, .init(characters: [character], isGrid: false, pagination: .init(total: 2, loaded: [1]), loading: false))
    }
    
    func testRefreshSuccessFromError() async {
        serviceLocatorMock.charactersStorageService.getIsGrid = false
        serviceLocatorMock.charactersService.output = { .init(characters: [self.character], page: .init(pages: 2))}
        
        let states = await sut.reducer(state: .init(characters: [character], isGrid: false, pagination: .init(total: 2, loaded: [1]), loading: false, error: "error"), action: .refresh).values()
        
        XCTAssertEqual(states.first, .init(characters: [], isGrid: false, pagination: .init(total: nil, loaded: []), loading: true, error: nil))
        XCTAssertEqual(states.dropFirst().first, .init(characters: [character], isGrid: false, pagination: .init(total: 2, loaded: [1]), loading: false, error: nil))
    }
    
    // MARK: - AckError
    
    func testAckError() async throws {
        let state = try await sut.reducer(state: .init(characters: [character], isGrid: false, pagination: .init(total: nil, loaded: []), loading: false, error: "error"), action: .ackError).first()
        
        XCTAssertEqual(state, .init(characters: [character], isGrid: false, pagination: .init(total: nil, loaded: []), loading: false, error: nil))
    }
}
