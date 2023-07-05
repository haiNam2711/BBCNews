//
//  ViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 05/07/2023.
//

import UIKit

class ArticleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "GillSans-Bold", size: 22)
        titleLabel.text = "BBC News"
        
        let hStack = UIStackView(arrangedSubviews: [titleLabel])
        hStack.spacing = 5
        hStack.alignment = .center
        
        navigationItem.titleView = hStack
    }


}

