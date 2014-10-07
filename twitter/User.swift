//
//  User.swift
//  twitter
//
//  Created by Erin Chuang on 9/27/14.
//  Copyright (c) 2014 Erin Chuang. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var dictionary : NSDictionary
    var name : String?
    var screenName : String?
    var profileImageUrl : String?
    var tagLine : String?
    
    init(dictionary:NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
           return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                //serialize json string
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                //store with key
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                //store with key (clear it)
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            //save it
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
