//
//  Diamond.swift
//  Set Game
//
//  Created by Jim's MacBook Pro on 5/6/21.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let leftPoint = CGPoint(x: 0, y: rect.midY)
        let rightPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let upPoint = CGPoint(x: rect.midX, y: 0)
        let downPoint = CGPoint(x: rect.midX, y: rect.maxY)
        var p = Path()
        p.move(to: leftPoint)
        p.addLine(to: upPoint)
        p.addLine(to: rightPoint)
        p.addLine(to: downPoint)
        p.addLine(to: leftPoint)
        return p
    }
}
