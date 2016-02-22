//
//  ViewController.swift
//  ParseInstagram
//
//  Created by Abby Juan on 2/21/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts : [PFObject]?

    @IBOutlet weak var tableView: UITableView!
    
    let HeaderViewIdentifier = "TableViewHeaderView"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postsData() {
        //construct PFquery
        let query = PFQuery ( className: "UserMedia")
        query.orderByAscending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        //fetch data 
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.posts = media
                self.tableView.reloadData()
                // do something with the array of object returned by the call
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        let post = posts![indexPath.row]
        
        cell.captionLabel.text = post["caption"] as? String
        let userImageFile = post["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.pictureImageView.image = image!
                }
            }
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = self.posts{
            return posts.count
        }else{
            return 0
        }
    }
}

