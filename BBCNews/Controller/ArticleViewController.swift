//
//  ViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 05/07/2023.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var articleTableView: UITableView!
    let articles : [Article] = [Article(image: "https://ichef.bbci.co.uk/news/1024/branded_news/3046/production/_130285321_microsoftteams-image-76.png", title: "Celebrating Pride in the midst of a culture war", subtitle: "The final day of Pride Month in Philadelphia, Pennsylvania, was filled with heart-shaped sunglasses, rainbow-coloured hair, glitter and rage. Hundreds had gathered outside a hotel in the city centre…")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "GillSans-Bold", size: 22)
        titleLabel.text = "BBC News"
        
        let hStack = UIStackView(arrangedSubviews: [titleLabel])
        hStack.spacing = 5
        hStack.alignment = .center
        
        navigationItem.titleView = hStack
        
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.rowHeight = 440
        articleTableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
    }
    
}
// MARK: - TableView DataSource
extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.subtitleLabel.text = article.subtitle
        cell.articleImage.image = UIImage(named: "ExampleImage")
        
        return cell
    }
}

// MARK: - TableView Delegate
extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
