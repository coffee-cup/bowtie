//
//  Analytics.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-23.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation
import Crashlytics

class Analytics {
    static func createGame(gameId: String, name: String) {
        Answers.logCustomEvent(withName: "Create Game", customAttributes: ["game_id": gameId, "name": name])
    }
    
    static func deleteGame(gameId: String, name: String) {
        Answers.logCustomEvent(withName: "Delete Game", customAttributes: ["game_id": gameId, "name": name])
    }
    
    static func addScore(gameId: String, score: Int) {
        Answers.logCustomEvent(withName: "Add Score", customAttributes: ["game_id": gameId, "score": score])
    }
}
