//
//  SourcesViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 26/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sourcesTableView: UITableView!
    var sourceArray:[String]=[]
    let cellIdentifier: String = "sourceCell"
    var category:String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sourcesTableView.dataSource = self
        self.sourcesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.backgroundColor = .blue
        
        
        return cell
    }

}
