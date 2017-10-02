//
//  TwitterClient.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/26/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import BDBOAuth1Manager
import Foundation


let twitterConsumerKey = "iHkPhM9J1nQUEjqhwkGCx8nwP"
let twitterConsumerSecret = "V8C93wlb1SzoCY3cXacKVTOGz3EFdmhwgM1tciXRjxZKDzWBqe"
let twitterBaseURL = URL(string: "https://api.twitter.com")

enum TweetyResourceError: Error {
    case currentUserNotSet
}

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    
    var onLoginSuccess: (()->())?
    var onLoginFailure: ((Error)->())?
    
    func signOut() {
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.logoutNotification), object: nil)
    }
    
    func setCurrentUser() {
        // Get current user if authorised.
        self.currentAccount(onSuccess: { (user: User) in
            User.currentUser = user
        }, onFailure: { (error: Error) in
            User.currentUser = nil
        })
    }
    
    func login(onSuccess: @escaping (()->()), onFailure: @escaping ((Error)->())) {
        onLoginSuccess = onSuccess
        onLoginFailure = onFailure
        
        requestSerializer.removeAccessToken()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            
            print("\(requestToken!.token!)")
            let authURL = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            UIApplication.shared.open(authURL!, options: [:], completionHandler: nil)
        }) { (error: Error!) in
            print("\(error!.localizedDescription)")
            self.onLoginFailure?(error)
        }
    }
    
    func handleOpenUrl(url: URL) {
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (credential: BDBOAuth1Credential?) in
            self.onLoginSuccess?()
            self.setCurrentUser()
        }) { (error: Error?) in
            self.onLoginFailure?(error!)
        }
    }
    
    func currentAccount(onSuccess: @escaping ((User)->()), onFailure: @escaping ((Error)->())) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            onSuccess(user)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            onFailure(error)
        })
    }
    
    func homeTimeline(onSuccess: @escaping (([Tweet])->()), onFailure: @escaping ((Error)->())) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: tweetDictionaries)
            onSuccess(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            onFailure(error)
        })
    }
    
    func updateStatus(tweetText: String, onSuccess: @escaping ((Tweet)->()), onFailure: @escaping ((Error)->())) {
        let parameters = NSDictionary.init(dictionary: ["status": tweetText])
        post("1.1/statuses/update.json", parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let tweetDictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: tweetDictionary)
            onSuccess(tweet)
            print(tweet.debugDescription)
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure(error)
            print(error.localizedDescription)
        }
    }
    
    func createFavorite(tweetId: Int64, onSuccess: @escaping ((Tweet)->()), onFailure: @escaping ((Error)->())) {
        let resourceId = "1.1/favorites/create.json?id=\(tweetId)"
        post(resourceId, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let tweetDictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: tweetDictionary)
            onSuccess(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure(error)
        }
    }
    
    func retweetStatuses(tweetId: Int64, onSuccess: @escaping ((Tweet)->()), onFailure: @escaping ((Error)->())) {
        let resourceId = "1.1/statuses/retweet/\(tweetId).json"
        print(resourceId)
        post(resourceId, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let tweetDictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: tweetDictionary)
            onSuccess(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            onFailure(error)
        }
    }
}


