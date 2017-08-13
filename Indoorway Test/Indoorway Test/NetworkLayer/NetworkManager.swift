//
//  NetworkManager.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 13.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import Foundation

import RxSwift
import Alamofire
import RxAlamofire

public class NetworkManager: NSObject {
    
    public static let sharedInstance = NetworkManager()
    private static let baseURL = "https://jsonplaceholder.typicode.com/"
    
    //MARK: - Request
    
    func request(path: String, method: HTTPMethod, parameters: [String: Any]?) -> Observable<AnyObject?> {
        let apiUrl = NetworkManager.baseURL + path
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        let concurrentBackgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        return requestJSON(method, apiUrl, parameters: parameters, encoding: encoding)
            .subscribeOn(concurrentBackgroundScheduler)
            .retry(1)
            .timeout(8, scheduler: concurrentBackgroundScheduler)
            .catchError({ error -> Observable<(HTTPURLResponse, Any)> in
                return Observable<(HTTPURLResponse, Any)>.error(error)
            })
            .map({ (r, json) in
                guard 200..<300 ~= r.statusCode else {
                    return NSError.init(domain: path,
                                        code: r.statusCode,
                                        userInfo: [NSLocalizedDescriptionKey: "Request failed"])
                }
                return json as AnyObject
            })
            .observeOn(MainScheduler.instance)
            .do(onNext: { _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }, onError: { _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .observeOn(concurrentBackgroundScheduler)
    }
    
}
