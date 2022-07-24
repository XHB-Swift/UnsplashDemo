//
//  HomePhotoCollectionViewCell.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/22.
//

import UIKit
import XHBCommonSwiftLib

class HomePhotoCollectionViewCell: UICollectionViewCell {
    
    private weak var imageView: UIImageView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let imgView = UIImageView(frame: bounds)
        imageView = imgView
        contentView.addSubview(imgView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imgView = UIImageView(frame: bounds)
        imageView = imgView
        contentView.addSubview(imgView)
    }
    
    func setImage(with url: String) {
        imageView?.setImage(with: url)
    }
}
