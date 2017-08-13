//
//  PhotoService.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

struct PhotoService: PhotoServiceType {
    
    init() {

    }
    
    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm()
            return try action(realm)
        } catch let err {
            print("Failed \(operation) realm with error: \(err)")
            return nil
        }
    }
    
    @discardableResult
    func addPhoto() -> Observable<PhotoItem> {
        let i = withRealm("getting photos") { realm -> Int in
            let count = realm.objects(PhotoItem.self).count
            return count
        }
        guard let index = i else { return .error(PhotoServiceError.addingFailed()) }
        let path = Path.photo(index: index + 1)
        return APIService.getObject(from: path.path)
        
    }
    
    @discardableResult
    func clearPhotos() -> Observable<Void> {
        let result = withRealm("deleting") { realm-> Observable<Void> in
            try realm.write {
                realm.delete(realm.objects(PhotoItem.self))
            }
            return .empty()
        }
        return result ?? .error(PhotoServiceError.clearingFailed())
    }
    
    @discardableResult
    func photos() -> Observable<Results<PhotoItem>> {
        let result = withRealm("getting photos") { realm -> Observable<Results<PhotoItem>> in
            let photos = realm.objects(PhotoItem.self)
            return Observable.collection(from: photos)
        }
        return result ?? .empty()
    }

}
