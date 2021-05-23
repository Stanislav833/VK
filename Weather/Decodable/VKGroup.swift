//
//  VKGroup.swift
//  Weather
//
//  Created by Stanislav Vasilev on 03.05.2021.
//

import Foundation
import RealmSwift

class GroupsResponse: Decodable {
    let response: Groups
}

class Groups: Decodable {
    let items: [VKGroup]
}

class VKGroup: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var userCity = ""
    @objc dynamic var typeGroup = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case screenName = "screen_name"
        case avatar = "photo_200"
        case id
        case countGroup
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.screenName = try values.decode(String.self, forKey: .screenName)
        self.id = try values.decode(Int.self, forKey: .id)
        self.avatar = try values.decode(String.self, forKey: .avatar)
    }
}

