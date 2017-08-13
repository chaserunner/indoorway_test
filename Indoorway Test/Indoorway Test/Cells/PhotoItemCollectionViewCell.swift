//
//  PhotoItemCollectionViewCell.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import UIKit
import Action
import RxSwift
import Kingfisher

class PhotoItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var disposeBag = DisposeBag()
    
    func configure(with item: PhotoItem) {
        
        item.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                self?.title.text = title
            })
            .disposed(by: disposeBag)
        
        item.rx.observe(String.self, "thumbnailUrl")
            .subscribe(onNext: { [weak self] url in
                guard let urlString = url else {return}
                self?.image.kf.setImage(with: URL(string: urlString), completionHandler : {
                    a,b,c,d in
                    
                })
            })
            .disposed(by: disposeBag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    fileprivate func style() {
        layer.masksToBounds = false
        layer.contentsScale = UIScreen.main.scale
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 7
        layer.shadowColor = UIColor(white: 0, alpha: 0.4).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
    
    override func prepareForReuse() {
        image.image = nil
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
}
