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
            TabView{
                Menu()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("About")
                    }
                ContentView(game: game)
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Game")
                    }
                ListSrevices()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Services")
                }
            }
        }
    }
}
