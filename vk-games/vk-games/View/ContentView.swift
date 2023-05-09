//
//  ContentView.swift
//  vk-games
//
//  Created by Алексей Шевченко on 08.05.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card: card, image: UIImage(named: "\(card.content)")!).aspectRatio(3/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.blue)
        .padding(.horizontal)
    }
    @ViewBuilder
        private func cardView(for card: EmojiMemoryGame.Card) -> some View {
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card, image: UIImage(named: "\(card.content)")!)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    let image: UIImage
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    Image(uiImage: image)
                        .resizable()
                    Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 30))
                        .opacity(0.5)
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height)*DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return ContentView(game: game)
                    .preferredColorScheme(.light)
    }
}
