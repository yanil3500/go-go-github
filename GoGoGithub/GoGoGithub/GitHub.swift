//
//  GitHub.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/3/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit


let kOAuthBaseURLString = "https://github.com/login/oauth"

let gitHubClientID = "2b4ab1c78e5448906b0f"
let gitHubClientSecret = "31c3e02b76ab95788436298fa03bdf7951a60ecb"

class GitHub {
    static let shared = GitHub()
    
    private init() {}
    
    func oAuthRequestWith(parameters: [String : String]){
        //Parameters will equal everything after question mark in a url
        var parametersString = ""
        
        for (key, value) in parameters{
            parametersString += "&\(key)=\(value)"
        }
        
        print("Inside of oAuthRequestWith method: the parameterString \(parametersString)")
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(gitHubClientID)\(parametersString)") {
            print("The requestURL: \(requestURL.absoluteString)")
        }
    }
}
