//
//  NetworkURLComponent.swift
//  NewsNewsNews
//
//  Created by The App Experts on 26/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import Foundation



struct NetworkURLComponent {
    private let scheme:String = "https"
    private let host:String = "newsapi.org"
    private let sourcePath:String = "/v2/sources"
    private let headlinesPath:String = "top-headlines"
    private let apiKey:[URLQueryItem] = [URLQueryItem(name: "apiKey", value: "86316c5c482a49cca90420b39ee0a695")]
    
    var urlComponentsSource:URLComponents{
        var urlComponentsSources = URLComponents()
        urlComponentsSources.scheme = self.scheme
        urlComponentsSources.host = self.host
        urlComponentsSources.path = self.sourcePath
        urlComponentsSources.queryItems = self.apiKey
        
        return urlComponentsSources
    }
    
    var urlComponentsHeadLines:URLComponents {
        var urlComponentsHeadlines = URLComponents()
        urlComponentsHeadlines.scheme = self.scheme
        urlComponentsHeadlines.host = self.host
        urlComponentsHeadlines.path = self.headlinesPath
        urlComponentsHeadlines.queryItems = self.apiKey

        return urlComponentsHeadlines
    }
}

