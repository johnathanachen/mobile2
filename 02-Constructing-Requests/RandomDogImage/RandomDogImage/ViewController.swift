//
//  ViewController.swift
//  RandomDogImage
//
//  Created by Johnathan Chen on 10/25/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    var currentImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network()
    }
    

    @IBAction func newDoggieButton(_ sender: UIButton) {
        network()
    }
    
    func network() {
        print("Begin of code")
        
        
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print("ERROR")
            }
            else
            {
                if let image = data
                {
                    do
                    {
                        let myJSON = try JSONSerialization.jsonObject(with: image, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let message = myJSON["message"]
                        {
                            func downloadImage(url: URL) {
                                print("Download Started")
                                getDataFromUrl(url: url) { data, response, error in
                                    guard let data = data, error == nil else { return }
                                    print(response?.suggestedFilename ?? url.lastPathComponent)
                                    print("Download Finished")
                                    DispatchQueue.main.async() {
                                        self.dogImageView.image = UIImage(data: data)
                                    }
                                }
                            }
                            
                            if let url = URL(string: message as! String ) {
                                DispatchQueue.main.async() {
                                self.dogImageView.contentMode = .scaleAspectFill
                                }
                                downloadImage(url: url)
                            }
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
            
        }
        task.resume()
        
        func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data, response, error)
                }.resume()
        }
        
       
    
    }

 
    
}
