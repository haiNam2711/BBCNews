//
//  ArticleCell.swift
//  BBCNews
//
//  Created by Hai Nam on 06/07/2023.
//

import UIKit
import RealmSwift

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var url : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let data = RealmData()
        data.title = titleLabel.text ?? ""
        data.content = subtitleLabel.text ?? ""
        data.url = url
        
        let realm = try! Realm()
        let results = realm.objects(RealmData.self).filter("url == %@", data.url)
        if !results.isEmpty {
            return
        }
        
        do {
            try realm.write{
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    
}
