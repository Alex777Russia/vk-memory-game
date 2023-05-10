//
//  ContentView.swift
//  vk-games
//
//  Created by Алексей Шевченко on 08.05.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: EmojiMemoryGame
    @State private var dealt = Set<Int>()
    @Namespace private var dealingNamespace
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * CardConstants.totalDealDuration / Double(game.cards.count)
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text("VK Memory Game")
                    .font(.title)
                gameBody
                HStack {
                    restartButton
                    Spacer()
                    shuffleButton
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card, image: UIImage(named: "\(card.content)")!)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.underltWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            // Раздача карт
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffleButton: some View {
        Button("Перемешать") {
            withAnimation {
                game.shuffle()
            }
        }
        .frame(width: 115, height: 60)
        .foregroundColor(.white)
        .background(Color.blue)
    }
    
    var restartButton: some View {
        Button("Заново") {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
        .frame(width: 115, height: 60)
        .foregroundColor(.white)
        .background(Color.blue)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 3/3) { card in
            cardView(for: card)
        }
        .foregroundColor(CardConstants.color)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) ||  (card.isMatched && !card.isFaceUp) {
            Color.clear
        } else {
            CardView(card: card, image: UIImage(named: "\(card.content)")!)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
    }
    
    private struct CardConstants {
        static let color = Color.blue
        static let aspectRatio: CGFloat = 3/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 70
        static let underltWidth = undealtHeight * aspectRatio
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    let image: UIImage
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: (1-card.bonusTimeRemaining)*360-90))
                    }
                }
                .padding(4)
                .opacity(0.6)
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
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
