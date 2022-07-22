//
//  AppMainBottomView.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit
import XHBCommonSwiftLib

protocol AppMainBottomViewDelegate: AnyObject {
    
    func bottomView(_ bottomView: AppMainBottomView, didSelect item: AppMainBottomItemView)
}

class AppMainBottomView: UIView {
    
    var items: [AppMainBottomItemView]? {
        willSet {
            items?.forEach { $0.removeFromSuperview() }
        }
        didSet {
            layoutSubviews()
        }
    }
    
    weak var delegate: AppMainBottomViewDelegate?
    
    var selectedItem: Int? {
        didSet {
            guard let selectedItem = selectedItem,
                  let items = items,
                  (0..<items.count).contains(selectedItem) else {
                return
            }
            items[selectedItem].selected = !items[selectedItem].selected
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
       
    }
    
    override func layoutSubviews() {
        guard let items = items else { return }
        
        let itemSize: CGSize = .init(width: height, height: height)
        var start: CGPoint = .init(x: (width - CGFloat(items.count) * itemSize.width) / 2 , y: 0)
        items.forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                           action: #selector(selectItemViewAction(_:))))
            $0.frame = .init(origin: start, size: itemSize)
            start.x += $0.right
            addSubview($0)
        }
    }
    
    @objc func selectItemViewAction(_ sender: UITapGestureRecognizer) {
        guard let itemView = sender.view as? AppMainBottomItemView else { return }
        delegate?.bottomView(self, didSelect: itemView)
    }
}
