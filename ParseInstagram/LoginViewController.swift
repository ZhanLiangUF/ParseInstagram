//
//  LoginViewController.swift
//  ParseInstagram
//
//  Created by Abby Juan on 2/21/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinButton(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("You're logged in")
            self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }
    @IBAction func signupButton(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool,error: NSError?) -> Void in
            if success {
                print("created a new user")
                
                self.performSegueWithIdentifier(("loginSegue"), sender: nil)
            }  else {
                    print(error?.localizedDescription)
                if error?.code == 202 {
                    print("Username is taken")
                }
                }
            }
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
