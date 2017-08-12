//
//  Scene+ViewController.swift
//  Indoorway Test
//
//  Created by Illia Lukisha on 12.08.17.
//  Copyright © 2017 Illia Lukisha. All rights reserved.
//

import UIKit

extension Scene {
    
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch self {
        case .photos(let viewModel):
            let nc = storyboard.instantiateViewController(withIdentifier: "Photos") as! UINavigationController
            var vc = nc.viewControllers.first as! PhotosViewController
            vc.bindViewModel(to: viewModel)
            return nc
        }
    }
    
}
