//
//  vk_gamesApp.swift
//  vk-games
//
//  Created by Алексей Шевченко on 08.05.2023.
//

import SwiftUI

@main
struct vk_gamesApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
