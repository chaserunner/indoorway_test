//
//  AppDelegate.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 11.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let service = PhotoService()
        let sceneCoordinator = SceneCoordinator(window: window!)
        let photosViewModel = PhotosViewModel(photoService: service, coordinator: sceneCoordinator)
        let firstScene = Scene.photos(photosViewModel)
        sceneCoordinator.transition(to: firstScene, type: .root)
        return true
    }

}

