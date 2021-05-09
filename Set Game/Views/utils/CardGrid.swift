//
//  CardGrid.swift
//  Memorize
//
//  Created by Jim's MacBook Pro on 5/4/21.
//

import SwiftUI

/**
 A view that arranges its children in a card grid layout
 
 ```
 var body: some View {
     CardGrid (cards) { Text("Card \($0)") }
 }
 ```
 */
struct CardGrid<ItemView>: View where ItemView: View {
    private var cards: [SetGame.Card]
    private var viewForCard: (SetGame.Card) -> ItemView
    private var desiredAspectRatio: Double
    
    /**
     Create a grid with the given items and viewForItem function
     
     - parameters:
        - items: the items in the view
        - viewForItem: view builder for the items
     */
    init(_ cards: [SetGame.Card], nearAspectRatio desiredAspectRatio: Double = 1, viewForCard: @escaping (SetGame.Card) -> ItemView) {
        self.cards = cards
        self.viewForCard = viewForCard
        self.desiredAspectRatio = desiredAspectRatio
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: cards.count, nearAspectRatio: desiredAspectRatio, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(cards) { card in
            let index = cards.firstIndex(matching: card)!
            viewForCard(card)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index))
                .transition(.asymmetric(
                    insertion: .offset(layout.location(ofItemAt: 0) - layout.location(ofItemAt: index)),
                    removal: .offset( card.state == .matched ? layout.location(ofItemAt: cards.count-1) - layout.location(ofItemAt: index) : layout.location(ofItemAt: 0) - layout.location(ofItemAt: index) )
                )
                .combined(with: .opacity)
                )
        }
    }
}
