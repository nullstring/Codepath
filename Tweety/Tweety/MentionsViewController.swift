//
//  MentionsViewController.swift
//  Tweety
//
//  Created by Harsh Mehta on 10/5/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets: [Tweet] = []
    
    @IBAction func onSignoutButtonTap(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance?.signOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "NewTweetCell", bundle: Bundle.main)
        tweetsTableView.register(cellNib, forCellReuseIdentifier: "com.irshya.NewTweetCell")
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tweetsTableView.insertSubview(refreshControl, at: 0)
        
        tweetsTableView.estimatedRowHeight = 200.0
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance?.mentionsTimeline(onSuccess: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }, onFailure: { (error: Error) in
            print("\(error.localizedDescription)")
        })
        // Do any additional setup after loading the view.
        
        
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.mentionsTimeline(onSuccess: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
            refreshControl.endRefreshing()
        }, onFailure: { (error: Error) in
            print("\(error.localizedDescription)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweet = tweets[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.irshya.NewTweetCell") as! NewTweetCell
        cell.setTweet(tweet: tweet)
        
        cell.updateConstraints()
        
        cell.onProfileImageTap = {(user: User?, sender: UITapGestureRecognizer) -> Void in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            profileVC.user = user
            profileVC.navigationItem.leftBarButtonItem = nil
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TweetShowDetailSegue", sender: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TweetShowDetailSegue" {
            if let indexPath = tweetsTableView.indexPathForSelectedRow {
                let detailController = segue.destination as! TweetDetailViewController
                // print(tweets[indexPath.row].debugDescription)
                detailController.tweet = tweets[indexPath.row]
                tweetsTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

}
