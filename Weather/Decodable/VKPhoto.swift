//
//  VKPhoto.swift
//  Weather
//
//  Created by Stanislav Vasilev on 03.05.2021.
//

import Foundation
import RealmSwift

class VKPhotoRequestResponse: Codable {
    let response: VKPhotoResponse
}

class VKPhotoResponse: Codable {
    let items: [VKPhoto]
}

class VKPhoto: Object, Codable {
    @objc var photoId: Int = 0
    @objc var url: String = ""
}

/* extension VKPhoto: CustomStringConvertible {
    var description: String {
        return String(format: "%id (%@)", photoId, url)
    }
} */

extension VKPhoto {
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case url = "photo_604"
    }
}
