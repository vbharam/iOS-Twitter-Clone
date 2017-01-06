//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/6/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import Foundation

class Tweet {
    private var _name: String!
    private var _handle: String!
    private var _time: String!
    private var _body: String!
    private var _profilePic: String!
    private var _inlinePic: String!
    private var _replyCount: Int!
    private var _retweetCount: Int!
    private var _favCount: Int!
    
    
    var name: String {
        return _name == nil ? "" : _name
    }
    
    var handle: String {
        return _handle == nil ? "" : _handle
    }
    
    var time: String {
        return _time == nil ? "" : _time
    }
    
    var body: String {
        return _body == nil ? "" : _body
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
    
    
    init(name: String, handle: String, time: String, body: String, profilePic: String, inlinePic: String, replyCount: Int, retweetCount: Int, favCount: Int) {
        self._name = name
        self._handle = handle
        self._time = time
        self._body = body
        self._profilePic = profilePic
        self._inlinePic = inlinePic
        self._replyCount = replyCount
        self._retweetCount = retweetCount
        self._favCount = favCount
    }
    
}
