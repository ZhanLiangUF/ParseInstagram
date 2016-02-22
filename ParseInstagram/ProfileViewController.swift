//
//  ProfileViewController.swift
//  ParseInstagram
//
//  Created by Abby Juan on 2/22/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit

import Parse

class ProfileViewController: UIViewController {

   
    @IBAction func onSignout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if(error != nil){
                print(error!.localizedDescription)
            }else{
                self.performSegueWithIdentifier("signoutSegue", sender: nil)
            }
    
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

