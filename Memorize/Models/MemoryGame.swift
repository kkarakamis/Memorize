//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kutay Karakamış on 4.12.2021.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
