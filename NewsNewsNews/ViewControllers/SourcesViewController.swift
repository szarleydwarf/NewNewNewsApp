//
//  SourcesViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 26/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourcesTableView: UITableView!
    var sourceArray:[String]=[]
    let cellIdentifier: String = "sourceCell"
    var category:String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Source category > \(category)")
        self.sourcesTableView.dataSource = self
        self.sourcesTableView.delegate = self
        
        setLabelText()
        fetchSources()
    }
    
    fileprivate func setLabelText() {
        guard var text = self.sourceLabel.text else { return }
        guard let unwrapedCategory = category else { return }
        text += unwrapedCategory
        self.sourceLabel.text = text
    }
    
    fileprivate func fetchSources() {
        let urlComponents = NetworkURLComponent()
        var urlComponent = urlComponents.urlComponents
        guard let category = self.category else {return}
        urlComponent.queryItems?.append( URLQueryItem(name: "category", value: category))
        print("query url> \(urlComponent.url)")
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
