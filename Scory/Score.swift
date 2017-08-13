//
//  Score.swift
//  Scory
//
//  Created by Jake Runzer on 2017-05-12.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation

enum ScoreTypes {
    case Num
}

struct Score {
    var type: ScoreTypes = .Num
    var value: Int = 0
}
