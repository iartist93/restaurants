//
//  SharingViewController.swift
//  AppCodeSwiftBeginning
//
//  Created by Ahmad Ayman on 4/25/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class SharingViewController: UIViewController {

    @IBOutlet weak var backgroundIamgeView: UIImageView!
    
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var shareLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        backgroundIamgeView.addSubview(blurEffectView)
        
        var screenWidth = view.bounds.size.width
        var screenHeight = view.bounds.size.height
        
        self.facebook.transform = CGAffineTransformMakeTranslation(screenWidth/2 + 50, screenHeight/2 + 50)
        self.message.transform = CGAffineTransformMakeTranslation(screenWidth/2 + 50, -screenHeight/2 - 50)
        self.email.transform = CGAffineTransformMakeTranslation(-screenWidth/2 - 50, -screenHeight/2 - 50)
        self.twitter.transform = CGAffineTransformMakeTranslation(-screenWidth/2 - 50, screenHeight/2 + 50)
        
        let shareLabelInitalTransform = CGAffineTransformMakeTranslation(0, 1500)
        let shareLabelInitalScale = CGAffineTransformMakeScale(0, 0)
        self.shareLabel.transform = CGAffineTransformConcat(shareLabelInitalTransform, shareLabelInitalScale)
        
        
        self.facebook.hidden = true
        self.twitter.hidden = true
        self.message.hidden = true
        self.email.hidden = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: nil,
            animations:
            {
                self.facebook.hidden = false
                self.facebook.transform = CGAffineTransformMakeTranslation(0, 0)
            },
        completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: nil,
            animations:
            {
                self.message.hidden = false
                self.message.transform = CGAffineTransformMakeTranslation(0, 0)
            },
            completion: nil)
        
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: nil,
            animations:
            {
                self.twitter.hidden = false
                self.twitter.transform = CGAffineTransformMakeTranslation(0, 0)
            },
            completion: nil)
        
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: nil,
            animations:
            {
                self.email.hidden = false
                self.email.transform = CGAffineTransformMakeTranslation(0, 0)
            },
            completion: nil)
   
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil,
            animations:
            {
                let shareLabelInitalTransform = CGAffineTransformMakeTranslation(0, 0)
                let shareLabelInitalScale = CGAffineTransformMakeScale(1, 1)
                self.shareLabel.transform = CGAffineTransformConcat(shareLabelInitalTransform, shareLabelInitalScale)
            },
            completion: nil)
    }
    
    @IBAction func close()
    {
        var screenWidth = view.bounds.size.width
        var screenHeight = view.bounds.size.height
        
        UIView.animateWithDuration(0.5, delay: 0, options: nil,
            animations:
            {
                self.facebook.transform = CGAffineTransformMakeTranslation(screenWidth/2 + 50, screenHeight/2 + 50)
            }){ (successed) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.facebook.hidden = true
            }
        
        UIView.animateWithDuration(0.5, delay: 0, options: nil,
            animations:
            {
                self.message.transform = CGAffineTransformMakeTranslation(screenWidth/2 + 50, -screenHeight/2 - 50)
            }){ successed -> Void in self.message.hidden = true }
        
        
        UIView.animateWithDuration(0.5, delay: 0, options: nil,
            animations:
            {
                self.twitter.transform = CGAffineTransformMakeTranslation(-screenWidth/2 - 50, screenHeight/2 + 50)
            }){ successed -> Void in self.twitter.hidden = true }
        
        
        UIView.animateWithDuration(0.5, delay: 0, options: nil,
            animations:
            {
                self.email.transform = CGAffineTransformMakeTranslation(-screenWidth/2 - 50, -screenHeight/2 - 50)
            }){ successed -> Void in self.email.hidden = true }
        
        UIView.animateWithDuration(0.5, delay: 0, options: nil,
            animations:
            {
                let shareLabelInitalTransform = CGAffineTransformMakeTranslation(0, 1500)
                let shareLabelInitalScale = CGAffineTransformMakeScale(0, 0)
                self.shareLabel.transform = CGAffineTransformConcat(shareLabelInitalTransform, shareLabelInitalScale)
            }){ successed -> Void in self.shareLabel.hidden = true }
    }
    
   
    @IBAction func share(sender: AnyObject)
    {
        // This is the IBAction of all buttons
    }
}
