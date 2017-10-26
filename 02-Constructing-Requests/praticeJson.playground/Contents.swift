//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


//let url = URL(string: "http://api.fixer.io/latest")
//let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//    if error != nil
//    {
//        print("ERROR")
//    }
//    else
//    {
//        if let content = data
//        {
//            do
//            {
//                let myJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//
//                if let rates = myJSON["rates"] as? NSDictionary
//                {
//                    print(rates)
//                }
//            }
//            catch
//            {
//
//            }
//        }
//    }
//
//}
//
//task.resume()

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
                    print(message)
                }
            }
            catch
            {
                
            }
        }
    }
    
    }
task.resume()






PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
