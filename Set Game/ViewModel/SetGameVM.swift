//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Jim's MacBook Pro on 5/5/21.
//

import SwiftUI

class SetGameVM: ObservableObject {
    @Published private var game : SetGame = SetGame()
    
    private var dummyCardForDealer = SetGame.Card(numberOfShapes: 0, shape: .diamond, shading: .open, color: .green, id: -1)
    private var dummyCardForMatched = SetGame.Card(numberOfShapes: 0, shape: .diamond, shading: .open, color: .green, id: -2)
    private var addDummyToDeck = false
    
    // MARK: - Access to the Model
    
    /// Access the model's cards array
    var deck: [SetGame.Card] {
        var deck = game.deck
        if addDummyToDeck {
            deck.insert(dummyCardForDealer, at: 0)
            deck.append(dummyCardForMatched)
        }
        return deck
    }
    
    var dealerCardNumber : Int { game.dealer.count }
    
    var deckCardNumber : Int { game.deck.count }
    
    var matchedCardNumber : Int { game.matched.count }
    
    var dealable : Bool { game.dealable}
    
    // MARK: - Intent(s)
    
    /**
     Pass the choose card intent from view to model
     - Parameters:
        - card: the card to choose
     */
    func choose(_ card: SetGame.Card) { game.choose(card) }
    
    func newGame() {
        game = SetGame()
        dealTwelveCards()
    }
    
    func dealThreeMoreCards() { game.dealThreeMoreCard() }
    
    func dealTwelveCards() {
        game.deal(for: 12)
        addDummyToDeck = true
    }
    
    func hint() { game.hint() }

}

extension SetGame.Card {
    var viewColor: Color {
        switch color {
        case .red: return Color.red
        case .green: return Color.green
        case .purple: return Color.purple
        }
    }
    
    var viewShading: Double {
        switch shading {
        case .solid: return 1
        case .striped: return 0.5
        case .open: return 0
        }
    }
}
