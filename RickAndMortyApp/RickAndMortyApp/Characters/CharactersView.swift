//
//  CharactersView.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 27/1/23.
//

import SwiftUI

struct CharactersView: View {
    @StateObject private var store: Store = .init(reducer: CharactersReducer(serviceLocator: CharactersLocator()).reducer,
                                                  state: CharactersState())
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: store.state.columns) {
                        ForEach(store.state.characters) { character in
                            CharacterView(character: character)                            
                        }
                    }
                    .padding()
                    ProgressView {
                        Text(NSLocalizedString("characters_tap_load_more_key", comment: ""))
                            .isVisible(!store.state.isLoadingFresh)
                    }
                    .isVisible(store.state.needsToLoadMore)
                    .onTapGesture {
                        dispatchLoad()
                    }
                    .disabled(store.state.isLoading)
                    .accessibilityLabel("Loading content")
                    .accessibilityIdentifier("characters_loading")
                }.refreshable {
                    dispatchRefresh()
                }.overlay(alignment: .bottom, content: {
                    SnackBarView(message: store.state.error,
                                 actionText: NSLocalizedString("ok_key", comment: ""),
                                 action: { dispatchAckError() })
                    .accessibilityLabel("Error message")
                    .accessibilityIdentifier("characters_error")
                })
            }
            .navigationTitle(NSLocalizedString("characters_key", comment: ""))
            .toolbar {
                Button {
                    dispatchToggleLayout()
                } label: {
                    Image(systemName: store.state.gridIcon)
                }
                .accessibilityLabel("Toggle layout")
                .accessibilityIdentifier("characters_toggle_layout")
            }
        }
        .task {
            await store.dispatch(action: .load)
        }
    }
}

// MARK: - Actions

private extension CharactersView {
    func dispatchToggleLayout() {
        Task() { await store.dispatch(action: .toggleLayout) }
    }
    
    func dispatchLoad() {
        Task { await store.dispatch(action: .load) }
    }
    
    func dispatchRefresh() {
        Task { await store.dispatch(action: .refresh) }
    }
    
    func dispatchAckError() {
        Task { await store.dispatch(action: .ackError) }
    }
}

// MARK: - Preview

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
