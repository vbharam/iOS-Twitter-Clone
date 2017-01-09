//
//  UserMention.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/8/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import Foundation

class UserMention {
    private var _userId: String
    private var _userScreenName: String
    private var _userFullName: String
    private var _startIndex: Int
    private var _endIndex: Int
    
    init(userId: String, userScreenName: String, userFullName: String, startIndex: Int, endIndex: Int) {
        self._userId = userId
        self._userScreenName = userScreenName
        self._userFullName = userFullName
        self._startIndex = startIndex
        self._endIndex = endIndex
    }
    
    func isValidMention() -> Bool {
        return self.hasValidIndices() && self._userId != ""
    }
    
    func hasValidIndices() -> Bool {
        return self._startIndex >= 0 && self._endIndex > 0 && self._startIndex < self._endIndex
    }
    
    func length() -> NSInteger {
        return self._endIndex - self._startIndex
    }
    
    func range() -> NSRange {
        return NSMakeRange(self._startIndex, self.length())
    }
}
