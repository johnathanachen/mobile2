//
//  Networking.swift
//  Product_Hunt_API
//
//  Created by Johnathan Chen on 11/1/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Resource {
    case posts
    case comments
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .posts, .comments:
            return .get
        }
    }
    
    func path() -> String {
        switch self {
        case .posts:
            return "posts/all"
        case .comments:
            return "comments"
        }
    }
    
    func headers() -> [String: String] {
        let urlHeaders = ["Authorization" : "Bearer ae3328ef2b38c2fb625fe7d44fa7904810488646fb4cbf1ed9c86d61570b1090",
                          "Accept": "application/json",
                          "Content-Type": "application/json",
                          "Host": "api.producthunt.com"]
        return urlHeaders
    }
}



class Networking {
    let baseurl = "https://api.producthunt.com/v1/"
    let session = URLSession.shared
    
    func fetch(route: Resource, complete: @escaping (Data) -> Void) {
        guard let requestURL = URL(string: baseurl.appending(route.path())) else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = route.httpMethod().rawValue
        request.allHTTPHeaderFields = route.headers()
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let usableData = data {
                complete(usableData)
            }
        }
        task.resume()
    }
}

