//
//  MemoryGame.swift
//  vk-games
//
//  Created by Алексей Шевченко on 09.05.2023.
//

import SwiftUI

// ViewModel

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    static var services = ["vk", "odnoclass", "geekbrains", "delivery", "yula", "teams", "dzen", "skillbox", "play", "music", "marusya", "mail", "cloud", "atom", "messege"]

    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 15) { pairIndex in
            EmojiMemoryGame.services[pairIndex]
        }
    }

    @Published private var model = createMemoryGame()

    var cards: [Card] {
        return model.cards
    }

    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
