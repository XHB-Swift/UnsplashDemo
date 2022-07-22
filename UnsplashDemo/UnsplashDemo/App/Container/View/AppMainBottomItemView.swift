//
//  AppMainBottomItemView.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit

class AppMainBottomItemView: UIView {
    
    private var stackView: UIStackView = .init()
    
    private weak var iconView: UIImageView?
    private weak var titleView: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        stackView.frame = bounds
        stackView.axis = .vertical;
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        let imageView = UIImageView()
        let labelView = UILabel()
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelView)
        iconView = imageView
        titleView = labelView
    }
    
    func setImage(_ image: UIImage) {
        iconView?.image = image
    }
    
    func setTitle(_ title: String) {
        titleView?.text = title
    }
}
