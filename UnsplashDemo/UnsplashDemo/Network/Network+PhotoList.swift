//
//  Network+PhotoList.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import Foundation

extension API {
    
    public static func list(page: Int = 1,
                            per_page: Int = 10,
                            order_by: String = "latest") -> API {
        return .GET("/photos?page=\(page)&per_page=\(per_page)&order_by=\(order_by)")
    }
}
