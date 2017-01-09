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
        
        let viewModel = TweetViewModel(tweet: self.tweet)
        
        nameLabel.text = viewModel.name
        handleLabel.text = viewModel.handle
        bodyLabel.attributedText = viewModel.body
        timeLabel.text = viewModel.time
        replyCount.text = "\(viewModel.replyCount)"
        retweetCount.text = "\(viewModel.retweetCount)"
        favCount.text = "\(viewModel.favCount)"
        
        // Update images:
        self.updateImage(imageview: self.profilePicImageView, imageUrl: viewModel.profilePic)
        
        // if verifyUrl(urlString: viewModel.inlinePic) { self.load_image(urlString: viewModel.inlinePic) }
    }
    
    func updateImage(imageview: UIImageView, imageUrl: String) {
        imageview.image = nil
        
        // If valid url
        if verifyUrl(urlString: imageUrl) {
            
            let imageURL: URL = NSURL(string: imageUrl) as! URL
            
            URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    // print(imageview, image)
                    imageview.image = image
                })
                
            }).resume()
        } else {
            if imageview == self.profilePicImageView {
                imageview.image = UIImage(named: "default_profile")
            }
        }
    }
    
    // Second method for image download + update
    func load_image(urlString:String) {
        self.inlineImageView.image = nil
        
        let imgURL = URL(string: urlString)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imgURL)!
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.inlineImageView.image = image
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
