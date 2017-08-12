//
//  Sequence+Categorize.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import Foundation

private extension Dictionary {
    subscript(key: Key, or or: Value) -> Value {
        get { return self[key] ?? or }
        set { self[key] = newValue }
    }
}

public extension Sequence {

    func categorise<U : Hashable>( keyFunc: (Iterator.Element) throws -> U)
        rethrows -> [U:[Iterator.Element]] {
            var dict: [U:[Iterator.Element]] = [:]
            for el in self { dict[try keyFunc(el), or: []].append(el) }
            return dict
    }
    
}
