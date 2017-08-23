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
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    let players = List<Player>()
    
    var formatedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: date)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func winner() -> Player? {
        let maxPlayers = Array(players).filter { player in
            return player.totalScore() >= self.maxScore()
        }
        return maxPlayers.count == 1
            ? maxPlayers[0]
            : nil
    }
    
    func maxScore() -> Int {
        let scores = players.map { $0.totalScore() }
        return scores.max() ?? 0
    }
    
    func maxTurns() -> Int {
        let totalTurns = players.map { $0.numTurns() }
        return totalTurns.max() ?? 0
    }
    
    static func create(name: String, newPlayers: [NewPlayer]) -> Game {
        let playersDic = newPlayers.map() { newPlayer in
            return ["name": newPlayer.name, "colourString": newPlayer.colour.toHexString()]
        }
        let game = Game(value: ["name": name, "players": playersDic])
        Store.new(object: game)
        
        Analytics.createGame(gameId: game.id, name: name)
        
        return game
    }
    
    static func delete(game: Game) {
        Analytics.deleteGame(gameId: game.id, name: game.name)
        Store.delete(object: game)
    }
    
    static func all() -> [Game] {
        return Store.get(type: Game.self, order: "date", ascending: false)
//        return Store.get(type: Game.self)
    }
}
