
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

class PhotosViewController: UIViewController, BindableType {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var addItemButton: UIButton!
    @IBOutlet var clearItemsButton: UIButton!
    
    var viewModel: PhotosViewModel!
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<PhotoSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    
    func bindViewModel() {
        viewModel.sectionedItems
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .addDisposableTo(self.rx_disposeBag)
        
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
