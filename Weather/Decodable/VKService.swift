//
//  VKService.swift
//  Weather
//
//  Created by Stanislav Vasilev on 03.05.2021.
//

import Foundation
import Alamofire
import AlamofireImage

class VKService {
    static let instance = VKService()
    
    private let baseUrl = "https://api.vk.com/method/"
    private let apiVersion = "5.68"
    private let accessToken = Session.instance.accessToken
    private lazy var commonParameters = [
        "access_token" : accessToken,
        "v" : apiVersion
    ]
    
    private init() {}
    
    func loadFriends(handler: @escaping (Result<[VKUser], Error>) -> Void) {
        let apiMethod = "friends.get"
        let apiEnpoint = baseUrl + apiMethod
        let requestParameters = [
        "access_token" : accessToken,
            "v" : apiVersion,
            "fields" : "photo_200_orig, online"
        ]
        AF.request(apiEnpoint, method: .get, parameters: requestParameters)
            .validate()
            .responseData(completionHandler: { responseData in
                guard let data = responseData.data else {
                    if let error = responseData.error {
                        handler(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let requestResponse = try
                        decoder.decode(VKUserRequestResponse.self, from: data)
                    handler(.success(requestResponse.response.items))
                } catch {
                    handler(.failure(error))
                }
            })
    }
    
    func loadPhotos(userId: Int,
                    handler.@escaping.(Result<[VKPhoto], Error>) -> Void) {
        let apiMethod = "photos.getAll"
        let apiEnpoint = baseUrl + apiMethod
        let requestParameters = [
        "access_token" : accessToken,
            "v" : apiVersion,
            "owner_id" : String(userId),
            "extended" : "0",
            "photo_sizes" : "0",
            "count" : "30"
        ]
        requestParameters["v"] = "5.68"
        
        AF.request(apiEnpoint, method: .get, parameters: requestParameters)
            .validate()
            .responseData(completionHandler: { responseData in
                guard let data = responseData.data else {
                    if let error = responseData.error {
                        handler(.failure(error))
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let requestResponse = try
                        decoder.decode(VKPhotoRequestResponse.self, from: data)
                    handler(.success(requestResponse.response.items))
                } catch {
                    handler(.failure(error))
                }
            })
                
    }

    func loadGroups(handler: @escaping (Result<[VKGroup], Error>) -> Void {
    let apiMethod = "groups.get"
    let apiEnpoint = baseUrl + apiMethod
    let requestParameters = [
        "access_token" : accessToken,
        "v" : apiVersion,
        "extended" : "1"
    ]
    
    AF.request(apiEnpoint, method: .get, parameters: requestParameters)
        .validate()
        .responseData(completionHandler: { responseData in
            guard let data = responseData.data else {
                if let error = responseData.error {
                    handler(.failure(error))
                }
                return
            }

        let decoder = JSONDecoder()
                    do {
                        let requestResponse = try
                            decoder.decode(VKGroupRequestResponse.self, from: data)
                        handler(.success(requestResponse.response.items))
                    } catch {
                        handler(.failure(error))
                    }
                    })
    }

    func searchGroups(searchQuery: Srting, handler: @escaping (Result<[String: Any]?,
                        Error>) -> Void) {
                        let apiMethod = "groups.search"
                        let apiEnpoint = baseUrl + apiMethod
                        let requestParameters = [
                            "access_token" : accessToken,
                            "v" : apiVersion,
                        "q" : searchQuery
                        ]
                        AF.request(apiEnpoint, method: .get, parameters: requestParameters)
                            .validate()
                        .responseJSON { responseData in
                        switch responseData.result {
                        case .success(let result):
                        if let result = result as? [String: Any] {
                        handler(.success(result))
                        } else {
                        }
                        case .failure(let error):
                        handler(.failure(error))
                        }
                    }
                }
    }
    


