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
        
        item.rx.observe(String.self, "url")
            .subscribe(onNext: { [weak self] url in
                guard let urlString = url else {return}
                self?.image.kf.setImage(with: URL(string: urlString), completionHandler : {
                    a,b,c,d in
                    
                })
            })
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
}
