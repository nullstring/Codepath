//
//  GithubRepoCell.swift
//  GithubDemo
//
//  Created by Harsh Mehta on 9/20/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class GithubRepoCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoOwnerLabel: UILabel!
    @IBOutlet weak var repoOwnerPoster: UIImageView!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    
    var repo: GithubRepo! {
        didSet {
            repoNameLabel.text = repo.name
            repoNameLabel.sizeToFit()
            
            repoOwnerLabel.text = repo.ownerHandle
            repoDescription.text = repo.repoDescription
            repoOwnerPoster.setImageWith(URL(string: repo.ownerAvatarURL!)!)
            forkCountLabel.text = "\(repo.forks!)"
            starCountLabel.text = "\(repo.stars!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        repoDescription.sizeToFit()
        
        
        repoOwnerPoster.layer.cornerRadius = 3
        repoOwnerPoster.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
