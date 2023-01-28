//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 27/1/23.
//

import SwiftUI

struct CharacterView: View {
    let url: URL?
    //TODO: add state
    @State private var showDetail = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: url,
                       content: { $0 },
                       placeholder: { ProgressView() })
            HStack {
                Button {
                    withAnimation {
                        print("\(String(describing: self)) button tapped")
                        showDetail.toggle()
                    }
                } label: {
                    //TODO: image from state
                    Image(systemName: "chevron.compact.right")
                }
                .foregroundColor(.black)
                //TODO: show/hide and ""/nonEmpty text
                Text("Werewolf")
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 16))
            .background(.white)
            .cornerRadius(6, corners: [.topLeft, .bottomLeft])
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            .offset(x: showDetail ? 90 : 0) //TODO: remove
        }
        .cornerRadius(6, antialiased: true)
        .padding()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(url: URL(string: "https://rickandmortyapi.com/api/character/avatar/711.jpeg"))
    }
}
