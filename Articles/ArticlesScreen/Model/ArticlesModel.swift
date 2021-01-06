//
//  ArticlesModel.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import Foundation

struct ArticleModel: Decodable {
    let status: String
    let results: [ArticleDetails]
}

struct ArticleDetails: Decodable {
    let url: String
    let id: Int
    let publishedDate: String
    let title: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case publishedDate = "published_date"
        case author = "byline"
        case url, id, title
    }
}
