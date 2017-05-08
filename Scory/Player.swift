//
//  Player.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-08.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation

class Player {
    var id: String!
    var name: String!
    var scores: [Int] = []

    init(name: String) {
        self.name = name
        self.id = UUID().uuidString
    }
}
