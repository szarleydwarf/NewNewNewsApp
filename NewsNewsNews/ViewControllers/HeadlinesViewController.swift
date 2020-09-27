//
//  HeadlinesViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 27/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import Kingfisher
import ProgressHUD

class HeadlinesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headlinesTableView: UITableView!
    @IBOutlet weak var headlinesLabel: UILabel!
    let cellIdentifier = "HeadlinesTableViewCell"
    var headlines:[Article]=[]
    var source:NewsCategory?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProgressHUD.colorAnimation = .red
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.show()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressHUD.dismiss()
    }
    
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
//        self.headlinesTableView.register(UINib(nibName: "HeadlinesTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        
        setLabel()
        fetchHeadlines()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let headline = self.headlines[indexPath.row]

        cell.imageView?.kf.setImage(with: headline.urlToImage, placeholder: UIImage(imageLiteralResourceName: "ninja"))
        cell.textLabel?.text = headline.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let articleViewController = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        
        articleViewController.source = self.headlines[indexPath.row]
        
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
}
