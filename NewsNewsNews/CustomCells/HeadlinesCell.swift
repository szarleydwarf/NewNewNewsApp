//
//  HeadlinesCell.swift
//  NewsNewsNews
//
//  Created by The App Experts on 27/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

protocol HeadlinesCellDelegator {
    func markAsFavourite(cell: HeadlinesCell)
}

class HeadlinesCell: UITableViewCell {
    let favButton = UIButton(type: .system)
    var delegate: HeadlinesViewController?
          
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        backgroundColor = .brown
        favButton.setImage(UIImage(imageLiteralResourceName: "star"), for: .normal)
        favButton.tintColor = .systemGray
        favButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        favButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = favButton
    }
    
    @objc private func handleMarkAsFavorite() {
        self.favButton.tintColor = .red
        self.delegate?.markAsFavourite(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

