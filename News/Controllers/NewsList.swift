//
//  NewsList.swift
//  News
//
//  Created by Devdots on 05/07/18.
//  Copyright © 2018 Devdots. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NewsList: UITableViewController  {
    
    @IBOutlet var newsTableView: UITableView!
    
    var newsArray : [News] = [News]()
    
    var urlPassedOver : String? {
        didSet {
           loadNews()
            SVProgressHUD.show()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")

        configureTableView()
        
        print(urlPassedOver!)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath) as! CustomNewsCell
        
        if let url = NSURL(string: newsArray[indexPath.row].image) {
            if let data = NSData(contentsOf: url as URL) {
                cell.imageNews.contentMode = UIViewContentMode.scaleToFill
                cell.imageNews.image = UIImage(data: data as Data)
            }
        }
        
        cell.bodyNews.text = newsArray[indexPath.row].body
        cell.titleNews.text = newsArray[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsArray.count
        
    }
    
    func loadNews() {
        
        Alamofire.request(urlPassedOver!, method: .get).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                print("Success! Got the News data")
                
                let newsJSON : JSON = JSON(response.result.value!)
                
                self.updateNewsData(json: newsJSON)
                
                SVProgressHUD.dismiss()
                
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func updateNewsData(json: JSON) {
        
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "GoToWebView", sender: indexPath)

    }

    func configureTableView() {
        newsTableView.rowHeight = 312
        newsTableView.estimatedRowHeight = 350
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

        if segue.identifier == "GoToWebView" {

            let row = (sender as! NSIndexPath).row
            let dataUrl = newsArray[row].url
            let destinationVC = segue.destination as! WebView
            
            print(dataUrl)

            destinationVC.url = dataUrl

        }

    }

}

//extension NewsList: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let filteredNews = dataPassedOver?.filter { $0.title.lowercased().contains(searchBar.text!.lowercased()) }
//
//        loadItems(with: filteredNews!)
//
//
//    }
//
//}





