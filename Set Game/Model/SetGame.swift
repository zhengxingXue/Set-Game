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
    
    enum CardState { case notChosen, isChosen, matched, notMatched, potentialMatch }
    
    struct Card: Identifiable {
        var numberOfShapes : Int
        var shape : Shape
        var shading : Shading
        var color : Color
        
        var state = CardState.notChosen
        
        var id : Int
        
        static func characterMatch<T: Equatable>(_ c1 : T, _ c2 : T, _ c3 : T) -> Bool {
            return ((c1 == c2 && c2 == c3) || (c1 != c2 && c2 != c3 && c1 != c3))
        }
    }
    
    private(set) var dealer : [Card]
    private(set) var deck : [Card]
    private(set) var matched : [Card]
    
    var dealable : Bool { dealer.count >= 3 }
    
    private var chosenCards : [Card] { deck.filter { $0.state == .isChosen } }
    
    private var chosenCardsIndicies : [Int] { deck.indices.filter { deck[$0].state == .isChosen } }
    
    private var matchedCardsIndicies : [Int] { deck.indices.filter { deck[$0].state == .matched } }
    
    private var notMatchedCardsIndicies : [Int] { deck.indices.filter { deck[$0].state == .notMatched } }
    
    private mutating func unchosenAllCards() { for index in deck.indices { deck[index].state = .notChosen } }
    
    init() {
        dealer = []
        deck = []
        matched = []
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
    }
    
    mutating func deal(for numberOfCard : Int) {
        for _ in 0..<numberOfCard {
            deck.append(dealer.removeFirst())
        }
    }
    
    mutating func dealThreeMoreCard() {
        if matchedCardsIndicies.count == 3 {
            replaceMatchedCard()
        } else {
            deal(for: 3)
        }
    }
    
    private mutating func replaceMatchedCard() {
        for index in matchedCardsIndicies {
            matched.append(deck.remove(at: index))
            if dealable { deck.insert(dealer.removeFirst(), at: index) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = deck.firstIndex(matching: card) {
            changePotentialFitToUnChosen()
            var flipChosenCard = true
            if matchedCardsIndicies.count == 3 {
                flipChosenCard = !matchedCardsIndicies.contains(chosenIndex)
                replaceMatchedCard()
            } else if notMatchedCardsIndicies.count == 3 && !notMatchedCardsIndicies.contains(chosenIndex) {
                unchosenAllCards()
            }
            if flipChosenCard {
                switch deck[chosenIndex].state {
                    case .notChosen: deck[chosenIndex].state = .isChosen
                    case .isChosen: deck[chosenIndex].state = .notChosen
                    default: return
                }
            }
            if chosenCards.count == 3 {
                let matched = SetGame.matchingCard(chosenCards[0], chosenCards[1], chosenCards[2])
                for index in chosenCardsIndicies {
                    deck[index].state = matched ? .matched : .notMatched
                }
            }
        }
    }
    
    private static func matchingCard(_ c1: Card, _ c2: Card, _ c3: Card) -> Bool {
        return Card.characterMatch(c1.shape, c2.shape, c3.shape)
            && Card.characterMatch(c1.numberOfShapes, c2.numberOfShapes, c3.numberOfShapes)
            && Card.characterMatch(c1.color, c2.color, c3.color)
            && Card.characterMatch(c1.shading, c2.shading, c3.shading)
    }
    
    private mutating func changePotentialFitToUnChosen() {
        for index in deck.indices.filter({ deck[$0].state == .potentialMatch }) {
            deck[index].state = .notChosen
        }
    }
    
    mutating func hint() {
        if matchedCardsIndicies.count == 0 && notMatchedCardsIndicies.count == 0 {
            let amount = deck.count
            switch chosenCardsIndicies.count {
            case 0:
                checkLoop: for i in 0..<amount-2 {
                    for j in i+1..<amount-1 {
                        for k in j+1..<amount {
                            if SetGame.matchingCard(deck[i], deck[j], deck[k]) {
                                deck[i].state = .potentialMatch
                                deck[j].state = .potentialMatch
                                deck[k].state = .potentialMatch
                                break checkLoop
                            }
                        }
                    }
                }
            case 1:
                checkLoop: for i in 0..<amount-1 {
                    for j in i+1..<amount {
                        if SetGame.matchingCard(deck[i], deck[j], chosenCards[0]) {
                            deck[i].state = .potentialMatch
                            deck[j].state = .potentialMatch
                            break checkLoop
                        }
                    }
                }
            case 2:
                for i in 0..<amount {
                    if SetGame.matchingCard(deck[i],chosenCards[0], chosenCards[1]) {
                        deck[i].state = .potentialMatch
                    }
                }
            default:
                return
            }
        }
    }
    
}
