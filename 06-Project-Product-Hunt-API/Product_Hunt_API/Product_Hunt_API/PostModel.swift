
//
//  PostModel.swift
//  Product_Hunt_API
//
//  Created by Johnathan Chen on 11/3/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import Foundation

struct ProductHunt: Decodable {
    let posts: [Product]
}

struct Product {
    let name: String?
    let tagline: String?
    let imageurl: String?
    let votes: Int?
    
    init(name: String?, tagline: String?, imageurl: String?, votes: Int?) {
        self.name = name
        self.tagline = tagline
        self.imageurl = imageurl
        self.votes = votes
    }
}

extension Product: Decodable {
    
    enum additionalKeys: String, CodingKey {
        case name
        case tagline
        case thumbnail
        case votes = "votes_count"
    }
    
    enum Thumbnail: String, CodingKey {
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        // Container
        let container = try decoder.container(keyedBy: additionalKeys.self)
        let votes = try container.decodeIfPresent(Int.self, forKey: .votes)
        let tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        let thumbnailContainer = try container.nestedContainer(keyedBy: Thumbnail.self, forKey: .thumbnail)
        let imageurl = try thumbnailContainer.decodeIfPresent(String.self, forKey: .imageURL)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
    
        self.init(name: name, tagline: tagline, imageurl: imageurl, votes: votes)
    }
}




