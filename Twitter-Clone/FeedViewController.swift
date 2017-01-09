//
//  FeedViewController.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/6/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.fetchTwitterData {
            // self.tableView.reloadData()
            self.setUpTableView()
        }
    }

    
    func setUpTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as? TweetTableViewCell {
            
            let tweet: Tweet = tweets[indexPath.row]
            
            cell.configureCell(tweet: tweet)
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tweet: Tweet = tweets[indexPath.row]
        
        /*
         let detailsVC = TweetDetailViewController()
         detailsVC.tweet = tweet
         
         self.navigationController?.pushViewController(detailsVC, animated: true)
         */
        
        performSegue(withIdentifier: "TweetDetailVC", sender: tweet)
    }
    
    
    func fetchTwitterData(completed: @escaping DownloadComplete) {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth oauth_consumer_key=\"PL4HWurqv2yBzTBHLZwQLgJnF\",oauth_token=\"718131356593590272-WuKsvhyD6CGbkVOBr42tVc5fLjjbidm\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1483938345\",oauth_nonce=\"ShwRT3\",oauth_signature=\"q6kGCjJEILBM2ssZ1IIb2XgIm24%3D\""
        ]
        
        // let userTimeline_url = BASE_URL + USER_TIMELINE_URL
        let userTimetine_url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=tim_cook"
        
        let forcastURL = URL(string: userTimetine_url)
        
        Alamofire.request(forcastURL!, headers: headers)
            .responseJSON { response in
                // print(response.request as Any)  // original URL request
                // print(response.response as Any) // URL response
                // print(response.data as Any)     // server data
                // print(response.result as Any)   // result of response serialization
                
                if let data = response.result.value {
                    // print("JSON: \(data)")
                }
                
                if let dictArray = response.result.value as? [Dictionary<String, AnyObject>], dictArray.count > 0 {
                    
                    for tweetDict in dictArray {
                        
                        self.tweets.append(Tweet(dictionary: tweetDict as NSDictionary))
                    }
                }
            completed()
            self.tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TweetDetailVC" {
            if let detailsVC = segue.destination as? TweetDetailViewController {
                if let tweet = sender as! Tweet? {                    
                    detailsVC.tweet = tweet
                }
            }
        }
    }
}

