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
    let isForked : Bool
    var numberOfStars : Int?=0
    let createdAt : String
    let repoUrlString : String 
    
    init?(json: [String : Any]) {
        self.repoName = json["name"] as! String
        self.description = json["description"] as! String
        self.language = json["language"] as! String
        self.lastUpdated = json["updated_at"] as! String
        self.isForked = json["fork"] as! Bool
        if let numOfStars = json["stargazers_count"] as? Int {
            self.numberOfStars = numOfStars
        }
        self.createdAt = json["created_at"] as! String
        self.repoUrlString = json["html_url"] as? String ?? "https://www.github.com"
    }
}
