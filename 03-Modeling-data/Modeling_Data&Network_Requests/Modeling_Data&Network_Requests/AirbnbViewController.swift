//
//  AirbnbViewController.swift
//  Modeling_Data&Network_Requests
//
//  Created by Johnathan Chen on 10/24/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class AirbnbViewController: UIViewController {

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        startDisplay()
        
    }
    
    func startDisplay() {
        let networking = Networking()
        networking.getListings(completion: {listings in
            DispatchQueue.main.sync {
                print(listings)
                self.reloadInputViews()
                print(self.cityLabel.text)
            }
        })
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

extension AirbnbListing
{
    enum Keys: String, CodingKey
    {
        case listing
    }
    
    enum ListingKeys: String, CodingKey{
        case bathrooms
        case bedrooms
        case beds
        case city
        case picture_url = "picture_url"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let listingContainer = try container.nestedContainer(keyedBy: ListingKeys.self, forKey: .listing)
        let bathrooms = try listingContainer.decode(Double.self, forKey: .bathrooms)
        let bedrooms = try listingContainer.decode(Int.self, forKey: .bedrooms)
        let beds = try listingContainer.decode(Double.self, forKey: .beds)
        let city = try listingContainer.decode(String.self, forKey: .city)
        let picture_url = try listingContainer.decode(String.self, forKey: .picture_url)
        
        self.init(bathroom: bathrooms, bedrooms: bedrooms, beds: beds, city: city, picture_url: picture_url)
    }
}

// MARK: - Service layer
enum Result<T>
{
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error
{
    case couldNotParse
    case noData
    case networkError
}



class Networking {
    func getListings(completion: @escaping ([AirbnbListing])->Void)
    {
        let session = URLSession.shared
        let baseURL = URL(string: "https://api.airbnb.com/v2//search_results?client_id=915pw2pnf4h1aiguhph5gc5b2")!
        let urlRequest = URLRequest(url: baseURL)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data
            {
                guard let list = try? JSONDecoder().decode(ListingList.self, from: data) else {
//                    return completion(Result.failure(NetworkError.couldNotParse))
                    return
                }
                
                let listings = list.search_results
                
                print(listings)
                
                completion(listings)
                
            }
        }.resume()
    }
}
























