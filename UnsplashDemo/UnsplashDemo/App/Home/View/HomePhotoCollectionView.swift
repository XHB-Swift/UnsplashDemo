//
//  HomePhotoCollectionView.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/22.
//

import UIKit

protocol HomePhotoCollectionViewLayoutDelegate: NSObjectProtocol {
    
    func homePhotoView(_ homePhotoView: HomePhotoCollectionView,
                       layout: HomePhotoCollectionViewLayout,
                       widthHeightScaleForItemAt indexPath: IndexPath) -> CGFloat
}

class HomePhotoCollectionViewLayout: UICollectionViewLayout {
    
    private var layoutAttributes: Dictionary<IndexPath, UICollectionViewLayoutAttributes>
    private var layoutElements: [UICollectionViewLayoutAttributes] = .init()
    private var contentSize: CGSize = .zero
    
    var itemSize: CGSize = .zero
    override var collectionViewContentSize: CGSize { contentSize }
    
    weak var delegate: HomePhotoCollectionViewLayoutDelegate?
    
    override init() {
        layoutAttributes = .init()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        layoutAttributes = .init()
        super.init(coder: coder)
    }
    
    override func prepare() {
        guard let collectionView = collectionView as? HomePhotoCollectionView else { return }
        contentSize.width = collectionView.width
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let spacing = (collectionView.width - itemSize.width * 2) / 3
        var x: CGFloat = spacing
        var waterFrame: (maxY0: CGFloat, maxY1: CGFloat) = (spacing, spacing)
        (0..<numberOfItems)
            .forEach {
                let indexPath = IndexPath(item: $0, section: 0)
                let layouts: UICollectionViewLayoutAttributes = .init(forCellWith: indexPath)
                let scale = delegate?.homePhotoView(collectionView,
                                                    layout: self,
                                                    widthHeightScaleForItemAt: indexPath) ?? 1
                let size: CGSize = .init(width: itemSize.width,
                                         height: scale <= 0 ? itemSize.height : itemSize.width / scale)
                if $0 % 2 == 0 {
                    layouts.frame = .init(origin: .init(x: x, y: waterFrame.maxY0 + spacing),
                                                   size: size)
                    waterFrame.maxY0 = layouts.frame.maxY
                    x = layouts.frame.maxX + spacing
                } else {
                    layouts.frame = .init(origin: .init(x: x, y: waterFrame.maxY1 + spacing), size: size)
                    waterFrame.maxY1 = layouts.frame.maxY
                    x = spacing
                }
                contentSize.height = max(waterFrame.maxY0, waterFrame.maxY1)
                layoutAttributes[indexPath] = layouts
            }
        layoutElements = layoutAttributes.sorted { $0.key < $1.key }.map { $0.value }
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if layoutAttributes.isEmpty {
            return super.layoutAttributesForElements(in: rect)
        } else {
            return layoutElements
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {
            layoutAttributes.removeAll()
            layoutElements.removeAll()
            return true
        }
        if collectionView.bounds.size != newBounds.size {
            contentSize = .zero
            layoutAttributes.removeAll()
            layoutElements.removeAll()
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
