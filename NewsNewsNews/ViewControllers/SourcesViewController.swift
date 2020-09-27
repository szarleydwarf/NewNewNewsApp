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
    var sourceArray:[NewsCategory]=[]
    let cellIdentifier: String = "sourceCell"
    var category:String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sourcesTableView.dataSource = self
        self.sourcesTableView.delegate = self
        self.sourcesTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
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
        var urlComponent = urlComponents.urlComponentsSource
        guard let category = self.category else {return}
        urlComponent.queryItems?.append( URLQueryItem(name: "category", value: category))
        guard let url = urlComponent.url else{return}
        print("query url> \(url)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let sources = try? JSONDecoder().decode(Sources.self, from: data)
            guard let source = sources else {return}
            self.sourceArray.append(contentsOf: source.sources)
            DispatchQueue.main.async {
                self.sourcesTableView.reloadData()
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        cell.textLabel?.textAlignment = .center
        //        cell.backgroundColor = .blue
        cell.textLabel?.text = self.sourceArray[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collectionViewController = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        
        collectionViewController.source = self.sourceArray[indexPath.row]
        self.navigationController?.pushViewController(collectionViewController, animated: true)
    }
}
