//
//  Cardify.swift
//  Set Game
//
//  Created by Jim's MacBook Pro on 5/6/21.
//

import SwiftUI

struct Cardify: ViewModifier {
//    var isChosen: Bool
    var state: SetGame.CardState
    func body(content: Content) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
                .shadow(color: shadowColor, radius: shadowRadius)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: edgeLineWidth)
                .foregroundColor(strokeColor)
                .opacity(opacity)
            content
        }
        .padding(padding)
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius : CGFloat = 5
    private let edgeLineWidth : CGFloat = 2
    private var shadowColor : Color { strokeColor }
    
    private var opacity : Double {
        switch state {
        case .notChosen, .potentialMatch: return 0.3
            default: return 0.7
        }
    }
    
    private var padding : CGFloat {
        switch state {
            case .notChosen: return 5
            default: return 3
        }
    }
    
    private var shadowRadius : CGFloat {
        switch state {
            case .notChosen: return 0
            default: return 3
        }
    }
    
    private var strokeColor : Color {
        switch state {
            case .matched, .potentialMatch: return .green
            case .notMatched: return .red
            default: return .black
        }
    }
}

extension View {
    func cardify(state : SetGame.CardState) -> some View {
        self.modifier(Cardify(state: state))
    }
}
