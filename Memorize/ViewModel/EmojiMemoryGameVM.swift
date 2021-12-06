//
//  EmojiMemoryGameVM.swift
//  Memorize
//
//  Created by Kutay Karakamış on 4.12.2021.
//

import SwiftUI

class EmojiMemoryGameVM: ObservableObject {
    static let emojis = ["🫀", "🫁", "🦷", "🧠", "👅", "👁"]

    @Published private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsCards: 5, getCardContent: {index in emojis[index]})
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: Indent
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
