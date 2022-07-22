//
//  Photo.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import Foundation

public struct Photo: Codable {
    
    let id: String
    let width: Int
    let height: Int
    let urls: PhotoUrls
}

public struct PhotoUrls: Codable {
    
    let raw: String
    let full: String
    let small: String
    let thumb: String
    let regular: String
}
