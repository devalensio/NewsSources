//
//  NewsList.swift
//  News
//
//  Created by Devdots on 05/07/18.
//  Copyright © 2018 Devdots. All rights reserved.
//

import UIKit

class NewsList: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var newsTableView: UITableView!
    
    var dataPassedOver : [News]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")
        
        configureTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath) as! CustomNewsCell
        
        if let url = NSURL(string: dataPassedOver![indexPath.row].image) {
            if let data = NSData(contentsOf: url as URL) {
                cell.imageNews.contentMode = UIViewContentMode.scaleToFill
                cell.imageNews.image = UIImage(data: data as Data)
            }
        }
        
        cell.bodyNews.text = dataPassedOver![indexPath.row].body
        cell.titleNews.text = dataPassedOver![indexPath.row].title
//        cell.imageNews.text = dataPassedOver![indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPassedOver!.count
    }
    
    func configureTableView() {
        newsTableView.rowHeight = 312
        newsTableView.estimatedRowHeight = 350
    }
    
}
