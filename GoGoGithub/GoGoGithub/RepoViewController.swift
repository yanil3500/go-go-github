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
    
    @IBOutlet weak var searchBar: UISearchBar!
    var spinner : UIActivityIndicatorView!
    var repos = [Repository]() {
        didSet {
            self.repoTableView.reloadData()
        }
    }
    
    var displayRepos : [Repository]? {
        didSet {
            self.repoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.repoTableView.dataSource = self
        self.repoTableView.delegate = self
        self.searchBar.delegate = self
        
        //Adds margin between the top of my view and top of my table view
        self.repoTableView.contentInset = UIEdgeInsets(top: 20, left: 0,bottom: 0,right: 0)
        
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == RepoDetailViewController.identifier {
            segue.destination.transitioningDelegate = self
        }
    }

}


//MARK: RepoViewController conforms to UIViewControllerTransitioningDelegate
extension RepoViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition(1.0)
    }
}


//MARK: RepoViewController UITableViewDelegate
extension RepoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: RepoDetailViewController.identifier, sender: nil)
        print("Repos at position \(indexPath.row): \(self.repos[indexPath.row])")
    }
    
}


//MARK: RepoViewController UITableViewDataSource
extension RepoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //By using nil coalescing, the number of rows will dynamically change in response to the user's search criteria
        //If the search bar is empty, the row count will default to the number of repos in our repos collection
        return displayRepos?.count ?? self.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoCell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoCell
        
        //By using nil coalescing, the tableView will be populated with the repos matching the search criteria
        //If search bar is empty, the conditional displayRepos array will be empty so the tableView defaults to the repos array
        repoCell.repoName.text = displayRepos?[indexPath.row].repoName ?? self.repos[indexPath.row].repoName
        
        repoCell.repoDescription.text = displayRepos?[indexPath.row].description ?? self.repos[indexPath.row].description
        
        
        return repoCell
        
    }
}

//MARK: RepoViewController UISearchBarDelegate
extension RepoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchedText = searchBar.text else { return; }
        //Populates table according to what user is searching for
        self.displayRepos = self.repos.filter({ (repo) -> Bool in
            repo.repoName.contains(searchedText)
        })
        
        if searchBar.text == "" {
            self.displayRepos = nil
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.displayRepos = nil
        //Dismissed the keyboard from the view once user clicks on cancel button
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Dismisses the keyboard from the view once user clicks search bar
        self.searchBar.resignFirstResponder()
    }
}


