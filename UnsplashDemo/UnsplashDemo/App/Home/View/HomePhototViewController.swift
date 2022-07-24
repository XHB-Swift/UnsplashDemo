//
//  HomePhotoViewController.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit
import XHBFoundationSwiftLib

class HomePhotoViewController: UIViewController, ViewModule {
    
    var presenter: PresenterModule? {
        didSet {
            let homePhotoPresenter = presenter as? HomePhotoPresenter
            listView?.dataSource = homePhotoPresenter
        }
    }
    private weak var listView: HomePhotoCollectionView?
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        setupSubviews()
        let p = (presenter as? HomePhotoPresenter)
        let i = p?.interactor as? HomePhotoInteractor
        i?.requestPhotoList()
    }
    
    func setupSubviews() {
        let cv = HomePhotoCollectionView(frame: view.bounds)
        cv.dataSource = presenter as? HomePhotoPresenter
        listView = cv
        view.addSubview(cv)
    }
    
    func reloadPhotos(_ photos: [Photo]) {
        listView?.reloadData()
    }
}
