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

class PhotoItem: Object {
    
    dynamic var id: Int = 0
    dynamic var albumId: Int = 0
    dynamic var title: String = ""
    dynamic var url: String = ""
    dynamic var thumbnailUrl: String = ""
    dynamic var cachedImage: Data? = nil

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension PhotoItem: IdentifiableType {
    var identity: Int {
        return self.isInvalidated ? 0 : id
    }
}
