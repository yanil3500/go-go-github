//
//  GitHub.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/3/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

enum GitHubAuthError: Error {
    case extractingCode
}

enum SaveOptions {
    case userDefaults
}
let kOAuthBaseURLString = "https://github.com/login/oauth/"

typealias GitHubOAuthCompletion = (Bool) -> ()

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
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(gitHubCredentials.shared.gitHubClientID)\(parametersString)") {
            print("The requestURL: \(requestURL.absoluteString)")
            
            UIApplication.shared.open(requestURL)
        }
    }
    
    func getCodeFrom(url: URL) throws -> String {
        guard let code = url.absoluteString.components(separatedBy: "=").last else { throw GitHubAuthError.extractingCode }
        
        return code
    }
}
