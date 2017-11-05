//
//  postModel.swift
//  get and post request
//
//  Created by Johnathan Chen on 11/4/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import Foundation

struct Post: Encodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
