//
//  DetailViewController.swift
//  AppCodeSwiftBeginning
//
//  Created by Ahmad Ayman on 3/20/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    // All stored variables have to initalized
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restaurantImageView.image = UIImage(data: restaurant.image)
        self.tableView.backgroundColor =  UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0,alpha: 0.2)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)  // Remove the footer with blank view
        self.title = restaurant.name
        
        // Enable Self Sizing
        tableView.estimatedRowHeight = 48.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as DetailTableViewCell
        
        cell.mapButton.hidden = true

        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
            cell.mapButton.hidden = false
        case 2:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 3:
            cell.fieldLabel.text = "Been There"
            cell.valueLabel.text = restaurant.isVisited.boolValue ? "Yes" : "No"
        default: break
        }
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMapSegue"
        {
            if let destinationViewController = segue.destinationViewController as? MapViewController
            {
                destinationViewController.restaurant = restaurant
            }
        }
    }
    
    
    @IBAction func close(segue:UIStoryboardSegue) { }
    
}

