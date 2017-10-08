//
//  User.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/26/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: NSString?
    var screenName: NSString?
    var profileUrl: URL?
    var tagline: NSString?
    var id: Int?
    var numTweets: Int64?
    var numFollowing: Int64?
    var numFollowers: Int64?
    var backgroundUrl: URL?
    
    static var currentUser: User?
    
    static let logoutNotification = "UserLogingOut"
    
    init(dictionary: NSDictionary) {
        self.name = dictionary["name"] as? NSString
        self.screenName = dictionary["screen_name"] as? NSString
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            self.profileUrl = URL(string: profileUrlString)
        }
        
        let backgroundUrlString = dictionary["profile_banner_url"] as? String
        if let backgroundUrlString = backgroundUrlString {
            self.backgroundUrl = URL(string: backgroundUrlString)
        }
        self.tagline = dictionary["description"] as? NSString
        
        if let numFollowers = dictionary["followers_count"] as? Int64 {
            self.numFollowers = numFollowers
        }
        
        if let numFollowing = dictionary["friends_count"] as? Int64 {
            self.numFollowing = numFollowing
        }
        
        if let numTweets = dictionary["statuses_count"] as? Int64 {
            self.numTweets = numTweets
        }
        
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
    }
}
