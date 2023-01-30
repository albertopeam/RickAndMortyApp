//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 27/1/23.
//

import SwiftUI

struct CharacterView: View {
    @State private var state: CharacterState
    
    init(character: Character) {
        self._state = State(wrappedValue: .init(character: character))
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: state.character.image,
                       content: { $0.resizable() },
                       placeholder: { ProgressView() })
                .frame(maxWidth: .infinity, minHeight: 280)
            VStack(alignment: .trailing) {
                HStack {
                    Button {
                        withAnimation {
                            state.showName.toggle()
                        }
                    } label: {
                        Image(systemName: state.openIcon)
                    }
                    .foregroundColor(Color(UIColor.systemGray))
                    Text(state.name)
                        .lineLimit(1)
                        .frame(minHeight: 20, alignment: .bottom)
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .background(Color(UIColor.systemBackground))
                .cornerRadius(6, corners: [.topLeft, .bottomLeft])
                HStack {
                    BlinkView(color: state.statusColor)
                    Text(state.character.status.rawValue)
                }
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                .background(Color(UIColor.systemBackground))
                .cornerRadius(6, corners: [.topLeft, .bottomLeft])
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
        }
        .cornerRadius(6, antialiased: true)
    }
}

// MARK: - Preview

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: .init(id: 2, image: URL(string: "https://rickandmortyapi.com/api/character/avatar/27.jpeg"),
                                       name: "Werewolf", status: .alive))
    }
}
