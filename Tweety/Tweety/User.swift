//
//  User.swift
//  Tweety
//
//  Created by Harsh Mehta on 9/26/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import Foundation

/*
 
 "user" = {
 "contributors_enabled" = 0;
 "created_at" = "Fri Apr 01 19:54:22 +0000 2011";
 "default_profile" = 0;
 "default_profile_image" = 0;
 description = "https://t.co/W2SFxIXkC4 covers life in the future.";
 entities =     {
 description =         {
 urls =             (
 {
 "display_url" = "theverge.com";
 "expanded_url" = "http://www.theverge.com";
 indices =                     (
 0,
 23
 );
 url = "https://t.co/W2SFxIXkC4";
 }
 );
 };
 url =         {
 urls =             (
 {
 "display_url" = "theverge.com";
 "expanded_url" = "http://www.theverge.com";
 indices =                     (
 0,
 22
 );
 url = "http://t.co/W2SFxIXkC4";
 }
 );
 };
 };
 "favourites_count" = 1748;
 "follow_request_sent" = 0;
 "followers_count" = 2214427;
 following = 1;
 "friends_count" = 127;
 "geo_enabled" = 1;
 "has_extended_profile" = 0;
 id = 275686563;
 "id_str" = 275686563;
 "is_translation_enabled" = 1;
 "is_translator" = 0;
 lang = en;
 "listed_count" = 33595;
 location = "New York";
 name = "The Verge";
 notifications = 0;
 "profile_background_color" = FFFFFF;
 "profile_background_image_url" = "http://pbs.twimg.com/profile_background_images/481546505468145664/a59ZFvIP.jpeg";
 "profile_background_image_url_https" = "https://pbs.twimg.com/profile_background_images/481546505468145664/a59ZFvIP.jpeg";
 "profile_background_tile" = 0;
 "profile_banner_url" = "https://pbs.twimg.com/profile_banners/275686563/1502473361";
 "profile_image_url" = "http://pbs.twimg.com/profile_images/877903823133704194/Mqp1PXU8_normal.jpg";
 "profile_image_url_https" = "https://pbs.twimg.com/profile_images/877903823133704194/Mqp1PXU8_normal.jpg";
 "profile_link_color" = EC008C;
 "profile_sidebar_border_color" = 000000;
 "profile_sidebar_fill_color" = EFEFEF;
 "profile_text_color" = 333333;
 "profile_use_background_image" = 1;
 protected = 0;
 "screen_name" = verge;
 "statuses_count" = 128352;
 "time_zone" = "Eastern Time (US & Canada)";
 "translator_type" = regular;
 url = "http://t.co/W2SFxIXkC4";
 "utc_offset" = "-14400";
 verified = 1;
 };

 
 */

class User: NSObject {
    var name: NSString?
    var screenName: NSString?
    var profileUrl: URL?
    var tagline: NSString?
    var id: Int?
    
    static var currentUser: User?
    
    static let logoutNotification = "UserLogingOut"
    
    init(dictionary: NSDictionary) {
        self.name = dictionary["name"] as? NSString
        self.screenName = dictionary["screen_name"] as? NSString
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            self.profileUrl = URL(string: profileUrlString)
        }
        
        self.tagline = dictionary["description"] as? NSString
        
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
    }
}
