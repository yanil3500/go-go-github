//
//  GitHubAuthController.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/3/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.getAccessToken() != nil {
            self.loginButton.isEnabled = false
            self.loginButton.alpha = 0.5
        }

    }

    

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if UserDefaults.standard.getAccessToken() == nil {
            let parameters = ["scope" : "email,user,repo"]
            GitHub.shared.oAuthRequestWith(parameters: parameters)
        } else {
            print("Tap 'PRINT TOKEN' to see your token.")
        }
 
    }
    
    func dismissAuthController(){
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    
}
