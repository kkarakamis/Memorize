//
//  EmojiMemoryGameVM.swift
//  Memorize
//
//  Created by Kutay Karakamış on 4.12.2021.
//

import SwiftUI

class EmojiMemoryGameVM: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🫀", "🫁", "🦷", "🧠", "👅", "👁"]

    @Published private var model = MemoryGame<String>(numberOfPairsCards: 5, getCardContent: {index in emojis[index]})
    
    var cards: [Card] {
        return model.cards
    }
    
    // MARK: Indent
    
    func choose(_ card: Card){
        model.choose(card)
    }
}
