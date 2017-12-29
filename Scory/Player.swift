//
//  Player.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-08.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import UIKit
import RealmSwift

class Player: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var colourString = ""
    let scores = List<Score>()
    
    var colour: UIColor {
        return UIColor(hexString: colourString)
    }
 
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func totalScore() -> Int {
        return scores.reduce(0) { acc, score in
            return acc + score.value
        }
    }
    
    func numTurns() -> Int {
        return scores.count
    }
    
    static func create(name: String, colour: String) -> Player {
        let player = Player()
        player.name = name
        player.colourString = colour
        return player
    }
    
    static func addScore(game: Game, player: Player, value: Int) {
        Store.update {
            let newScore = Score.create(value: value)
            player.scores.append(newScore)
            Store.realm.add(player, update: true)
            Analytics.addScore(gameId: game.id, score: value)
        }
    }
    
    static func toNewPlayer(player: Player) -> NewPlayer {
        return NewPlayer(name: player.name, colour: player.colour)
    }
}

struct NewPlayer {
    var name: String!
    var colour: UIColor!
}
