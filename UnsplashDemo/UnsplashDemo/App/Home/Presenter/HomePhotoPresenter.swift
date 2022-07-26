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
        vc?.reloadPhotos()
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

extension HomePhotoPresenter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomePhotoPresenter: HomePhotoCollectionViewLayoutDelegate {
    
    func homePhotoView(_ homePhotoView: HomePhotoCollectionView,
                       layout: HomePhotoCollectionViewLayout,
                       widthHeightScaleForItemAt indexPath: IndexPath) -> CGFloat {
        
        let photo = photos[indexPath.item]
        let width = CGFloat(photo.width)
        let height = CGFloat(photo.height)
        
        return height <= 0 ? 1 : width / height
    }
}
