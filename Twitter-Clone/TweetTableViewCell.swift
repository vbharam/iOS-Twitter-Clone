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
    @IBOutlet weak var inlineImageView: UIImageView!
    
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
        self.updateImage(imageview: self.profilePicImageView, imageUrl: tweet.profilePic)
        self.updateImage(imageview: self.inlineImageView, imageUrl: tweet.inlinePic)
    }
    
    private func getTime() -> String {
        return "12m ago"
    }
    
    private func updateImage(imageview: UIImageView, imageUrl: String) {
        // If valid url
        
        if verifyUrl(urlString: imageUrl) {
            
            imageview.image = nil
            
            let imageURL: URL = NSURL(string: imageUrl) as! URL
            
            URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    imageview.image = image
                })
                
            }).resume()
        } else {
            if imageview == self.profilePicImageView {
                imageview.image = UIImage(named: "default_profile")
            }
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString, urlString != "" {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
}
