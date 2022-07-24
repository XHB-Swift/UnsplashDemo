//
//  HomePhotoCollectionView.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/22.
//

import UIKit

class HomePhotoCollectionViewLayout: UICollectionViewLayout {
    
    private var layoutAttributes: Dictionary<IndexPath, UICollectionViewLayoutAttributes>
    
    var itemSize: CGSize = .zero
    
    override init() {
        layoutAttributes = .init()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        layoutAttributes = .init()
        super.init(coder: coder)
    }
    
    override func prepare() {
        layoutAttributes.removeAll()
        guard let collectionView = collectionView else { return }
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        var center: CGPoint = .zero
        (0..<numberOfItems)
            .forEach {
                let indexPath = IndexPath(item: $0, section: 0)
                let layoutAttributes: UICollectionViewLayoutAttributes = .init(forCellWith: indexPath)
                layoutAttributes.size = itemSize
                if center == .zero {
                    center = layoutAttributes.center
                }
                layoutAttributes.center.x = center.x + 5
                layoutAttributes.center.y = center.y + 5
                if $0 % 2 == 0 {
                    center.x = layoutAttributes.center.x + 5 + itemSize.width
                    center.y = layoutAttributes.center.y + 5
                } else {
                    center.x = layoutAttributes.center.x - 5 - itemSize.width
                    center.y = layoutAttributes.center.y + 5 + itemSize.height
                }
                self.layoutAttributes[indexPath] = layoutAttributes
            }
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if layoutAttributes.isEmpty {
            return super.layoutAttributesForElements(in: rect)
        } else {
            return layoutAttributes
                .sorted { $0.key < $1.key }
                .map { $0.value }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath]
    }
}

class HomePhotoCollectionView: UICollectionView {
    
    init(frame: CGRect) {
        let layout = HomePhotoCollectionViewLayout()
        let _size = (frame.width - 15) / 2
        layout.itemSize = .init(width: _size, height: _size)
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(cellType: HomePhotoCollectionViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
