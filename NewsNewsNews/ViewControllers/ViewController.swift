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
    var url:URL?
    let newsCategory = NewsCategoryAPI.shared
    var newsArray:[NewsCategory]=[]
    
    fileprivate func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        newsArray = newsCategory.fetchData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

