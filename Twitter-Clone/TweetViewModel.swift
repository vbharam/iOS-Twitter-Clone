//
//  TweetViewModel.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/8/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import Foundation
import UIKit

class TweetViewModel {
    private var _name: String!
    private var _handle: String!
    private var _time: String!
    private var _body: NSAttributedString!
    private var _profilePic: String!
    private var _inlinePic: String!
    private var _replyCount: Int!
    private var _retweetCount: Int!
    private var _favCount: Int!
    
    var tweet: Tweet?
    
    
    var name: String {
        return _name == nil ? "" : _name
    }
    
    var handle: String {
        return _handle == nil ? "" : _handle
    }
    
    var time: String {
        return _time == nil ? "" : _time
    }
    
    var body: NSAttributedString {
        return _body == nil ? NSMutableAttributedString(string: "") : _body
    }
    
    var profilePic: String {
        return _profilePic == nil ? "" : _profilePic
    }
    
    var inlinePic: String {
        return _inlinePic == nil ? "" : _inlinePic
    }
    
    var replyCount: Int {
        return _replyCount == nil ? 0 : _replyCount
    }
    
    var retweetCount: Int {
        return _retweetCount == nil ? 0 : _retweetCount
    }
    
    var favCount: Int {
        return _favCount == nil ? 0 : _favCount
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.initValues()
    }
    
    
    func initValues() {
        let tweetDict = self.tweet?.jsonDict
        
        if let favCount = tweetDict?["favorite_count"], let retweetCount = tweetDict?["retweet_count"], let replyCount = tweetDict?["retweet_count"], let message = tweetDict?["text"], let time = tweetDict?["created_at"], let user = tweetDict?["user"] as? Dictionary<String, AnyObject>, let entities = tweetDict?["entities"] as? Dictionary<String, AnyObject> {
            
            var inlineImageUrl: String = ""
            var mention: UserMention?
            
            if let urls = entities["media"] as? [Dictionary<String, AnyObject>], urls.count > 0 {
                // Get the media URL if any
                inlineImageUrl = urls[0]["media_url_https"] as! String
            }
            
            self._name = user["name"] as! String
            self._handle = user["screen_name"] as! String
            self._time = self.getTime(time: time as! String)
            self._body = formattedBodyTextForTweet(body: message as! String)
            self._profilePic = user["profile_image_url_https"] as! String
            self._inlinePic = inlineImageUrl
            self._replyCount = replyCount as! Int
            self._retweetCount = retweetCount as! Int
            self._favCount = favCount as! Int
        }
    }
    
    private func getTime(time: String) -> String {
        return "12m ago"
    }
    
    private func formattedBodyTextForTweet(body: String) -> NSMutableAttributedString {
        let tweetBodyAttrString = NSMutableAttributedString(string: body)
        
        
        if (self.tweet?.userMention.count)! > 0 {
            for mention in (self.tweet?.userMention)! {
                let mention: UserMention = mention as! UserMention
                tweetBodyAttrString.addAttributes([NSForegroundColorAttributeName : actionBlue], range: mention.range() )
            }
        }
        
        return tweetBodyAttrString
    }
}
