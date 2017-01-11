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
        
        self.setUpTableView()

        
        self.fetchTwitterData(user: "tim_cook", completed: {})
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
            
            // Tap on the UserMention name to reload the page with the user:
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FeedViewController.handleTap(sender:)))
            cell.bodyLabel.addGestureRecognizer(tapGesture)
            
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tweet: Tweet = tweets[indexPath.row]
        performSegue(withIdentifier: "TweetDetailVC", sender: tweet)
        
        /*
         let detailsVC = TweetDetailViewController()
         detailsVC.tweet = tweet
         
         self.navigationController?.pushViewController(detailsVC, animated: true)
         */
    }
    
    
    // Use this mothod to reload the selected user from the tweet
    // Here, the input will be the
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.fetchTwitterData(user: "", completed: {})
        }
    }
    
    
    func fetchTwitterData(user: String, completed: @escaping DownloadComplete) {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "OAuth oauth_consumer_key=\"PL4HWurqv2yBzTBHLZwQLgJnF\",oauth_token=\"718131356593590272-WuKsvhyD6CGbkVOBr42tVc5fLjjbidm\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1484126775\",oauth_nonce=\"IOKt6S\",oauth_signature=\"RUOevmz2HswvMjJJyUs03Ky70oo%3D\""
        ]
        
//        OAuth oauth_consumer_key="PL4HWurqv2yBzTBHLZwQLgJnF",oauth_token="718131356593590272-WuKsvhyD6CGbkVOBr42tVc5fLjjbidm",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1484126775",oauth_nonce="IOKt6S",oauth_signature="RUOevmz2HswvMjJJyUs03Ky70oo%3D"
        
        let userTimelineUrl = BASE_URL + USER_TIMELINE_URL + user
        
        let twitterURL = URL(string: userTimelineUrl)
        
        Alamofire.request(twitterURL!, headers: headers)
            .responseJSON { response in
                // print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
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

