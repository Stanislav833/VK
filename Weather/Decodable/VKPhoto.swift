//
//  VKPhoto.swift
//  Weather
//
//  Created by Stanislav Vasilev on 03.05.2021.
//

import Foundation

struct VKPhotoRequestResponse: Codable {
    let response: VKPhotoResponse
}

struct VKPhotoResponse: Codable {
    let items: [VKPhoto]
}

struct VKPhoto: Codable {
    var photoId: Int
    var url: String
}

extension VKPhoto: CustomStringConvertible {
    var description: String {
        return String(format: "%id (%@)", photoId, url)
    }
}

extension VKPhoto {
    enum CodingKeys: String, CodingKeys {
        case photoId = "id"
        case url = "photo_684"
    }
}
