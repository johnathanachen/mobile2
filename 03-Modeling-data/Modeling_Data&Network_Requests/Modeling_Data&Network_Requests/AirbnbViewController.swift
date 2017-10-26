//
//  AirbnbViewController.swift
//  Modeling_Data&Network_Requests
//
//  Created by Johnathan Chen on 10/24/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class AirbnbViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

struct AirbnbListing
{

    var bathroom: Double
    var bedrooms : Int
    var beds : Double
    var city : String
    var thumbnailURL : String
    
    init(bathroom : Double, bedrooms: Int, beds: Double, city: String, thumbnailURL : String) {
        self.bathroom = bathroom
        self.bedrooms = bedrooms
        self.beds = beds
        self.city = city
        self.thumbnailURL = thumbnailURL
    }
}

extension AirbnbListing: Decodable
{
    enum Keys: String, CodingKey
    {
        case listing
        case bedrooms
        case beds
        case city
        case thumbnailURL = "thumbnail_url"
    }
    
    enum ListingKeys: String, CodingKey {
        case bathrooms
        case bedrooms
        case beds
        case city
        case thumbnailURL = "thumbnail_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let listingContainer = try container.nestedContainer(keyedBy: ListingKeys.self, forKey: .listing)
    }
    
    self.init(bathroom: bathrooms, bedrooms: bedrooms, beds: beds, city: city, thumbnailURL: thumbnailURL)
}

























