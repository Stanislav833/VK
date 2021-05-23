//
//  VKService.swift
//  Weather
//
//  Created by Stanislav Vasilev on 03.05.2021.
//

import Foundation
import Alamofire
import AlamofireImage
import RealmSwift

class VKService {
    static let instance = VKService()
    
    private let baseUrl = "https://api.vk.com/method/"
    private let apiVersion = "5.68"
    private let accessToken = Session.shared.accessToken
    private lazy var commonParameters = [
        "access_token" : accessToken,
        "v" : apiVersion
    ]
    
    private init() {}
    
    //сохранение  данных в Realm
         func saveUserData(_ user: [VKUser]) {
    // обработка исключений при работе с хранилищем
            do {
    // получаем доступ к хранилищу
                let realm = try Realm()
                
    // начинаем изменять хранилище
                realm.beginWrite()
                
    // кладем все объекты класса группы в хранилище
                realm.add(user)
                
    // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }
    
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
                    self.saveUserData(requestResponse.response.items)
                } catch {
                    handler(.failure(error))
                }
            })
    }
    
    //сохранение  данных в Realm
         func savePhotoData(_ photo: [VKPhoto]) {
    // обработка исключений при работе с хранилищем
            do {
    // получаем доступ к хранилищу
                let realm = try Realm()
                
    // начинаем изменять хранилище
                realm.beginWrite()
                
    // кладем все объекты класса группы в хранилище
                realm.add(photo)
                
    // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }
    
    func loadPhotos(userId: Int,
                    handler: @escaping (Result<[VKPhoto], Error>) -> Void) {
        let apiMethod = "photos.getAll"
        let apiEnpoint = baseUrl + apiMethod
        var requestParameters = [
        "access_token" : accessToken,
            "v" : apiVersion,
            "owner_id" : Int(userId),
            "extended" : "1",
            "photo_sizes" : "0",
            "count" : "30"
        ] as [String : Any]
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
                    self.savePhotoData(requestResponse.response.items)
                } catch {
                    handler(.failure(error))
                }
            })
                
    }

    //сохранение  данных в Realm
         func saveGroupData(_ group: [VKGroup]) {
    // обработка исключений при работе с хранилищем
            do {
    // получаем доступ к хранилищу
                let realm = try Realm()
                
    // начинаем изменять хранилище
                realm.beginWrite()
                
    // кладем все объекты класса группы в хранилище
                realm.add(group)
                
    // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }
    
    func loadGroups(handler: @escaping (Result<[VKGroup], Error>) -> Void) {
    let apiMethod = "groups.get"
    let apiEnpoint = baseUrl + apiMethod
    let requestParameters = [
        "access_token" : accessToken,
        "v" : apiVersion,
        "extended" : "1",
        "fields" : "photo_200",
        "user_id" : 5250488
        ] as [String : Any]
    
    AF.request(apiEnpoint, method: .get, parameters: requestParameters)
        .validate()
        .responseData(completionHandler: { [weak self] responseData in
            guard let data = responseData.data else {
                if let error = responseData.error {
                    handler(.failure(error))
                }
                return
            }

         let decoder = JSONDecoder()
            
                    do {
                        let requestResponse = try
                            decoder.decode(GroupsResponse.self, from: data)
                        handler(.success(requestResponse.response.items))
                        self?.saveGroupData(requestResponse.response.items)
                    } catch {
                        handler(.failure(error))
                    }
                    })
                    
    }

    func searchGroups(searchQuery: String, handler: @escaping (Result<[String: Any]?, Error>) -> Void) {
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
    

