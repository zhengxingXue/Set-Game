//
//  SetGame.swift
//  Set Game
//
//  Created by Jim's MacBook Pro on 5/5/21.
//

import Foundation

struct SetGame {
    
    enum Shape: CaseIterable { case diamond, squiggle, oval }
    enum Shading: CaseIterable { case solid, striped, open }
    enum Color: CaseIterable { case red, green, purple }
    
    struct Card: Identifiable {
        var numberOfShapes : Int
        var shape : Shape
        var shading : Shading
        var color : Color
        
        var id : Int
    }
    
    private(set) var dealer : [Card]
    private(set) var deck : [Card]
    private(set) var mathched : [Card]
    
    init(cardOnDeck : Int = 12) {
        dealer = []
        deck = []
        mathched = []
        var currentId = 0
        for n in 1...3 {
            for shape in Shape.allCases {
                for shading in Shading.allCases {
                    for color in Color.allCases {
                        dealer.append(Card(numberOfShapes: n, shape: shape, shading: shading, color: color, id: currentId))
                        currentId += 1
                    }
                }
            }
        }
        dealer.shuffle()
        deal(for: cardOnDeck)
    }
    
    mutating func deal(for numberOfCard : Int) {
        for _ in 0..<numberOfCard {
            deck.append(dealer.removeFirst())
        }
    }
    
    mutating func choose(_ card: Card) {
        
    }
    
}
