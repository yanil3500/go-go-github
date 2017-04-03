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
    case UserDefaults
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
    
    func tokenRequestFor(url: URL, saveOptions: SaveOptions, completion: @escaping GitHubOAuthCompletion) {
        
        func complete(success: Bool){
            OperationQueue.main.addOperation {
                completion(success)
            }
        }
        do {
            let code = try getCodeFrom(url: url)
            
            let requestString = "\(kOAuthBaseURLString)access_token?client_id=\(gitHubCredentials.shared.gitHubClientID)&client_secret=\(gitHubCredentials.shared.gitHubClientSecret)&code=\(code)"
            
            guard let requestURL = URL(string: requestString) else { return }
            
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                if error != nil { print("Failed to retrieve token: \(String(describing: error))");complete(success: false) }
                
                guard let data = data else { complete(success: false); return }
                
                guard let dataString = String(data: data, encoding: .utf8) else { complete(success: false); return}
                
                print("Inside of tokenRequestFor: \(dataString)")
                
                print("Inside of tokenRequestFor:  \(String(describing: dataString.components(separatedBy: "&").first?.components(separatedBy: "=").last))")
                
                let userDefault = UserDefaults()
                userDefault.save(accessToken: String(describing: dataString.components(separatedBy: "&").first?.components(separatedBy: "=").last))
                
                
                
                
                complete(success: true)
            //The resume method tells our data task to fire
            }).resume()
            
            
        } catch {
            print("Cannot get code: \(error)")
            complete(success: false)
        }
        
    }
}
