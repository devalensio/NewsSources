//
//  ViewController.swift
//  News
//
//  Created by Devdots on 04/07/18.
//  Copyright © 2018 Devdots. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var newsArray : [News] = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func asd(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            getNewsData(url: "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=a9259a4e061643a99176bdc73d02126f")
        case 1:
            getNewsData(url: "https://newsapi.org/v2/top-headlines?sources=cnn&apiKey=a9259a4e061643a99176bdc73d02126f")
        case 2:
            getNewsData(url: "https://newsapi.org/v2/top-headlines?sources=mirror&apiKey=a9259a4e061643a99176bdc73d02126f")
        default:
            break
        }
    }
    
    func getNewsData(url: String) {
        print(url)
        newsArray = []
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                
                
                print("Success! Got the News data")
                
                let newsJSON : JSON = JSON(response.result.value!)
                
                self.updateNewsData(json: newsJSON)
                
                self.connector()
                
            } else {
                print("Error \(String(describing: response.result.error))")
                
            }
        }
    }
    
    func updateNewsData(json: JSON) {
//        print(json)
        
        let dataJson = json["articles"]
        
        if json["articles"][0]["title"].string != nil {
            
            
    
            for counter in 0..<dataJson.count {
                let newNews = News()
                newNews.title = dataJson[counter]["title"].stringValue
                newNews.body = dataJson[counter]["description"].stringValue
                newNews.image = dataJson[counter]["urlToImage"].stringValue
                newNews.url = dataJson[counter]["url"].stringValue
                newsArray.append(newNews)

                
            }
        }
    }
    
    func connector() {
        performSegue(withIdentifier: "GoToListPage", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToListPage" {
            
            let destinationVC = segue.destination as! NewsList
            
            destinationVC.dataPassedOver = newsArray
            
        }
    }
    
    
}


