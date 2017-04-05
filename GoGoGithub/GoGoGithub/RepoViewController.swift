//
//  RepoViewController.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/4/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    @IBOutlet weak var repoTableView: UITableView!
    var spinner : UIActivityIndicatorView!
    var repos = [Repository]() {
        didSet {
            self.repoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.repoTableView.dataSource = self
        self.repoTableView.delegate = self
        
        
        self.repoTableView.estimatedRowHeight = 50
        self.repoTableView.rowHeight = UITableViewAutomaticDimension
        self.update()
        // Do any additional setup after loading the view.
    }
    
//    func startSpinner(){
//      self.spinner = UIActivityIndicatorView()
//      self.spinner.center = self.view.center
//      self.spinner.hidesWhenStopped = true
//      self.spinner.activityIndicatorViewStyle = .whiteLarge
//      self.spinner.color = UIColor.black
//      self.view.addSubview(spinner)
//      self.spinner.startAnimating()
//    }
//    
//    func stopSpinner(){
//        self.spinner.stopAnimating()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        print("update repo controller here!")
        GitHub.shared.getRepos { (reposFromCall) in
            guard let reposUnwrapped = reposFromCall else { return }
            
            
            OperationQueue.main.addOperation {
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
        print("Repos at position \(indexPath.row): \(self.repos[indexPath.row])")
    }
}
