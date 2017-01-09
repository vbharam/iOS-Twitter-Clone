//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/6/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import Foundation

class Tweet {
    private var _jsonDict: NSDictionary!
    
    var jsonDict: NSDictionary {
        return (_jsonDict == nil ? nil : _jsonDict)!
    }
    
    var userMention: NSArray {
        var userMentionArray: [UserMention] = []
        
        if let entities = jsonDict["entities"] as? Dictionary<String, AnyObject> {
            if let userMentions = entities["user_mentions"] as? [Dictionary<String, AnyObject>], userMentions.count > 0 {
                for userDict in userMentions {
                    let mention = UserMention(userId: userDict["id_str"] as! String, userScreenName: userDict["screen_name"] as! String, userFullName: userDict["name"] as! String, startIndex: userDict["indices"]![0] as! Int, endIndex: userDict["indices"]![1] as! Int)
                    userMentionArray.append(mention)
                }
            }
        }
        
        return userMentionArray as NSArray
    }
    
    init(dictionary: NSDictionary) {
        self._jsonDict = dictionary
    }
    
}
