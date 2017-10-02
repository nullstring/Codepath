//
//  TweetCell.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/30/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import DateToolsSwift
import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetlabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            tweetlabel.text = tweet.text! as String
            
            if let profileUrl = tweet.user?.profileUrl {
                posterImageView.setImageWith(profileUrl)
            }
            
            if let name = tweet.user?.name {
                userNameLabel.text = name as String
            }
            
            if let screenName = tweet.user?.screenName {
                userHandleLabel.text = "@" + (screenName as String)
            }
            
            if let date = tweet.timestamp {
                self.timestampLabel.text = date.shortTimeAgoSinceNow
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Image views look better with curves :P
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
