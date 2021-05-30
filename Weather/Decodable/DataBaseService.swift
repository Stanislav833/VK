//
//  DataBaseService.swift
//  Weather
//
//  Created by Stanislav Vasilev on 30.05.2021.
//

import Foundation
import Realm
import RealmSwift

class DataBaseService {
    
    static let instance = DataBaseService()
    var realm = try? Realm()
    var users: Results<VKUser>?
    var groups: Results<VKGroup>?
//    var notificationUsers: NotificationToken?
//    var notificationGroups: NotificationToken?
    
    func setup () {
        guard let realm = realm else { return }
        
        users = realm.objects(VKUser.self)
        groups = realm.objects(VKGroup.self)
    }
    
    func loadFriends() -> [VKUser] {
        var result = [VKUser]()
        guard let realm = realm, let users = users else { return result }
        result = users.compactMap { $0 }

        return result
    }
    
    func saveFriends(list: [VKUser]) -> Bool {
        guard let realm = realm else { return false }
    
        let deleteList = realm.objects(VKUser.self)
        
        try! realm.write {
        
            realm.delete(deleteList)
            
            list.forEach {
               realm.add($0)
            }
        }
        return true
    }
    
    func loadGroup() -> [VKGroup] {
        var result = [VKGroup]()
        guard let realm = realm, let groups = groups else { return result }
        result = groups.compactMap { $0 }
        
        return result
    }
    
    func saveGroups(list: [VKGroup]) -> Bool {
        guard let realm = realm else { return false }
    
        let deleteList = realm.objects(VKGroup.self)
        
        try! realm.write {
        
            realm.delete(deleteList)
            
            list.forEach {
               realm.add($0)
            }
        }
        return true
    }
    
}

