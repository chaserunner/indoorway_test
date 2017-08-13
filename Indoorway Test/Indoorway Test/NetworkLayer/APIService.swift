//
//  APIService.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 13.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import ObjectMapper
import RealmSwift
import RxSwift
import RxRealm
import Alamofire

enum MappingKey : String {
    
    typealias RawValue = String
    case id, albumId, title, url, thumbnailUrl
    
}

enum Path {
    
    case photo(index: Int)
    
    var path : String {
        switch self {
        case let .photo(index):
            return "photos/\(index)"
        }
        
    }
    
}

struct APIService {
    
    static private func requestObject<T>(at path: String, using method: HTTPMethod, with parameters: [String: Any] = [:], and realm: Realm? = nil) -> Observable<T> where T: Object, T: Mappable {
        return NetworkManager.sharedInstance.request(path: path, method: method, parameters: parameters)
            .flatMap { (response) -> Observable<T> in
                print("PATH:\(path)")
                print("PARAMETERS:\(parameters)")
                print("RESPONSE:\(response?.description ?? "")")
                if let error = response as? NSError {
                    return Observable<T>.error(error)
                }
                guard let json = response as? [String: Any], let object = Mapper<T>().map(JSONObject: json) else {
                    return Observable<T>.error(NSError(domain: path,
                                                       code: -1,
                                                       userInfo: [NSLocalizedDescriptionKey: "Object mapping failed"]))
                }
                autoreleasepool {
                    let _realm: Realm?
                    if realm != nil {
                        _realm = realm
                    } else {
                        _realm = try? Realm()
                    }
                    if let _realm = _realm {
                        try? _realm.write {
                            _realm.create(T.self, value: object.toJSON(), update: true)
                        }
                    }
                }
                return Observable<T>.just(object)
            }
            .observeOn(MainScheduler.instance)
    }
    
    static func getObject<T>(from path: String, with parameters: [String: Any] = [:], and realm: Realm? = nil) -> Observable<T> where T: Object, T: Mappable {
        return requestObject(at: path, using: .get, with: parameters)
    }
    
    static func postObject<T>(to path: String, with parameters: [String: Any] = [:], and realm: Realm? = nil) -> Observable<T> where T: Object, T: Mappable {
        return requestObject(at: path, using: .post, with: parameters)
    }
}

