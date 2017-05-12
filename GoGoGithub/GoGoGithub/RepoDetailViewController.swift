//
//  RepoDetailViewController.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/5/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit
import SafariServices

class RepoDetailViewController: UIViewController {

    var repo: Repository!

    @IBOutlet weak var repoDetailTableView: UITableView!

    @IBAction func moreButtonTapped(_ sender: Any) {

        print("moreButtonTapped")
        presentSafariViewController(urlString: repo.repoUrlString)
    }

    //SafariViewController
    func presentSafariViewController(urlString: String) {

        guard let url = URL(string: urlString) else { return }

        let safariController = SFSafariViewController(url: url)

        self.present(safariController, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Inside of RepoDetailViewController: \(repo.repoName)")
        //Adds margin between the top of my view and top of my table view
        // Do any additional setup after loading the view.

        let repoDetailNib = UINib(nibName: "RepoDetailCell", bundle: nil)
        self.repoDetailTableView.register(repoDetailNib, forCellReuseIdentifier: RepoDetailCell.identifier)

        self.repoDetailTableView.estimatedRowHeight = 50
        self.repoDetailTableView.rowHeight = UITableViewAutomaticDimension
        self.repoDetailTableView.dataSource = self

    }
}

extension RepoDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoDetailCell = tableView.dequeueReusableCell(withIdentifier: RepoDetailCell.identifier, for: indexPath) as! RepoDetailCell
        repoDetailCell.repoName.text = self.repo.repoName
        repoDetailCell.repoDescription.text = self.repo.description
        repoDetailCell.programmingLanguage.text = "Programming Language: \(self.repo.language)"
        if self.repo.isForked == true {
            repoDetailCell.isForked.text = "isForked: Yes."
        } else {
            repoDetailCell.isForked.text = "isForked: No."
        }
        if let num = self.repo.numberOfStars, num > 0 {
            repoDetailCell.numberOfStars.text = "Number of Stars: \(num)"
        } else {
            repoDetailCell.numberOfStars.text = "No stars."
        }

        if let time = self.repo.createdAt.dateToString() {
            repoDetailCell.createdAt.text = "Created on: \(time)"
        } else {
            repoDetailCell.createdAt.text = self.repo.createdAt
        }

        return repoDetailCell
    }
}
