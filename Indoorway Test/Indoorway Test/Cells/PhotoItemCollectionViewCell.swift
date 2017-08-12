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

class PhotoItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var disposeBag = DisposeBag()
    
    func configure(with item: PhotoItem) {
        
        item.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                self?.title.text = title
            })
            .addDisposableTo(disposeBag)
        
        item.rx.observe(Data.self, "cachedImage")
            .subscribe(onNext: { [weak self] data in
                guard let data = data else { return }
                guard let image = UIImage.init(data: data) else { return }
                self?.image.image = image
            })
            .addDisposableTo(disposeBag)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
}
