//
//  HeadlinesViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 27/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher
import ProgressHUD

class HeadlinesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headlinesTableView: UITableView!
    @IBOutlet weak var headlinesLabel: UILabel!
    let cellIdentifier = "HeadlinesTableViewCell"
    let coreDataController = CoreDataController.shared
    var headlines:[Article]=[]
    var fetchedArticles:[FavouritArticle]=[]
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
    
    func markAsFavourite(cell: UITableViewCell) {
        guard let indexPath = self.headlinesTableView.indexPath(for: cell) else {return}
        let mainCtx = self.coreDataController.mainCtx
        let favorite = FavouritArticle(context: mainCtx)
        favorite.articleID = self.headlines[indexPath.row].source.id
        favorite.articleName = self.headlines[indexPath.row].source.name
        favorite.isFavourite = true
        if self.coreDataController.save() {
            self.showToast(message: "Saved as favourite", font: .systemFont(ofSize: 18.0))
        }
    }

//function  showToast copied from
//https://stackoverflow.com/questions/31540375/how-to-toast-message-in-swift
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headlinesTableView.dataSource = self
        self.headlinesTableView.delegate = self
        self.headlinesTableView.register(HeadlinesCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        setLabel()
        fetchHeadlines()
        fetchFavourites()
    }
    
    func fetchFavourites() {
        let ctx = self.coreDataController.mainCtx
        let fetchRequest: NSFetchRequest<FavouritArticle> = FavouritArticle.fetchRequest()
        do{
            self.fetchedArticles = try ctx.fetch(fetchRequest)
        } catch let err {
            self.showToast(message: "Error fetching favourite articles \(err)", font: .systemFont(ofSize: 20.0))
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! HeadlinesCell
        cell.link = self
        let headline = self.headlines[indexPath.row]
        
        guard let article = isFavorite(headline: headline) else {return}
        cell.accessoryView?.tintColor = article.isFavourite ? .red : .lightGray
        cell.imageView?.kf.setImage(with: headline.urlToImage, placeholder: UIImage(imageLiteralResourceName: "ninja"))
        cell.textLabel?.text = headline.title
        cell.selectionStyle = .none
        return cell
    }
    
    func isFavorite(headline: Article) -> Article {
        for article in self.fetchedArticles{
            if headline.source.id == article.articleID && headline.source.name == article.articleName {
                    print("it is favourite"+headline.source.id+" "+article.articleID+" "+headline.source.name+" "+article.articleName)
                return article
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let articleViewController = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        
        articleViewController.source = self.headlines[indexPath.row]
        
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
}
