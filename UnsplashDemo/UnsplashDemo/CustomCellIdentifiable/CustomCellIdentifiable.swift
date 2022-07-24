//
//  CustomCellIdentifiable.swift
//  UnsplashDemo
//
//  Created by 谢鸿标 on 2022/7/24.
//

import UIKit

public protocol CustomCellIdentifiable: AnyObject {
    
    static var identifier: String { get }
}

extension UITableViewCell: CustomCellIdentifiable {
    
    static public var identifier: String { NSStringFromClass(self) }
}

extension UICollectionViewCell: CustomCellIdentifiable {
    
    public static var identifier: String { NSStringFromClass(self) }
}

public protocol ListViewCellRegisterable {
    
    func register<CellType: CustomCellIdentifiable>(cellType: CellType.Type)
}

extension UITableView: ListViewCellRegisterable {
    
    public func register<CellType: CustomCellIdentifiable>(cellType: CellType.Type) {
        register(cellType, forCellReuseIdentifier: cellType.identifier)
    }
}

extension UICollectionView: ListViewCellRegisterable {
    
    public func register<CellType: CustomCellIdentifiable>(cellType: CellType.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
}
