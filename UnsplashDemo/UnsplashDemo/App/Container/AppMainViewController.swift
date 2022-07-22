//
//  AppMainViewController.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit


class AppMainViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [
            HomeViewController()
        ]
        selectedIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        setupSubviews()
    }
    
    func setupSubviews() {
        
    }
}
