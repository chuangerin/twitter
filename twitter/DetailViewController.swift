//
//  DetailViewController.swift
//  twitter
//
//  Created by Erin Chuang on 10/3/14.
//  Copyright (c) 2014 Erin Chuang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var tweet : Tweet!
    var retweeted = false
    var favorited = false

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let user = tweet.user!
        if let imgurl = user.profileImageUrl {
            profileImage.setImageWithURL(NSURL(string: imgurl))
        }
        nameLabel.text = user.name
        screenNameLabel.text = "@" + user.screenName!
        contentLabel.text = tweet.text
        createdAtLabel.text = tweet.detailCreatedAt
        retweetsLabel.text = String(tweet.retweetCount)
        favoritesLabel.text = String(tweet.favoriteCount)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newSegue" {
            var svc = segue.destinationViewController as EditViewController
            svc.mode = "edit"
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        var retweet = retweetsLabel.text?.toInt()
        if self.retweeted {
            retweet = retweet! - 1
            self.retweeted = false
        } else {
            retweet = retweet! + 1
            self.retweeted = true
        }
        retweetsLabel.text = String(retweet!)
    }
    
    @IBAction func onFavorite(sender: UISwitch) {
        self.favorited = !self.favorited
        sender.on = self.favorited
        var favorites = favoritesLabel.text?.toInt()
        if self.favorited {
            favorites = favorites! + 1
        } else {
            favorites = favorites! - 1
        }
        favoritesLabel.text = String(favorites!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
