//
//  CharactersReducer.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 30/1/23.
//

import Foundation

struct CharactersReducer {
    private let serviceLocator: CharactersServiceLocator
    
    init(serviceLocator: CharactersServiceLocator) {
        self.serviceLocator = serviceLocator
    }

    func reducer(state: CharactersState, action: CharactersAction) -> Stream<CharactersState> {
        switch action {
        case .load:
            return load(state)
        case .toggleLayout:
            return toggleLayout(state)
        case .refresh:
            return refresh(state)
        case .ackError:
            return ackError(state)
        }
    }
}

// MARK: - Load

private extension CharactersReducer {
    func load(_ state: CharactersState) -> Stream<CharactersState> {
        let loadingState = state.loading()
        return Stream(items: [
            {
                return loadingState.isGrid(isGrid)
            },
            {
                let newState = loadingState.isGrid(isGrid)
                return await load(newState)
            }
        ])
    }
    
    func load(_ state: CharactersState) async -> CharactersState {
        if let nextPage = state.pagination.next {
            do {
                let output = try await serviceLocator.service().getCharacters(page: nextPage)
                let newState = state.loadNewPage(newCharacters: output.characters, totalPages: output.page.pages, loadedPage: nextPage)
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                return newState
            } catch {
                return state.error(message: NSLocalizedString("characters_error", comment: ""))
            }
        } else {
            return state
        }
    }
    
    
}

// MARK: - Toggle layout

private extension CharactersReducer {
    func toggleLayout(_ state: CharactersState) -> Stream<CharactersState> {
        return Stream(item: {
            let newState = state.changeLayout()
            let newValue = newState.isGrid
            var storageService = serviceLocator.storageService()
            storageService.isGrid = newValue
            return newState
        })
    }
}

// MARK: - Refresh

private extension CharactersReducer {
    func refresh(_ state: CharactersState) -> Stream<CharactersState> {
        let refreshState = state.refresh()
        return Stream(items: [
            {
                refreshState
            },
            {
                await load(refreshState)
            }
        ])
    }
}

// MARK: - AckError

private extension CharactersReducer {
    func ackError(_ state: CharactersState) -> Stream<CharactersState> {
        return Stream(item: {
            return state.ackError()
        })
    }
}

// MARK: - Helper

private extension CharactersReducer {
    var isGrid: Bool {
        serviceLocator.storageService().isGrid
    }
}
