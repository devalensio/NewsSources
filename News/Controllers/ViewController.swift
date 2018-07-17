//
//  ViewController.swift
//  News
//
//  Created by Devdots on 04/07/18.
//  Copyright © 2018 Devdots. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    var newsUrl : String = ""
    
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
        
        newsUrl = url
        
        performSegue(withIdentifier: "GoToListPage", sender: self)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToListPage" {
            
            let destinationVC = segue.destination as! NewsList
            
            destinationVC.urlPassedOver = newsUrl
            
        }
        
    }
    
}


