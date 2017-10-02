//
//  TweetDetailViewController.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/30/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import DateToolsSwift
import UIKit

class TweetDetailViewController: UIViewController {

    
    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!

    var tweet: Tweet!
    
    func setupView() {
        let tweetForView: Tweet
        if let retweet = tweet.retweet {
            if let screenName = tweet.user?.screenName {
                retweetedLabel.text = (screenName as String) + " retweeted"
            }
            tweetForView = retweet
        } else {
            retweetedImageView.isHidden = true
            retweetedLabel.isHidden = true
            tweetForView = tweet
        }
        
        tweetTextLabel.text = tweetForView.text! as String
        
        if let profileUrl = tweetForView.user?.profileUrl {
            posterImageView.setImageWith(profileUrl)
        }
        
        if let name = tweetForView.user?.name {
            nameLabel.text = name as String
        }
        
        if let screenName = tweetForView.user?.screenName {
            handleLabel.text = "@" + (screenName as String)
        }
        
        if let date = tweetForView.timestamp {
            self.timestampLabel.text = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .medium)
        }
        
        retweetCountLabel.text = "\(tweetForView.retweetCount)"
        likesCountLabel.text = "\(tweetForView.favoritesCount)"
    }
    
    @IBAction func onTapRetweet(_ sender: UIButton) {
        print("Tap retweet")
        TwitterClient.sharedInstance?.retweetStatuses(tweetId: tweet.id!, onSuccess: { (tweet: Tweet) in
            print(tweet)
            self.retweetButton.isEnabled = true

        }, onFailure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    
    @IBAction func onTapLike(_ sender: UIButton) {
        print("Tap like")
        TwitterClient.sharedInstance?.createFavorite(tweetId: tweet.id!, onSuccess: { (tweet: Tweet) in
            print(tweet)
            self.likeButton.isEnabled = true
            self.likeButton.setBackgroundImage(UIImage(contentsOfFile: "twitter-like-selected"), for: UIControlState.normal)
        }, onFailure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
