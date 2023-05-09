//
//  Cardify.swift
//  vk-games
//
//  Created by Алексей Шевченко on 09.05.2023.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
            } else {
                shape.fill()
            }
            content.opacity(isFaceUp ? 1: 0)
        }
    }

    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}
