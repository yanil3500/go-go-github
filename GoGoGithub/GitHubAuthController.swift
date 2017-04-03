//
//  GitHubAuthController.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/3/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func printTokenTapped(_ sender: Any) {
        
        print("Inside of printTokenTapped: \(GitHub.userDefault.getAccessToken())")

    }

    @IBAction func loginButtonTapped(_ sender: Any) {

        let parameters = ["scope" : "email,user"]
        GitHub.shared.oAuthRequestWith(parameters: parameters)
    }
}
