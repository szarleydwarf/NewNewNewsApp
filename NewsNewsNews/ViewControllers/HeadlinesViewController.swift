//
//  HeadlinesViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 27/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class HeadlinesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headlinesTableView: UITableView!
    @IBOutlet weak var headlinesLabel: UILabel!
    let cellIdentifier = "headlinesCell"
    var headlines:[Article]=[]
    var source:NewsCategory?
    
    fileprivate func fetchHeadlines(){
        var urlComponents = NetworkURLComponent()
        urlComponents.sourceQueryItem.value = self.source?.id
        let urlComponet = urlComponents.urlComponentsHeadLines
        
        guard let url = urlComponet.url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard let headlines = try? JSONDecoder().decode(Headlines.self, from: data) else {return}
            
            self.headlines.append(contentsOf: headlines.articles)
            DispatchQueue.main.async {
                self.headlinesTableView.reloadData()
            }
        }.resume()
    }
    
    fileprivate func setLabel() {
        guard var text = self.headlinesLabel.text else {return}
        guard let sourceName = self.source?.name else{return}
        text += sourceName
        self.headlinesLabel.text = text
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headlinesTableView.dataSource = self
        self.headlinesTableView.delegate = self
        self.headlinesTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        setLabel()
        fetchHeadlines()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let article = self.headlines[indexPath.row]
        cell.textLabel?.text = article.title
        if let data = try? Data(contentsOf: article.urlToImage){
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }
}
