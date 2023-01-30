//
//  BlinkView.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 3/2/23.
//

import SwiftUI

struct BlinkView: View {
    @State var animationAmount: Double = 0
    let color: Color?
    var size: Double = 5
    var duration: Double = 1
    var amount: Double = 2
    
    var body: some View {
        Circle()
            .foregroundColor(color)
            .frame(width: size, height: size)
            .scaleEffect(animationAmount)
            .animation(
                .easeOut(duration: duration),
                value: animationAmount
            ).onAppear {
                 animationAmount = amount
            }
    }
}


// MARK: - Preview

struct BlinkView_Previews: PreviewProvider {
    static var previews: some View {
        BlinkView(color: .green)
    }
}

