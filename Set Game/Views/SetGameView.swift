//
//  SetGameView.swift
//  Set Game
//
//  Created by Jim's MacBook Pro on 5/5/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game : SetGameVM
    
    var body: some View {
        Grid(game.deck) { card in
            CardView(card: card)
        }
    }
}

struct CardView: View {
    var card: SetGame.Card
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
            Text("Card")
        }
            .padding()
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius : CGFloat = 10
    private let edgeLineWidth : CGFloat = 3
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game: SetGameVM())
    }
}
