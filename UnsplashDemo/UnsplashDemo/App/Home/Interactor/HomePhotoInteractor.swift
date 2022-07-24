//
//  HomePhotoInteractor.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/24.
//

import Foundation

class HomePhotoInteractor: InteractorModule {
    
    weak var presenter: PresenterModule?
    private var network: HomePhotoNetwork
    
    init() {
        network = .init()
    }
    
    func requestPhotoList() {
        network.requestPhotoList { [weak self] photos in
            let p = self?.presenter as? HomePhotoPresenter
            p?.reloadView(with: photos)
        }
    }
}
