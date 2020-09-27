//
//  Sources.swift
//  NewsNewsNews
//
//  Created by The App Experts on 27/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation

struct Sources: Decodable {
    let sources:[NewsCategory]
}

struct NewsCategory:Decodable {
    let name: String
    let category: String
}
