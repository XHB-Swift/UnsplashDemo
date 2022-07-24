//
//  VIPER.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/22.
//

import UIKit

public protocol EntityModule {}

public protocol InteractorModule: AnyObject {
    
    var presenter: PresenterModule? { get set }
}

public protocol PresenterModule: AnyObject {
    
    var view: ViewModule? { get set }
    var interactor: InteractorModule? { get set }
    var router: RouterModule? { get set }
}

public protocol ViewModule: UIResponder {
    
    var presenter: PresenterModule? { get set }
}

public protocol RouterModule: AnyObject {
    
    static func createModule() -> UIViewController
}
