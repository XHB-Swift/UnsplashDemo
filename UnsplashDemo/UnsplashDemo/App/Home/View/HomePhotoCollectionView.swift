//
//  HomePhotoCollectionView.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/22.
//

import UIKit

class HomePhotoCollectionViewLayout: UICollectionViewLayout {
    
    private var layoutAttributes: Dictionary<IndexPath, UICollectionViewLayoutAttributes>
    private var contentSize: CGSize = .zero
    
    var itemSize: CGSize = .zero
    override var collectionViewContentSize: CGSize { contentSize }
    
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
        contentSize.width = collectionView.width
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let spacing = (collectionView.width - itemSize.width * 2) / 3
        var start: CGPoint = .init(x: spacing, y: spacing)
        contentSize.height = start.y
        (0..<numberOfItems)
            .forEach {
                let indexPath = IndexPath(item: $0, section: 0)
                let layoutAttributes: UICollectionViewLayoutAttributes = .init(forCellWith: indexPath)
                layoutAttributes.frame = .init(origin: start, size: itemSize)
                if $0 % 2 == 0 {
                    start.x = layoutAttributes.frame.maxX + spacing
                    start.y = layoutAttributes.frame.minY + spacing
                } else {
                    start.x = spacing
                    start.y = layoutAttributes.frame.maxY + spacing
                }
                self.layoutAttributes[indexPath] = layoutAttributes
                contentSize.height = start.y + itemSize.height
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
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return true }
        if collectionView.bounds.size != newBounds.size {
            contentSize = .zero
            return true
        }
        return super.shouldInvalidateLayout(forBoundsChange: newBounds)
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
