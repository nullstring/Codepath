//
//  Tweet.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/26/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    
    var id: Int64?
    var user: User?
    var text: NSString?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var retweet: Tweet?
    
    init(dictionary: NSDictionary) {
        // print("Tweet dict")
        // print("\(dictionary.descriptionInStringsFileFormat)")
        
        self.text = dictionary["text"] as? NSString
        
        if let timestampString = dictionary["created_at"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            self.timestamp = formatter.date(from: timestampString)
        }
        
        self.retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        self.favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        
        if let userDict = dictionary["user"] as? NSDictionary {
            self.user = User(dictionary: userDict)
        }
        
        if let retweetDict = dictionary["retweeted_status"] as? NSDictionary {
            self.retweet = Tweet(dictionary: retweetDict)
        }
        
        if let id = dictionary["id"] as? Int64 {
            self.id = id
        }

    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        return dictionaries.map { (dictionary: NSDictionary) -> Tweet in
            return Tweet(dictionary: dictionary)
        }
    }
}
