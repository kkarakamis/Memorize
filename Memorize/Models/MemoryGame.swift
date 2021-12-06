//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kutay Karakamış on 4.12.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var indexOfSelectedCardFromPrevious: Card.ID?
    
    mutating func choose(_ card: Card) {
        if let choosenCardIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenCardIndex].isFaceUp,
           !cards[choosenCardIndex].isMatched
        {
            if let potentialMatchIndex = indexOfSelectedCardFromPrevious {
                if cards[potentialMatchIndex].content == cards[choosenCardIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[choosenCardIndex].isMatched = true
                }
                indexOfSelectedCardFromPrevious = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfSelectedCardFromPrevious = choosenCardIndex
            }
            cards[choosenCardIndex].isFaceUp.toggle()
        }
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
