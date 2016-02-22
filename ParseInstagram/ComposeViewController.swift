//
//  ComposeViewController.swift
//  ParseInstagram
//
//  Created by Abby Juan on 2/22/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let userMedia = UserMedia()
    
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var composeImageView: UIImageView!
    @IBOutlet weak var tapLabel: UILabel!
    
    @IBAction func onTap(sender: AnyObject) {
        //Instantiate UIImagePickerController
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
    //upload Image
        UserMedia.postUserImage(composeImageView.image!, withCaption: captionLabel.text!) { (success, error) -> Void in
            if success{
                print("Success!")
                self.tabBarController?.selectedIndex = 2
                let vc = self.tabBarController?.selectedViewController as! ViewController
                vc.postsData()
            }else{
                print(error?.localizedDescription)
            }
        }

    
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeImageView.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            self.tapLabel.hidden = true
            self.composeImageView.hidden = false
            self.dismissViewControllerAnimated(true, completion: nil)
            
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let editedImage = resize(originalImage, newSize: CGSize(width: 500, height: 500))
            
            // Set the Original Image
            composeImageView.image = originalImage
    }
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
