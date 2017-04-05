//
//  RepoViewController.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/4/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    

    var spinner : UIActivityIndicatorView!
    
    @IBOutlet weak var repoTableView: UITableView!
    var repos = [Repository]() {
        didSet {
            self.repoTableView.reloadData()
        }
    }
    
    func startSpinner(){
        self.spinner = UIActivityIndicatorView()
        self.spinner.center = self.view.center
        self.spinner.hidesWhenStopped = true
        self.spinner.activityIndicatorViewStyle = .whiteLarge
        self.spinner.color = UIColor.black
        self.view.addSubview(spinner)
        self.spinner.startAnimating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Repos"
        self.repoTableView.dataSource = self
        self.repoTableView.delegate = self
        
        
        self.repoTableView.estimatedRowHeight = 50
        self.repoTableView.rowHeight = UITableViewAutomaticDimension
        
        self.update()
        // Do any additional setup after loading the view.
    }

    func update() {
        self.startSpinner()
        print("update repo controller here!")
        GitHub.shared.getRepos { (reposFromCall) in
            guard let reposUnwrapped = reposFromCall else { return }
            
            OperationQueue.main.addOperation {
                self.spinner.stopAnimating()
                self.repos = reposUnwrapped
            }

        }
    }

}


//MARK: RepoViewController conforms to UITableViewDataSource, UITableViewDelegate
extension RepoViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoCell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoCell
        
        repoCell.repoName.text = self.repos[indexPath.row].repoName
        
        repoCell.repoDescription.text = self.repos[indexPath.row].description

        
        return repoCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
