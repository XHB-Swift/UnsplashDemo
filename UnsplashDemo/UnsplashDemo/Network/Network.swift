//
//  Network.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import Foundation
import XHBFoundationSwiftLib

private let AccessKey = "p5CvNX85stB0M0lc7GcSErdFxg0I3KdJu6Y8bOhf1ro"
private let SecretKey = "zs-H1z_wQGAk7GucbaUheceyLDo9JZ_RYwSPiUohwO8"
private let NetworkHost = "https://api.unsplash.com"

public enum API {
    
    case GET(String)
    case POST(String, [String:String])
    
    var toRequest: URLRequest? { .init(api: self) }
}

extension URLRequest {
    
    public init?(api: API) {
        switch api {
        case .GET(let string):
            let urlString = string.hasPrefix(NetworkHost) ? string : "\(NetworkHost)\(string)"
            guard let url = URL(string: urlString) else { return nil }
            self.init(url: url)
        case .POST(let string, let dictionary):
            let urlString = string.hasPrefix(NetworkHost) ? string : "\(NetworkHost)\(string)"
            guard let url = URL(string: urlString) else { return nil }
            self.init(url: url)
            do {
                httpBody = try JSONEncoder().encode(dictionary)
            } catch {
                return nil
            }
        }
        setValue("Client-ID \(AccessKey)", forHTTPHeaderField: "Authorization")
    }
}

extension URLSession {
    
    public func apiObservation(_ api: API) -> URLSession.DataTaskOservation? {
        guard let request = api.toRequest else { return nil }
        return .init(request: request, session: self)
    }
}
