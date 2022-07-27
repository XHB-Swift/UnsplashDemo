//
//  DetailPhotoRouter.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/28.
//

import UIKit

class DetailPhotoRouter: RouterModule {
    
    static func createModule() -> UIViewController {
        
        let vc = DetailPhotoViewController()
        let presenter = DetailPhotoPresenter()
        
        vc.presenter = presenter
        vc.presenter?.router = DetailPhotoRouter()
        vc.presenter?.view = vc
        vc.presenter?.interactor = DetailPhotoInteractor()
        vc.presenter?.interactor?.presenter = presenter
        
        return vc
    }
    
}
