//
//  AppMainBottomView.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit
import XHBCommonSwiftLib

protocol AppMainBottomViewDelegate: AnyObject {
    
    func numberOfItems(in bottomView: AppMainBottomView) -> Int
    func bottomView(_ bottomView: AppMainBottomView, didSelect item: AppMainBottomItemView)
}

class AppMainBottomView: UIView {
    
    private var line0: UIStackView = .init()
    
    weak var delegate: AppMainBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        line0.frame = bounds
        line0.axis = .horizontal
        line0.distribution = .fillEqually
        addSubview(line0)
    }
    
    override func layoutSubviews() {
        
    }
}
