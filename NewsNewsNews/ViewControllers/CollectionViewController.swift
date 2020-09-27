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
    let cellIdentifier = "HeadLinesCell"
    var source:NewsCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        print("source in collection \(self.source)")
    }
    
    //UICollectionViewDelegateFlowLayout methods
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
     {
         let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 10)), height: 120)
         return cellSize
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
     {
         return 10
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
     {
         let sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
         return sectionInset
     }
     
     
     //UICollectionViewDatasource methods
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 2
     }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 10
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as UICollectionViewCell
         
             cell.backgroundColor = self.randomColor()
             
             
             return cell
         }
         

         // custom function to generate a random UIColor
         func randomColor() -> UIColor{
             let red = CGFloat(drand48())
             let green = CGFloat(drand48())
             let blue = CGFloat(drand48())
             return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
         }


}
