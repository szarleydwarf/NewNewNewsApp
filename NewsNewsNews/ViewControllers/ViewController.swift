//
//  ViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 25/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "theCell"
    let urlString:String = "https://newsapi.org/v2/sources?apiKey=86316c5c482a49cca90420b39ee0a695"
    var categoriesArray: [String] = []
    
    fileprivate func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    fileprivate func fetchCategories() {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {return}
            let sources = try? JSONDecoder().decode(Sources.self, from: data)
            guard let unwrapedSources = sources else {return}
            for category in unwrapedSources.sources {
                self.categoriesArray.append(category.category)
            }
            
            DispatchQueue.main.async {
                self.categoriesArray = Array(Set(self.categoriesArray))
                self.tableView.reloadData()
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        fetchCategories()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = self.categoriesArray[indexPath.row].capitalized
        
        return cell
    }
}


struct Sources: Decodable {
    let sources:[NewsCategory]
}

struct NewsCategory:Decodable {
    let category: String
}
