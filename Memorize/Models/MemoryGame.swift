//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kutay Karakamış on 4.12.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    mutating func choose(_ card: Card) {
        guard let choosenCardIndex = cards.firstIndex(where: { $0.id == card.id }) else {return }
        cards[choosenCardIndex].isFaceUp.toggle()
    }
    
    init(numberOfPairsCards: Int, getCardContent: (Int) -> CardContent){
        cards = [Card]()
        for index in 0..<numberOfPairsCards {
            let content = getCardContent(index)
            cards.append(Card(content: content, id: 2*index))
            cards.append(Card(content: content, id: 2*index+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
