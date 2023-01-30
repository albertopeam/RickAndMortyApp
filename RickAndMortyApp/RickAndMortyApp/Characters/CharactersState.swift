//
//  CharactersState.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 30/1/23.
//

import SwiftUI

struct CharactersState: Equatable {
    private let _loading: Bool
    let characters: [Character]
    let pagination: CharactersPaginationState
    let isGrid: Bool
    let error: String?
    
    var gridIcon: String {
        isGrid ? "rectangle.grid.1x2" : "square.grid.2x2"
    }
    
    var columns: [GridItem] {
        isGrid ? [GridItem(.flexible()), GridItem(.flexible())] : [GridItem(.flexible())]
    }
    
    var needsToLoadMore: Bool {
        pagination.hasNext
    }
    
    var isLoadingFresh: Bool {
        _loading && characters.isEmpty
    }
    
    var isLoading: Bool {
        _loading
    }
    
    /// initial state constructor
    init() {
        characters = []
        _loading = false
        isGrid = true
        error = nil
        pagination = .init(total: nil, loaded: [])
    }
    
    /// constructor
    init(characters: [Character], isGrid: Bool, pagination: CharactersPaginationState, loading: Bool, error: String? = nil) {
        self.isGrid = isGrid
        self.characters = characters
        self.pagination = pagination
        self._loading = loading
        self.error = error
    }
    
    /**
    Returns a new instance with the isGrid state updated
    - Returns: A new instance
     */
    func isGrid(_ newValue: Bool) -> Self {
        .init(characters: characters, isGrid: newValue, pagination: pagination, loading: _loading)
    }
    
    /**
    Returns a new instance with loading state
    - Returns: A new instance
     */
    func loading() -> Self {
        .init(characters: characters, isGrid: isGrid, pagination: pagination, loading: true)
    }
    
    /**
    Returns a new instance cleaning characters and pagination
    - Returns: A new instance
     */
    func refresh() -> Self {
        .init(characters: [], isGrid: isGrid, pagination: .init(total: nil, loaded: []), loading: true)
    }
    
    /**
    Returns a new instance with the opposite layout
    - Returns: A new instance
     */
    func changeLayout() -> Self {
        .init(characters: characters, isGrid: !isGrid, pagination: pagination, loading: false)
    }
    
    /**
    Returns a new instance with more characters loaded and new pagination data
    - Parameters: newCharacters, new data
    - Parameters: totalPages, total number of pages
    - Parameters: loadedPage, the current page
    - Returns: A new instance
     */
    func loadNewPage(newCharacters: [Character], totalPages: Int, loadedPage: Int) -> Self {
        let allCharacters = characters + newCharacters
        var loadedPages = pagination.loaded
        loadedPages.append(loadedPage)
        let pagination = CharactersPaginationState(total: totalPages, loaded: loadedPages)
        return .init(characters: allCharacters, isGrid: isGrid, pagination: pagination, loading: false)
    }
    
    /**
    Returns a new instance that contains an error
    - Parameters: message
    - Returns: A new instance
     */
    func error(message: String) -> Self {
        return .init(characters: characters, isGrid: isGrid, pagination: pagination, loading: false, error: message)
    }
    
    /**
    Returns a new instance that acknowledges the error
    - Parameters: message
    - Returns: A new instance
     */
    func ackError() -> Self {
        return .init(characters: characters, isGrid: isGrid, pagination: pagination, loading: _loading, error: nil)
    }
}
