//
//  ViewController.swift
//  jokes
//
//  Created by Johnathan Chen on 10/27/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var punchLineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networking = Network()
        networking.getJoke(completion: {jokelist in
            DispatchQueue.main.sync {
                self.typeLabel.text = jokelist?.type
                self.jokeLabel.text = jokelist?.setup
                self.punchLineLabel.text = jokelist?.punchline
                self.reloadInputViews()
            }
            
        })
        
        }
        
    }


struct Jokes : Codable {
    var type: String
    var setup: String
    var punchline: String
    
    init(type : String, setup : String, punchline: String) {
        self.type = type
        self.setup = setup
        self.punchline = punchline
    }
}


class Network {
    let session = URLSession.shared
    let baseURL = URL(string: "https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_joke")!
    
    func getJoke(completion: @escaping(Jokes?)->Void) {
        
        let request = URLRequest(url: baseURL)
        
//        session.dataTask(with: request) {(data, response, error) in
//
//            do{
//            if let data = data {
//                let jokeList = try? JSONDecoder().decode(Jokes.self, from: data)
//                print(jokeList)
//                return completion(jokeList)
//
//                }
//                catch{print("error here")}
//            }
//            }.resume()
//        }
        
        let task = session.dataTask(with: request){data,response,error in
            
            guard let data = data else {return}
            do{
                let jokeList = try JSONDecoder().decode(Jokes.self, from: data)
                
                return completion(jokeList)
                
            }
            catch{ print("error")}
    }
        task.resume()
}
}











