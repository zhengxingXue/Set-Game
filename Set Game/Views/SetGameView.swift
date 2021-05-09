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
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.linear(duration: animationDuration)) {
                        game.newGame()
                    }
                }, label: { Text("New Game") }).padding()
                Spacer()
                Button(action: {
                    withAnimation(.linear(duration: animationDuration)) {
                        game.dealThreeMoreCards()
                    }
                }, label: { Text("Deal 3 More Cards") }).padding().disabled(!game.dealable)
            }
            
            CardGrid(game.deck, nearAspectRatio: Double(aspectRatio)) { card in
                CardView(card: card, dealerCardNumber: game.dealerCardNumber, matchedCardNumber:game.matchedCardNumber)
                    .aspectRatio(aspectRatio, contentMode: .fit)
                    .onTapGesture { withAnimation(.linear(duration: animationDuration)) { game.choose(card) }
                }
            }
            .onAppear {
                withAnimation(.linear(duration: animationDuration)) {
                    game.dealTwelveCards()
                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.linear) {
                        game.hint()
                    }
                }, label: { Text("Hint") }).padding()
            }
        }
    }
    
    private let animationDuration = 0.9
    private let aspectRatio : CGFloat = 2.0 / 3.0
}

struct CardView: View {
    var card: SetGame.Card
    var dealerCardNumber: Int
    var matchedCardNumber: Int
    
    var body: some View {
        featureView().cardify(state: card.state)
    }
    
    private func featureView() -> some View {
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 10).fill(Color.clear)
                VStack {
                    ForEach(0..<card.numberOfShapes) { _ in
                        drawOneShape(for: geometry.size)
                    }
                }
                .foregroundColor(card.viewColor)
                VStack {
                    if card.id == -1 { Text("Dealer"); Text("\(dealerCardNumber)")}
                    if card.id == -2 { Text("Bin"); Text("\(matchedCardNumber)") }
                }.font(Font.system(size: min(geometry.size.height, geometry.size.width) * 0.2))
                
            }
        }
    }
    
    private func drawOneShape(for size: CGSize) -> some View {
        ZStack {
            switch card.shape {
            case .oval:
                Ellipse().stroke()
                Ellipse().fill().opacity(card.viewShading)
            case .squiggle:
                RoundedRectangle(cornerRadius: cornerRadius).stroke()
                RoundedRectangle(cornerRadius: cornerRadius).fill().opacity(card.viewShading)
            case .diamond:
                Diamond().stroke()
                Diamond().fill().opacity(card.viewShading)
            }
        }
        .frame(width: size.width * featureFrameWidthRatio, height: size.height * featureFrameHeightRatio)
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius : CGFloat = 5
    private let featureFrameWidthRatio: CGFloat = 0.7
    private let featureFrameHeightRatio: CGFloat = 0.2
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameVM()
        // game.choose(game.deck[0])
        return SetGameView(game: game)
    }
}
