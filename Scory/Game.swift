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
    
    static func create(name: String, playerNames: [String]) -> Game {
        let playersDic = playerNames.map() { name in
            return ["name": name]
        }
        let game = Game(value: ["name": name, "players": playersDic])
        Store.save(object: game)
        return game
    }
    
    static func all() -> [Game] {
        return Store.get(type: Game.self)
    }
}
