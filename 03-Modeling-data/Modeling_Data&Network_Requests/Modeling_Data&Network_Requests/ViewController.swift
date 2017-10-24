//
//  ViewController.swift
//  Modeling_Data&Network_Requests
//
//  Created by Johnathan Chen on 10/24/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//
// https://www.meetup.com/meetup_api/

import UIKit

class MeetUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

}

struct Event
{
    let rsvpLimit: Double
    let description: String
    let name: String
    let address: String
    let city: String
    
    init(rsvpLimit: Double, description: String, name: String, address: String, city: String)
    {
        self.rsvpLimit = rsvpLimit
        self.description = description
        self.name = name
        self.address = address
        self.city = city
    }
}
    
extension Event: Decodable
{
    enum Keys: String, CodingKey
    {
        case venue
    }
    
    enum VenueKeys: String, CodingKey
    {
        case address = "address_1"
        case city
    }
    
    enum EventKeys: String, CodingKey
    {
        case rsvpLimit = "rsvp_limit"
        case description
        case name
    }
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: EventKeys.self)
        let rsvpLimitDecoded = try container.decodeIfPresent(Double.self, forKey: .rsvpLimit)
    }
    
    }

struct EventList : Decodable
{
    let results : [Event]
}

class Network
{
    func getEvent(completion: @escaping (Result<[Event]>) -> Void) {
        <#body#>
    }
    }



