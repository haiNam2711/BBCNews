//
//  Article.swift
//  BBCNews
//
//  Created by Hai Nam on 05/07/2023.
//

import Foundation
class ArticleList: Decodable{
    let articles: [Article]
}

class Article: Decodable{
    let title: String
    let url: String
    let urlToImage: String
    let content: String
}
