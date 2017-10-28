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
        let networking = Networking()
        networking.getListings(completion: { listings in listings })
    }

}

struct AirbnbListing: Codable
{

    var bathroom: Double
    var bedrooms : Int
    var beds : Double
    var city : String
    var picture_url : String
    
    init(bathroom : Double, bedrooms: Int, beds: Double, city: String, picture_url : String) {
        self.bathroom = bathroom
        self.bedrooms = bedrooms
        self.beds = beds
        self.city = city
        self.picture_url = picture_url
    }
}

struct ListingList : Decodable {
    let search_results: [AirbnbListing]
}


class Networking {
    let session = URLSession.shared
    let baseURL = URL(string: "https://api.airbnb.com/v2//search_results?client_id=915pw2pnf4h1aiguhph5gc5b2")!
    
    func getListings(completion: @escaping (AirbnbListing?)->Void) {
        let urlRequest = URLRequest(url: baseURL)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {return}
            do {
                let propertyList = try? JSONDecoder().decode(ListingList.self, from: data)
                print(propertyList!)
            }
            catch {
                print("error")
            }
        }
        task.resume()
    }
}
























