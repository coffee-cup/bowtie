//
//  Game.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-08.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation
import RealmSwift

class Game: Object {
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var date = Date()
    let players = List<Player>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func winner() -> Player? {
        let maxPlayers = players.filter { player in
            return player.totalScore() >= self.maxScore()
        }
        return maxPlayers.count == 1
            ? maxPlayers[0]
            : nil
    }
    
    func maxScore() -> Int {
        let scores = players.map { player in
            return player.totalScore()
        }
        return scores.max() ?? 0
    }
    
    func maxTurns() -> Int {
        let totalTurns = players.map { player in
            return player.numTurns()
        }
        return totalTurns.max() ?? 0
    }
    
    static func create(name: String, playerNames: [String]) -> Game {
        let playersDic = playerNames.map() { name in
            return ["name": name]
        }
        let game = Game(value: ["name": name, "players": playersDic])
        Store.new(object: game)
        return game
    }
    
    static func all() -> [Game] {
        return Store.get(type: Game.self)
    }
}
