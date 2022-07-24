//
//  HomePhotoPresenter.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/24.
//

import UIKit

class HomePhotoPresenter: NSObject, PresenterModule {
    
    weak var view: ViewModule?
    var interactor: InteractorModule?
    var router: RouterModule?
    
    private var photos: [Photo] = .init()
    
    func reloadView(with photos: [Photo]) {
        self.photos = photos
        let vc = view as? HomePhotoViewController
        vc?.reloadPhotos(photos)
    }
}

extension HomePhotoPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePhotoCollectionViewCell.identifier, for: indexPath)
        
        if let _cell = cell as? HomePhotoCollectionViewCell {
            let photo = photos[indexPath.item]
            _cell.setImage(with: photo.urls.regular)
        }
        
        return cell
    }
}
