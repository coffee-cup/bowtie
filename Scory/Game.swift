//
//  Game.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-08.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation

class Game {
    var id: String!
    var date: Date!
    var players: [Player] = []
    
    init(players: [Player]) {
        self.players = players
        self.id = UUID().uuidString
        self.date = Date()
    }
}
