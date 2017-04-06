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
    case UserDefaults(String?)
}
let kOAuthBaseURLString = "https://github.com/login/oauth/"

typealias GitHubOAuthCompletion = (SaveOptions, Bool) -> Void

typealias FetchReposCompletion = ([Repository]?) -> Void
class GitHub {

    private var session: URLSession
    private var components: URLComponents
    static let shared = GitHub()

//    static let userDefault = UserDefaults()
    private init() {
        self.session = URLSession(configuration: .default)
        self.components = URLComponents()

        self.components.scheme = "https"
        self.components.host = "api.github.com"

    }

    var clientId = gitHubClientID
    var clientSecret = gitHubClientSecret

    func oAuthRequestWith(parameters: [String : String]) {
        //Parameters will equal everything after question mark in a url
        var parametersString = ""

        for (key, value) in parameters {
            parametersString += "&\(key)=\(value)"
        }

        print("Inside of oAuthRequestWith method: the parameterString \(parametersString)")
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(gitHubClientID)\(parametersString)") {
            print("The requestURL: \(requestURL.absoluteString)")

            UIApplication.shared.open(requestURL)
        }
    }

    func getCodeFrom(url: URL) throws -> String {
        guard let code = url.absoluteString.components(separatedBy: "=").last else { throw GitHubAuthError.extractingCode }

        return code
    }

    //Helper function extracting access token
    func getTokenFrom(tokenString: String) -> String? {
        if tokenString.contains("access_token") {
            guard let indexOf = tokenString.components(separatedBy: "&").index(of: "access_token") else { return "" }

            guard let token = tokenString.components(separatedBy: "&")[indexOf].components(separatedBy: "=").last else {return ""}

            print("Inside of getTokenFromString: \(token)")
            return token
        } else {

            return nil
        }
    }

    func tokenRequestFor(url: URL, saveOptions: SaveOptions, completion: @escaping GitHubOAuthCompletion) {

        func complete(success: Bool) {
            OperationQueue.main.addOperation {
                completion(saveOptions, success)
            }
        }
        do {

            let code = try getCodeFrom(url: url)

            let requestString = "\(kOAuthBaseURLString)access_token?client_id=\(gitHubClientID)&client_secret=\(gitHubClientSecret)&code=\(code)"

            guard let requestURL = URL(string: requestString) else { return }

            let session = URLSession(configuration: .default)

            session.dataTask(with: requestURL, completionHandler: { (data, _, error) in
                if error != nil {
                    print("Failed to retrieve token: \(String(describing: error))")
                    complete(success: false)
                }

                guard let data = data else { complete(success: false); return }

                guard let dataString = String(data: data, encoding: .utf8) else { complete(success: false); return}

                guard let token = dataString.components(separatedBy: "&").first?.components(separatedBy: "=").last else { complete(success: false); return}
                UserDefaults.standard.save(accessToken: token)

                complete(success: true)
            //The resume method tells our data task to fire
            }).resume()

        } catch {
            print("Cannot get code: \(error)")
            complete(success: false)
        }

    }

    func getRepos(completion: @escaping FetchReposCompletion) {

        if let token = UserDefaults.standard.getAccessToken() {
            let queryItem = URLQueryItem(name: "access_token", value: token)
            let queryItemByCreate = URLQueryItem(name: "sort", value: "updated")
            let queryItemByCreateAsc = URLQueryItem(name: "direction", value: "desc")
            self.components.queryItems = [queryItem, queryItemByCreate, queryItemByCreateAsc]
        }

        func returnToMain(results: [Repository]?) {
            OperationQueue.main.addOperation {
                completion(results)
            }
        }

        self.components.path = "/user/repos"

        guard let url = self.components.url else { returnToMain(results: nil); return }

        self.session.dataTask(with: url) { (data, _, error) in

            if error != nil {
                returnToMain(results: nil)
                return
            }

            if let data = data {
                var repos = [Repository]()

                do {
                    if let rootJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]] {
                        for repoJSON in rootJSON {
                            if let repo = Repository(json: repoJSON) {
                                repos.append(repo)
                            }
                        }

                        returnToMain(results: repos)
                    }
                } catch {

                }
            }

        }.resume()
    }
}
