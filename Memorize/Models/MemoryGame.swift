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
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 10
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated  time yhis card has been face up in the past
        // (i.e. not including the current time it`s been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
