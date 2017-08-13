
//
//  PhotosViewController.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action
import NSObject_Rx
import Lottie

class PhotosViewController: UIViewController, BindableType {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var addItemButton: UIButton!
    @IBOutlet var clearItemsButton: UIButton!
    @IBOutlet var emptyDatasourceView: UIView!
    @IBOutlet var animatedView: UIView!
    
    var viewModel: PhotosViewModel!
    let dataSource = RxCollectionViewSectionedReloadDataSource<PhotoSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        let animation = LOTAnimationView.init(name: "empty_status")
        animation.frame = animatedView.bounds
        animation.loopAnimation = true
        animatedView.addSubview(animation)
        animation.play()
    }
    
    func bindViewModel() {
        viewModel.sectionedItems
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.rx.disposeBag)
        viewModel.sectionedItems.bind {
            self.emptyDatasourceView.isHidden = !$0.isEmpty}.disposed(by: self.rx.disposeBag)
        addItemButton.rx.action = viewModel.onAddPhoto()
        clearItemsButton.rx.action = viewModel.onClearPhotos()
    }
    
    fileprivate func configureDataSource() {
        dataSource.configureCell = {
            dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoItemCollectionViewCell
            cell.configure(with: item)
            return cell
        }
    }
    
}
