//
//  PhotoServiceType.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

enum PhotoServiceError: Error {
    case addingFailed()
    case clearingFailed()
}

protocol PhotoServiceType {
    
    @discardableResult
    func addPhoto() -> Observable<PhotoItem>
    
    @discardableResult
    func clearPhotos() -> Observable<Void>
    
    func photos() -> Observable<Results<PhotoItem>>
    
}
