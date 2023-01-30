//
//  SnackBar.swift
//  RickAndMortyApp
//
//  Created by Alberto Penas Amor on 2/2/23.
//

import SwiftUI

struct SnackBarView: View {
    let message: String?
    var actionText: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(message ?? "")
                .lineLimit(5)
            Spacer(minLength: 16)
            Button {
                action?()
            } label: {
                Text(actionText ?? "")
            }
        }
        .padding()
        .background(Color(uiColor: UIColor.systemGray4))
        .cornerRadius(8)
        .padding()
        .isVisible(message != nil)
    }
}

// MARK: - Preview

struct SnackBarView_Previews: PreviewProvider {
    static var previews: some View {
        SnackBarView(message: "Something went wrong!", actionText: "OK")
    }
}
