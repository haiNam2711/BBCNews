//
//  ViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 05/07/2023.
//

import UIKit
import SafariServices
import RealmSwift

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var articleTableView: UITableView!
    
    var articleManager = ArticleManager()
    var articlesList = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "GillSans-Bold", size: 22)!]
        navigationItem.title = "BBC News"
        
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleManager.delegate = self
        articleTableView.rowHeight = 440
        articleTableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        articleManager.performRequest()
    }
    
}
// MARK: - TableView DataSource
extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        let article = articlesList[indexPath.row]
        cell.titleLabel.text = article.title
        cell.subtitleLabel.text = article.content
        cell.articleImage.downloaded(from: article.urlToImage)
        cell.url = article.url
        
        return cell
    }
}

// MARK: - TableView Delegate
extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = articlesList[indexPath.row].url
        if let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            self.present(safariViewController, animated: true, completion: nil)
        }
    }
}

//MARK: - WeatherManagerDelegate
extension ArticleViewController: ArticleManagerDelegate {
    
    func didUpdateArticle(_ articleManager: ArticleManager, articleList: [Article]) {
        DispatchQueue.main.async {
            self.articlesList = articleList
            self.articleTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - SafariDelegate
extension ArticleViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
