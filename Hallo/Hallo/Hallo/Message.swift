//
//  Message.swift
//  Hallo
//
//  Created by Harsh Mehta on 9/27/17.
//  Copyright © 2017 Harsh Mehta. All rights reserved.
//

import Foundation
import Parse

// subclassing PFObject will automatically register with Parse SDK now
// See https://github.com/parse-community/Parse-SDK-iOS-OSX/pull/967
class Message: PFObject, PFSubclassing {
    // properties/fields must be declared here
    // @NSManaged to tell compiler these are dynamic properties
    // See https://stackoverflow.com/questions/31357564/what-does-nsmanaged-do
    @NSManaged var text: String?
    
    var user: PFUser?
    
    // returns the Parse name that should be used
    class func parseClassName() -> String {
        return "Message"
    }
}
