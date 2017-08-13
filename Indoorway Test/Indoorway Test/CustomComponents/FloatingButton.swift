//
//  FloatingButton.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 13.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


@IBDesignable class FloatingButton: UIButton {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        circleCorners()
        addShadow()
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
        addShadow()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        circleCorners()
    }
    
    fileprivate func circleCorners() {
        layer.cornerRadius = self.bounds.height / 2
    }
    
    fileprivate func addShadow () {
        layer.masksToBounds = false
        layer.contentsScale = UIScreen.main.scale
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 8
        layer.shadowColor = UIColor(white: 0, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 7)
    }
    
}
