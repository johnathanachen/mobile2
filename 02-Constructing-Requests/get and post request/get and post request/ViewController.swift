//
//  ViewController.swift
//  get and post request
//
//  Created by Johnathan Chen on 11/4/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func GET(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data, "this is data")
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    @IBAction func PUT(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}




