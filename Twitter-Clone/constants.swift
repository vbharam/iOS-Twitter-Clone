//
//  constants.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/6/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import Foundation
import UIKit

let BASE_URL = "https://api.twitter.com/1.1/"

let USER_TIMELINE_URL = "statuses/user_timeline.json"


typealias DownloadComplete = () -> ()


var actionBlue: UIColor {
    return UIColor(colorLiteralRed: 83.0/255.0, green:145.0/255.0, blue:202.0/255.0, alpha:1.0)
}
