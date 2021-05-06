//
//  Set_GameApp.swift
//  Set Game
//
//  Created by Jim's MacBook Pro on 5/5/21.
//

import SwiftUI

@main
struct Set_GameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(game: SetGameVM())
        }
    }
}
