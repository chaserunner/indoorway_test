//
//  PhotosViewModel.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

typealias PhotoSection = AnimatableSectionModel<String, PhotoItem>

struct PhotosViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let photoService: PhotoServiceType
    
    init(photoService: PhotoServiceType, coordinator: SceneCoordinatorType) {
        self.photoService = photoService
        self.sceneCoordinator = coordinator
    }
    
    var sectionedItems: Observable<[PhotoSection]> {
        return self.photoService.photos()
            .map { results in
                let albums = results.categorise(){photo in photo.albumId}
                return albums.map(){
                    PhotoSection(model: "AlbumId: /($0)", items: $1)
                }
        }
    }
    
    func onAddPhoto() -> CocoaAction {
        return CocoaAction { _ in
            return self.photoService
            .addPhoto()
            .map { _ in }
        }
    }
    
    func onClearPhotos() -> CocoaAction {
        return CocoaAction { _ in
            return self.photoService
                .clearPhotos()
                .map(){_ in}
        }
    }

}
