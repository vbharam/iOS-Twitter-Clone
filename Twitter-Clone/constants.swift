//
//  constants.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/6/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.twitter.com/1.1/"

let USER_TIMELINE_URL = "statuses/user_timeline.json"


typealias DownloadComplete = () -> ()

let dummyTweet = Tweet(name: "Vishal", handle: "@vbharam91", time:
    "Tue Jan 03 03:00:04 +0000 2017", body: "This is the world beyond the border. This is the world beyond the border. This is the world beyond the border", profilePic: "", inlinePic:"https://knowledge.wharton.upenn.edu/wp-content/uploads/2014/02/NAFTA.jpg", replyCount:34, retweetCount: 654, favCount: 92)

let dummyTweet1 = Tweet(name: "Vishal", handle: "@vbharam91", time:
    "Tue Jan 03 03:00:04 +0000 2017", body: "This is the world beyond the border.", profilePic: "https://pbs.twimg.com/profile_images/718131815672721408/fLdxx6Mo_400x400.jpg", inlinePic:"", replyCount:42, retweetCount: 345, favCount: 87)


// Dummy Data:
var dict: [Tweet]  = [dummyTweet1, dummyTweet, dummyTweet1, dummyTweet, dummyTweet, dummyTweet1, dummyTweet, dummyTweet, dummyTweet1, dummyTweet, dummyTweet1, dummyTweet, dummyTweet, dummyTweet1, dummyTweet1, dummyTweet, dummyTweet1, dummyTweet, dummyTweet, dummyTweet1, dummyTweet,dummyTweet]
