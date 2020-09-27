//
//  collectionViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 26/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class CollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    let cellIdentifier = "HeadlineCell"
    var headlines:[Article]=[]
    var source:NewsCategory?
    
    fileprivate func fetchHeadlines(){
        var urlComponents = NetworkURLComponent()
        urlComponents.sourceQueryItem.value = self.source?.id
        var urlComponet = urlComponents.urlComponentsHeadLines
        
        guard let url = urlComponet.url else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard let headlines = try? JSONDecoder().decode(Headlines.self, from: data) else {return}
//            print("headlines \(headlines.articles)")
            self.headlines.append(contentsOf: headlines.articles)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(HeadlineCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        fetchHeadlines()
    }
    
    //UICollectionViewDelegateFlowLayout methods
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 10)), height: 120)
         return cellSize
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInset.left
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return sectionInset
     }
     
     
     //UICollectionViewDatasource methods
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
     }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.headlines.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! HeadlineCell
         
//             cell.backgroundColor = self.randomColor()
        cell.articleDescriptionLabel?.text = "LOL"

//             update(the: cell, with: self.headlines[indexPath.row])
                
             return cell
         }
         
    func update(the cell:HeadlineCell, with article: Article) {
         cell.articleTitleLabel.text = article.title
         cell.articleDescriptionLabel.text = article.description

        guard let data = try? Data(contentsOf: article.urlToImage) else {return}
        cell.imagePlaceholder.image = UIImage(data: data)

    }
         // custom function to generate a random UIColor
         func randomColor() -> UIColor{
             let red = CGFloat(drand48())
             let green = CGFloat(drand48())
             let blue = CGFloat(drand48())
             return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
         }


}
