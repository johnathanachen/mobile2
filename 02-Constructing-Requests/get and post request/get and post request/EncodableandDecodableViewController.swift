//
//  EncodableandDecodableViewController.swift
//  get and post request
//
//  Created by Johnathan Chen on 11/4/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class EncodableandDecodableViewController: UIViewController {
    @IBAction func get(_ sender: UIButton) {
        
    }
    @IBAction func send(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let newPost = Post(userId: 234, id: 5, title: "suhhh duhhh", body: "this is the bodayy")
        
        do {
            let jsonBody = try JSONEncoder().encode(newPost)
            request.httpBody = jsonBody
        } catch {}
        
       
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, _) in
            guard let data = data else  { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch { }
        }
        
       
        task.resume()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
