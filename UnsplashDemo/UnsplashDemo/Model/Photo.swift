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
    let color: String
    let urls: Urls
    let user: User
    var `description`: String?
}

extension Photo {
    
    public struct User: Codable {
        
        let id: String
        let username: String
        let name: String
        var portfolio_url: String?
        var bio: String?
        var location: String?
        let total_likes: Int
        let total_photos: Int
        let total_collections: Int
        var instagram_username: String?
        var twitter_username: String?
        let profile_image: ProfileImage
        let links: Links
    }
}

extension Photo.User {
    
    public struct ProfileImage: Codable {
        
        let small: String
        let medium: String
        let large: String
    }
}

extension Photo.User {
    
    public struct Links: Codable {
        
        let `self`: String
        let html: String
        let photos: String
        let likes: String
        let portfolio: String
    }
}

extension Photo {
    
    public struct Urls: Codable {
        
        let raw: String
        let full: String
        let small: String
        let thumb: String
        let regular: String
    }
}

extension Photo {
    
    public struct Links: Codable {
        
        let `self`: String
        let html: String
        let download: String
        let download_location: String
    }
    
}
