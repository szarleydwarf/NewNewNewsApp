////
////  NewsCategoriesApi.swift
////  NewsNewsNews
////
////  Created by The App Experts on 26/09/2020.
////  Copyright © 2020 The App Experts. All rights reserved.
////
//
//import Foundation
//
////struct NewsCategories:Decodable {
////    let categories:[NewsCategory]
////}
//
//
//
//struct NewsCategoryAPI {
//    private init(){}
//    static let shared = NewsCategoryAPI()
//    
//    private let session = URLSession.shared
//    var ulrComponents: URLComponents {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "newsapi.org"
//        urlComponents.path = "/v2/sources?apiKey=86316c5c482a49cca90420b39ee0a695"
//        print(urlComponents.url?.absoluteString)
//        return urlComponents
//    }
//    
//    func fetchData() -> [NewsCategory] {
//        print("fetching data")
//        var news:[NewsCategory] = []
//        
//        guard let url = self.ulrComponents.url else{return []}
//        session.dataTask(with: url) { (data, response, error) in
//            guard let data = data else {return}
//            let category = try? JSONDecoder().decode(NewsCategory.self, from: data)
//            guard let unwrapedCategory = category else {return}
//            news.append(unwrapedCategory)
//        }.resume()
//        return news
//    }
//}
