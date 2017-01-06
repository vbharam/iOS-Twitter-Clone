//
//  FeedViewController.swift
//  Twitter-Clone
//
//  Created by Vishal Bharam on 1/6/17.
//  Copyright © 2017 Codecoop. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var tweets = dict
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.setUpTableView()
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
