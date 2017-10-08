//
//  NewTweetCell.swift
//  Tweety
//
//  Created by Harsh Mehta on 10/5/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class NewTweetCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var retweetedHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    
    @IBOutlet weak var posterViewTopConstraint: NSLayoutConstraint!
    
    var navigationVC: UINavigationController?
    
    var onProfileImageTap: ((User?, UITapGestureRecognizer)->Void)!
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text! as String
            
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
    
    func setTweet(tweet: Tweet) {
        posterViewTopConstraint.constant = 25
        if tweet.retweet != nil {
            self.tweet = tweet.retweet
            if let screenName = tweet.user?.screenName {
                retweetedHandleLabel.isHidden = false
                retweetImageView.isHidden = false
                retweetedHandleLabel.text = (screenName as String) + " retweeted"
            }
        } else {
            self.tweet = tweet
            retweetedHandleLabel.isHidden = true
            retweetImageView.isHidden = true
            posterViewTopConstraint.constant = 0
        }
        setNeedsUpdateConstraints()
    }
    
    func onProfileImageTap(sender: UITapGestureRecognizer) {
        self.onProfileImageTap(tweet.user, sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: #selector(onProfileImageTap(sender:)))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapGestureRecog)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
