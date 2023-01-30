//
//  RickAndMortyAppTests.swift
//  RickAndMortyAppTests
//
//  Created by Alberto Penas Amor on 27/1/23.
//

import XCTest
import SwiftUI
@testable import RickAndMortyApp

final class CharacterStateTests: XCTestCase {

    private var character: Character!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        character = .init(id: 1, image: nil, name: "Morty", status: .alive)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        character = nil
    }
    
    // MARK: - name
    
    func testShowName() throws {
        let sut = CharacterState(character: character, showName: true)
        
        XCTAssertEqual(sut.name, "Morty")
    }
    
    func testHideName() throws {
        let sut = CharacterState(character: character, showName: false)
        
        XCTAssertEqual(sut.name, "")
    }
    
    // MARK: - name
    
    func testShowIcon() throws {
        let sut = CharacterState(character: character, showName: false)
        
        XCTAssertEqual(sut.openIcon, "chevron.compact.left")
    }
    
    func testHideIcon() throws {
        let sut = CharacterState(character: character, showName: true)
        
        XCTAssertEqual(sut.openIcon, "chevron.compact.right")
    }
    
    // MARK: - statusColor
    
    func testStatusAlive() {
        character = .init(id: 1, image: nil, name: "Morty", status: .alive)
        
        let sut = CharacterState(character: character)
        
        XCTAssertEqual(sut.statusColor, .green)
    }
    
    func testStatusDead() {
        character = .init(id: 1, image: nil, name: "Morty", status: .dead)
        
        let sut = CharacterState(character: character)
        
        XCTAssertEqual(sut.statusColor, .red)
    }
    
    func testStatusUnknown() {
        character = .init(id: 1, image: nil, name: "Morty", status: .unknown)
        
        let sut = CharacterState(character: character)
        
        XCTAssertEqual(sut.statusColor, Color(UIColor.systemGray))
    }
}
