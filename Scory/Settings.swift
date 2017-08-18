//
//  Settings.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-18.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation

enum SettingValue: String {
    case sort
}

enum SortOption: String {
    case Name
    case Score
    case Turns
}

class Settings {
    static let defaults = UserDefaults.standard
    
    static var sort: SortOption {
        get {
            switch defaults.string(forKey: SettingValue.sort.rawValue) ?? SortOption.Name.rawValue {
            case SortOption.Name.rawValue:
                return SortOption.Name
            case SortOption.Score.rawValue:
                return SortOption.Score
            case SortOption.Turns.rawValue:
                return SortOption.Turns
            default:
                return SortOption.Name
            }
        }
        set {
            defaults.set(newValue.rawValue, forKey: SettingValue.sort.rawValue)
        }
    }
}
