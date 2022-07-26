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
            waterFallLayout?.delegate = homePhotoPresenter
        }
    }
    var waterFallLayout: HomePhotoCollectionViewLayout? {
        listView?.collectionViewLayout as? HomePhotoCollectionViewLayout
    }
    private weak var listView: HomePhotoCollectionView?
    
    override func viewDidLoad() {
        
        title = "照片"
        view.backgroundColor = .white
        setupSubviews()
        requestPhotos()
    }
    
    func setupSubviews() {
        let cv = HomePhotoCollectionView(frame: view.bounds)
        cv.dataSource = presenter as? HomePhotoPresenter
        listView = cv
        view.addSubview(cv)
        waterFallLayout?.delegate = presenter as? HomePhotoPresenter
    }
    
    func requestPhotos() {
        let p = (presenter as? HomePhotoPresenter)
        let i = p?.interactor as? HomePhotoInteractor
        i?.requestPhotoList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11, *) {
            listView?.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            listView?.y = 20
            listView?.height = view.height - 20
        }
    }
    
    func reloadPhotos() {
        listView?.reloadData()
    }
}
