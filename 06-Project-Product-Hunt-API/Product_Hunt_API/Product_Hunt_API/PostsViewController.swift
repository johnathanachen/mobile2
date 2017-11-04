//
//  PostsViewController.swift
//  Product_Hunt_API
//
//  Created by Johnathan Chen on 11/1/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let networking = Networking()
        networking.fetch(route: .posts) { (data) in
            let producthunt = try? JSONDecoder().decode(ProductHunt.self, from: data)
            guard let newPosts = producthunt?.posts else { return }
            self.products = newPosts
            print(self.products)
            DispatchQueue.main.async {
//                PostsViewController.reloadData()
            }
        }

        
    }





}
