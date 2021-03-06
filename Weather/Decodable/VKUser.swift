//
//  VKUser.swift
//  Weather
//
//  Created by Stanislav Vasilev on 03.05.2021.
//

import Foundation
import RealmSwift

class VKUserRequestResponse: Codable {
    let response: VKUserResponse
}

class VKUserResponse: Codable {
    let items: [VKUser]
}

class VKUser: Object, Codable {
    @objc dynamic var userId: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatarUrl: String = ""
    
}

/* extension VKUser: CustomStringConvertible {
    var description: String {
        return String(format: "%@ %@ (%id)", firstName, lastName, userId)
    }
} */

extension VKUser {
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarUrl = "photo_200_orig"
        
    }
    
}
