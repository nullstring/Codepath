//
//  RetweetCell.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/30/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class RetweetCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var retweetedHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var retweet: Tweet! {
        didSet {
            tweetLabel.text = retweet.text! as String
            
            if let profileUrl = retweet.user?.profileUrl {
                posterImageView.setImageWith(profileUrl)
            }
            
            if let name = retweet.user?.name {
                userNameLabel.text = name as String
            }
            
            if let screenName = retweet.user?.screenName {
                userHandleLabel.text = "@" + (screenName as String)
            }
            
            if let date = retweet.timestamp {
                self.timestampLabel.text = date.shortTimeAgoSinceNow
            }
        }
    }
    
    var tweet: Tweet! {
        didSet {
            self.retweet = tweet.retweet
            if let screenName = tweet.user?.screenName {
                retweetedHandleLabel.text = (screenName as String) + " retweeted"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
