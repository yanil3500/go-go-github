//
//  RepoDetailCell.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/5/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class RepoDetailCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var programmingLanguage: UILabel!
    @IBOutlet weak var numberOfStars: UILabel!
    @IBOutlet weak var isForked: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
