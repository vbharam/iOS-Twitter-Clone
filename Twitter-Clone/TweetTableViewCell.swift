//
//  TweetTableViewCell.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/6/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var replyCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(tweet: Tweet) {
        self.tweet = tweet
        
        nameLabel.text = tweet.name
        handleLabel.text = tweet.handle
        bodyLabel.text = tweet.body
        timeLabel.text = self.getTime()
        replyCount.text = "\(tweet.replyCount)"
        retweetCount.text = "\(tweet.retweetCount)"
        favCount.text = "\(tweet.favCount)"
        
        // Update image:
        self.updateImage()
    }
    
    private func getTime() -> String {
        return "12m ago"
    }
    
    private func updateImage() {
        self.profilePicImageView.image = UIImage(named: "default_profile")
    }
    
}
