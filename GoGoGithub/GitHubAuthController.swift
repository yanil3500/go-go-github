//
//  GitHubAuthController.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/3/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {

    @IBOutlet weak var loginButtont: UIButton!
    
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        
//        UserDefaults.standard.removeObject(forKey: "access_token")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.getAccessToken() != nil {
            self.loginButtont.isEnabled = false
            self.loginButtont.alpha = 0.5
        }

    }

    @IBAction func printTokenTapped(_ sender: Any) {
        self.view.layoutIfNeeded()
        if UserDefaults.standard.getAccessToken() == nil {
            print("Login to get an access token.")
        } else {
            print("Inside of printTokenTapped: \(String(describing: UserDefaults.standard.getAccessToken()))")
        }
        
        

    }
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if UserDefaults.standard.getAccessToken() == nil {
            let parameters = ["scope" : "email,user"]
            GitHub.shared.oAuthRequestWith(parameters: parameters)
        } else {
            print("Tap 'PRINT TOKEN' to see your token.")
        }
 
    }
    
    
}
