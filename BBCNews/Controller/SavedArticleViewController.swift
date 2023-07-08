//
//  SavedArticleViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 07/07/2023.
//

import UIKit
import RealmSwift
import SafariServices

class SavedArticleViewController: UIViewController {
    
    var savedData : Results<RealmData>?
    let realm = try! Realm()
    
    @IBOutlet weak var saveArticleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveArticleTableView.delegate = self
        saveArticleTableView.dataSource = self
        saveArticleTableView.rowHeight = 75
        loadData()
    }
}
// MARK: - Table view data source
extension SavedArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (savedData == nil) {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No Saved Data."
            cell.textLabel?.font = UIFont(name: "GillSans", size: 15)
            return cell
        }
        let cell = saveArticleTableView.dequeueReusableCell(withIdentifier: "savedDataCell", for: indexPath)
        cell.textLabel!.font = UIFont(name: "GillSans", size: 17)
        cell.textLabel!.text = savedData?[indexPath.row].title
        return cell
    }
    
    func loadData() {
        savedData = realm.objects(RealmData.self)
        saveArticleTableView.reloadData()
    }
}

//MARK: - Table view delegate
extension SavedArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = savedData?[indexPath.row].url
        if let urlString = url, let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            self.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    tableview
}

//MARK: - SafariDelegate
extension SavedArticleViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
