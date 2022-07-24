//
//  HomePhotoRouter.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/24.
//

import UIKit

class HomePhotoRouter: RouterModule {
    
    static func createModule() -> UIViewController {
        
        let vc = HomePhotoViewController()
        let presenter = HomePhotoPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = HomePhotoRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = HomePhotoInteractor()
        vc.presenter?.interactor?.presenter = presenter
        
        return vc
        
    }
    
}
