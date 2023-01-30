//
//  Visibility.swift
//  RickAndMortyApp
//
//  Created by albertopeam on 31/1/23.
//

import SwiftUI

struct Visibility: ViewModifier {
    let isVisible: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
                .frame(width: 0, height: 0)
        }
    }
}

extension View {
    func isVisible(_ isVisible: Bool) -> some View {
        ModifiedContent(content: self, modifier: Visibility(isVisible: isVisible))
    }
}
