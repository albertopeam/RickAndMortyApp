//
//  Store.swift
//  Redux
//
//  Created by Alberto Penas Amor on 18/7/22.
//

import Foundation

actor Store<S, Action, R: AsyncSequence>: ObservableObject where R.Element == S {
    typealias Input = (state: S, action: Action)
    typealias Output = R
    typealias Reducer = (Input) -> Output

    @MainActor @Published private(set) var state: S
    private let reducer: Reducer

    @MainActor
    init(reducer: @escaping Reducer, state: S) {
        self.reducer = reducer
        self.state = state
    }

    func dispatch(action: Action) async {
        do {
            let currentState = await state
            let stream = reducer((currentState, action))
            for try await newState in stream {
                await postState(newState)
            }
        } catch {
            print(error)
        }
    }
    
    @MainActor private func postState(_ newState: S) async {
        state = newState
    }
}
