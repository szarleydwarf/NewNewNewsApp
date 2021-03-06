//
//  Headlines.swift
//  NewsNewsNews
//
//  Created by The App Experts on 27/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation

struct Headlines: Decodable {
    let articles:[Article]
}

struct Article:Decodable{
    let title:String
    let description:String?
    let url:URL
    let urlToImage:URL
    let source:Source
}

struct Source: Decodable {
    let id:String
    let name:String
}
