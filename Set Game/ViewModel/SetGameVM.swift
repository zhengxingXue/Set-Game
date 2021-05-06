//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Jim's MacBook Pro on 5/5/21.
//

import Foundation

class SetGameVM: ObservableObject {
    @Published private var game : SetGame = SetGame()
    
    // MARK: - Access to the Model
    
    /// Access the model's cards array
    var deck: [SetGame.Card] { game.deck }
    
    // MARK: - Intent(s)
    
    /**
     Pass the choose card intent from view to model
     - Parameters:
        - card: the card to choose
     */
    func choose(_ card: SetGame.Card) { game.choose(card) }
}
