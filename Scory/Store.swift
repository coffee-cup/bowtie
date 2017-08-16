//
//  Store.swift
//  Scory
//
//  Created by Jake Runzer on 2017-08-14.
//  Copyright © 2017 Jake Runzer. All rights reserved.
//

import Foundation
import RealmSwift

class Store {
    static let realm = try! Realm()
    
    static func get<T: Object>(type: T.Type) -> [T] {
        return Array(realm.objects(type))
    }
    
    static func get<T: Object>(byId id: String, type: T.Type) -> T? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    static func new(object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func update(block: (() -> Void)) {
        try! realm.write {
            block()
        }
    }
    
    static func delete(object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    static func notifier(block: @escaping (() -> Void)) -> NotificationToken {
        return realm.addNotificationBlock() { notification, realm in
            block()
        }
    }
}