//
//  MenuViewController.swift
//  BBCNews
//
//  Created by Hai Nam on 07/07/2023.
//

import UIKit
import FirebaseAuth
import RealmSwift
import FirebaseFirestore

class MenuViewController: UIViewController {
    
    var item = ["Saved Articles","Sign In","Sign Up","Synchronize","Download Saved Article","Sign Out"]
    var iconSysName = ["bookmark","person.circle","person.badge.plus","square.and.arrow.up","square.and.arrow.down.on.square","person.badge.minus"]
    var user = Auth.auth().currentUser
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
        user = Auth.auth().currentUser
        if indexPath.row == 0 {
            performSegue(withIdentifier: "segueToSavedArticle", sender: self)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "segueToSignIn", sender: self)
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "segueToSignUp", sender: self)
        } else if indexPath.row == 3 {
            if (user == nil) {
                let alert = alertShow(title: "Synchronize failed", message: "Please Sign In Or Sign Up Before Synchronize")
                self.present(alert, animated : true)
            } else {
                uploadData()
                let alert = alertShow(title: "Synchronize Successfully", message: "Your saved articles have been uploaded")
                self.present(alert, animated : true)
            }
        } else if indexPath.row == 4 {
            if (user == nil) {
                let alert = alertShow(title: "Synchronize failed", message: "Please Sign In Or Sign Up Before Synchronize")
                self.present(alert, animated : true)
            } else {
                let alert = alertShow(title: "Synchronize Succesfully", message: "Your uploaded articles have been downloaded")
                self.present(alert, animated : true)
            }
        } else if indexPath.row == 5 {
            try? Auth.auth().signOut()
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

//MARK: - Show Alert
func alertShow(title: String, message: String) -> UIAlertController{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
    }

    alert.addAction(okAction)
    return alert
}

//MARK: - Upload Realm Data Onto Firebase
func uploadData() {
    var articles : Results<RealmData>?
    let realm = try! Realm()
    articles = realm.objects(RealmData.self)
    if let articles = articles {
        var articleDict = [[String: Any]]()
        
        for article in articles {
            articleDict.append(article.toDictionary())
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = Firestore.firestore().collection("articles").document(uid)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if var savedArticles = document.get("articles") as? [[String: Any]] {
                    savedArticles.append(contentsOf: articleDict)
                }
                userRef.setData(["articles": articleDict])
            } else {
                userRef.setData(["articles": articleDict])
            }
        }
        
    }
}
