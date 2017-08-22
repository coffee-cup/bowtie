//
//  Score.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-12.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation
import RealmSwift

class Score: Object {
    @objc dynamic var value: Int = 0
    
    static func create(value: Int) -> Score {
        let score = Score()
        score.value = value
        
        return score
    }
}
