//
//  PhotosLayout.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 13.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import UIKit

class PhotosLayout: UICollectionViewFlowLayout {

    let spacing : CGFloat = 16
    let columns : UInt = 2
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = spacing
        minimumLineSpacing = spacing
        scrollDirection = .vertical
        sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing + 60, spacing)
    }
    
    override var itemSize: CGSize {
        set { }
        get {
            let numberOfColumns = CGFloat(columns)
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns + 1) * spacing) / numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
}
