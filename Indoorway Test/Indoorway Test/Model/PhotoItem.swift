//
//  PhotoItem.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import Foundation
import RealmSwift
import RxDataSources
import ObjectMapper
import RxSwift

class PhotoItem: Object, Mappable {
    
    dynamic var id: Int = 0
    dynamic var albumId: Int = 0
    dynamic var title: String = ""
    dynamic var url: String = ""
    dynamic var thumbnailUrl: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        albumId         <- map["albumId"]
        title           <- map["title"]
        url             <- map["url"]
        thumbnailUrl    <- map["thumbnailUrl"]
    }

}

extension PhotoItem: IdentifiableType {
    
    var identity: Int {
        return self.isInvalidated ? 0 : id
    }
    
}
