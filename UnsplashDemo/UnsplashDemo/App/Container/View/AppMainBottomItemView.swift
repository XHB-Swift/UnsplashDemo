//
//  AppMainBottomItemView.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit

struct AppMainBottomItemModel {
    
    var title: String
    var iconName: String
    var selectedIconName: String
}

final class AppMainBottomItemViewFactory {
    
    class func makeItemViews(with itemModels: [AppMainBottomItemModel],
                             size: CGSize) -> [AppMainBottomItemView] {
        return itemModels.map {
            let itemView = AppMainBottomItemView(frame: .init(origin: .zero, size: size))
            itemView.setTitle($0.title)
            itemView.setImage(.init(named: $0.iconName))
            itemView.setSelectedImage(.init(named: $0.selectedIconName))
            return itemView
        }
    }
}

class AppMainBottomItemView: UIView {
    
    private var selectedView: UIImageView = .init()
    
    private weak var iconView: UIImageView?
    private weak var titleView: UILabel?
    
    var selected = false {
        didSet {
            selectedView.isHidden = !selected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        selectedView.frame = bounds
        selectedView.contentMode = .scaleToFill
        selectedView.isHidden = true
        addSubview(selectedView)
        let imageView = UIImageView()
        let labelView = UILabel()
        labelView.textAlignment = .center
        labelView.font = .init(name: "PingFangSC-Regular", size: 12)
        addSubview(imageView)
        addSubview(labelView)
        iconView = imageView
        titleView = labelView
    }
    
    override func layoutSubviews() {
        selectedView.frame = bounds
        iconView?.frame = .init(origin: .init(x: (width - 48) / 2, y: 0),
                                size: .init(width: 48, height: 48))
        titleView?.frame = .init(origin: .init(x: 0, y: iconView?.bottom ?? 0),
                                 size: .init(width: width, height: 12))
    }
    
    func setImage(_ image: UIImage?) {
        iconView?.image = image
    }
    
    func setTitle(_ title: String) {
        titleView?.text = title
    }
    
    func setSelectedImage(_ image: UIImage?) {
        selectedView.image = image
    }
}
