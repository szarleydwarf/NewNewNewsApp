//
//  NetworkURLComponent.swift
//  NewsNewsNews
//
//  Created by The App Experts on 26/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation

struct NetworkURLComponent {
    var urlComponents:URLComponents{
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/sources?apiKey=86316c5c482a49cca90420b39ee0a695"
        
        return urlComponents
    }
    
}
