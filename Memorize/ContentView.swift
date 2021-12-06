//
//  ContentView.swift
//  Memorize
//
//  Created by Kutay Karakamış on 1.12.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: EmojiMemoryGameVM
    var gridItemWidth = UIScreen.main.bounds.size.width/5
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemWidth))]) {
                    ForEach(game.cards){ card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let rectangleShape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                rectangleShape.fill().foregroundColor(.white)
                rectangleShape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                rectangleShape.fill()
            }
        }
        .foregroundColor(.orange)
    }
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(game: EmojiMemoryGameVM())
    }
}
