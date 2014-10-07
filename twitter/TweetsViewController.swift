//
//  TweetsViewController.swift
//  twitter
//
//  Created by Erin Chuang on 9/27/14.
//  Copyright (c) 2014 Erin Chuang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if (User.currentUser == nil) {
            return
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.refresh(self)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TimelinesCell") as TimelinesCell
        var tweet = self.tweets![indexPath.row] as Tweet
        var user = tweet.user!
        cell.nameLabel.text = user.name
        cell.screenNameLabel.text = "@" + user.screenName! as String
        cell.txtLabel.text = tweet.text
        cell.createdAtLabel.text = tweet.timeDiff
        if let imgurl = user.profileImageUrl {
            cell.profileImage.setImageWithURL(NSURL(string: imgurl))
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            var indexPath = tableView.indexPathForSelectedRow()
            var svc = segue.destinationViewController as DetailViewController
            svc.tweet = self.tweets![indexPath!.row]
        } else if segue.identifier == "newSegue" {
            var svc = segue.destinationViewController as EditViewController
            svc.mode = "new"
        }
    }

    @IBAction func onSignout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    func refresh(sender:AnyObject)
    {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            if (tweets != nil) {
                println("\(tweets!.count) tweets")
            } else {
                println("no tweets")
            }
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
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
