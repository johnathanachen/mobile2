//
//  ViewController.swift
//  postAPI
//
//  Created by Johnathan Chen on 10/25/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
 
    func start() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print("ERROR")
            }
            else
            {
                if let detail = data
                {
                    do
                    {
                        let myJSON = try JSONSerialization.jsonObject(with: detail, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let title = myJSON["title"]
                        {
                            print(title)
                        }
                        if let body = myJSON["body"]
                        {
                            print(body)
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
            
            }
        task.resume()

            
    }
    

}



