//
//  Repository.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/4/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation

class Repository {
    let repoName : String
    let description : String
    let language : String
    let lastUpdated : String
    
    init?(json: [String : Any]) {
        self.repoName = json["name"] as! String
        self.description = json["description"] as! String
        self.language = json["language"] as! String
        self.lastUpdated = json["updated_at"] as! String
    }
}
