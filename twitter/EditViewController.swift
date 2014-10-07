//
//  EditViewController.swift
//  twitter
//
//  Created by Erin Chuang on 10/3/14.
//  Copyright (c) 2014 Erin Chuang. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    let user : User = User.currentUser!
    let offset : CGFloat = 20.0
    var keyboardFrame : CGRect = CGRect.nullRect
    var keyboardIsShowing : Bool = false
    var mode : String = "new"

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imgurl = user.profileImageUrl {
            profileImage.setImageWithURL(NSURL(string: imgurl))
        }
        nameLabel.text = user.name
        screenNameLabel.text = user.screenName
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillChangeFrameNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func keyboardWillShow(notification: NSNotification){
        keyboardIsShowing = true
        if let info = notification.userInfo {
            keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
            //arrangeViewOffsetFromKeyboard()
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        keyboardIsShowing = false
        //returnViewToInitialFrame()
    }

    @IBAction func onTweet(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
