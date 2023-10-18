//
//  Data.swift
//  BBCNews
//
//  Created by Hai Nam on 08/07/2023.
//

import Foundation
import RealmSwift

class RealmData: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var url: String = ""
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()

        dict["title"] = self.title
        dict["url"] = self.url
        

        return dict
    }
}
