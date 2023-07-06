//
//  ArticleManager.swift
//  BBCNews
//
//  Created by Hai Nam on 06/07/2023.
//

import Foundation


protocol ArticleManagerDelegate {
    func didUpdateArticle(_ articleManager: ArticleManager, articleList: [Article])
    func didFailWithError(error: Error)
}


struct ArticleManager {
    let articleURL = "https://newsapi.org/v2/top-headlines?apiKey=d32c743fa73647b39cd21043a26cf83a&sources=bbc-news"
    
    var delegate: ArticleManagerDelegate?
    
    func performRequest() {
        if let url = URL(string: articleURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let articles = self.parseJSON(safeData) {
                        self.delegate?.didUpdateArticle(self, articleList: articles)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ articleData: Data) -> [Article]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ArticleList.self, from: articleData)
            return decodedData.articles
        } catch {
//            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
