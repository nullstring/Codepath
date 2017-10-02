//
//  ComposeTweetViewController.swift
//  Tweety
//
//  Created by Harsh Mehta on 10/1/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var userNmeLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var numCharsLabel: UILabel!
    
    
    var user: User?
    
    @IBAction func onCancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweetTap(_ sender: Any) {
        TwitterClient.sharedInstance?.updateStatus(tweetText: tweetTextView.text!, onSuccess: { (tweet: Tweet) in
            self.dismiss(animated: true, completion: nil)
        }, onFailure: { (error: Error) in
            
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = User.currentUser
        print(user.debugDescription)
        
        // Do any additional setup after loading the view.
        tweetTextView.text = ""
        
        if let profileUrl = user?.profileUrl {
            posterImageView.setImageWith(profileUrl)
        }
        
        if let name = user?.name {
            userNmeLabel.text = name as String
        }
        
        if let screenName = user?.screenName {
            userHandleLabel.text = "@" + (screenName as String)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let remainingCount = 140 - textView.text!.characters.count
        numCharsLabel.text = "\(remainingCount)"
    }

}
