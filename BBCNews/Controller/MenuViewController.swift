//
//  MenuViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 07/07/2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    var item = ["Saved Articles","Sign In","Sign Up","Synchronize","Download Saved Article",]
    var iconSysName = ["bookmark","person.circle","person.badge.plus","square.and.arrow.up","square.and.arrow.down.on.square"]
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "GillSans-Bold", size: 22)!]
        navigationItem.title = "BBC Menu"
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "segueToSavedArticle", sender: self)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "segueToSignIn", sender: self)
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "segueToSignUp", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = item[indexPath.row]
        cell.imageView?.image = UIImage(systemName: iconSysName[indexPath.row])
        cell.imageView?.tintColor = .systemGray
        return cell
    }
    
}
