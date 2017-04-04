//
//  RepoViewController.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/4/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.update()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        print("update repo controller here!")
        GitHub.shared.getRepos { (repos) in
            //update tableView
            print("Number of repos: \(repos?.count)")
        }
    }

}
