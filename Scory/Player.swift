//
//  Player.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-08.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation
import RealmSwift

class Player: Object {
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    let scores = List<Score>()
 
    static func create(name: String) -> Player {
        let player = Player()
        player.name = name
        return player
    }
}
