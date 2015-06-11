//
//  RestaurantTableViewController.swift
//  AppCodeSwiftBeginning
//
//  Created by Ahmad Ayman on 3/17/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var fetchedResultController: NSFetchedResultsController!
    var searchController: UISearchController!
    var searchResult: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        var fetchRequest = NSFetchRequest(entityName: "Restaurant")
        var sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        {
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultController.delegate = self
            var e: NSError?
            var result = fetchedResultController.performFetch(&e)
            RestaurantData.restaurants = fetchedResultController.fetchedObjects as [Restaurant]
            if result != true
            {
                println(e!.localizedDescription)
            }
        }
        
        //Seach Controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false // As we prsenting in the same table view set this to false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    
    //MARK: Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResult.count
        }
        else {
            return RestaurantData.restaurants.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as RestaurantCustomTableViewCell
        
        // Configure the cell...
        let restaurant = (searchController.active) ? searchResult[indexPath.row] : RestaurantData.restaurants[indexPath.row]
        cell.nameLabel.text           = restaurant.name
        cell.locationLabel.text       = restaurant.location
        cell.typeLabel.text           = restaurant.type
        cell.thumbnailImageView.image = UIImage(data: restaurant.image)
        
        // The reduis of the corner is the same reduis of the image [ width / 2 ]
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        // Update the cell accessory type information also based on the restuarantIsVisted array
        //cell.visitedAccessoryIcon.hidden = restaurant.isVisited ? false : true
            
        return cell
    }
    
    //---------------------- Did Select
    
    /* override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let callActionHandler = {
            (action: UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(
                tyle: UIAlertControllerStyle.Alert)
            
            alertMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: UIAlertActionStyle.Default, handler: callActionHandler)
        
        let isVisitedActionHandler = { (action: UIAlertAction!) -> Void in
            let visitedCell = tableView.cellForRowAtIndexPath(indexPath) as RestaurantCustomTableViewCell
            if RestaurantData.restaurantIsVisited[indexPath.row] {
                visitedCell.visitedAccessoryIcon.hidden = true
                RestaurantData.restaurantIsVisited[indexPath.row] = falsث
            }else {
                visitedCell.visitedAccessoryIcon.hidden = false
                RestaurantData.restaurantIsVisited[indexPath.row] = true
            }
        }
        
        var vistedStatus = RestaurantData.restaurantIsVisited[indexPath.row] ? "I've not been there" : "I've been there"
        
        let isVisitedAction = UIAlertAction(title: vistedStatus, style: UIAlertActionStyle.Default, handler: isVisitedActionHandler)

        optionMenu.addAction(cancelButton)
        optionMenu.addAction(callAction)
        optionMenu.addAction(isVisitedAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        // As when we select a row it stay selected
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    } */
    
    //----------------------
    
    
    // MARK: Actions
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share") {
                
                (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
                
                let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
                let twitterAction  = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
                let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
                let emailAction    = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default, handler: nil)
                let cancelAction   = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                
                shareMenu.addAction(twitterAction)
                shareMenu.addAction(facebookAction)
                shareMenu.addAction(emailAction)
                shareMenu.addAction(cancelAction)
                
                self.presentViewController(shareMenu, animated: true, completion: nil)
        }
        
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            // Delete the row from the data source
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
            {
                let restaurantToDelete = self.fetchedResultController.objectAtIndexPath(indexPath) as Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                var e: NSError?
                if managedObjectContext.save(&e) != true {
                    println("delete error: \(e!.localizedDescription)")
                }
            }
        }
        
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        
        return [shareAction, deleteAction]
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active { return false }
        else { return true }
    }
    
    //MARK: NSFetchResultCotroller Delegate Methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        RestaurantData.restaurants = controller.fetchedObjects as [Restaurant]
        
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
            
        default:
            tableView.reloadData()
        }
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    //MARK: Segue Methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                if let dvc = segue.destinationViewController as? DetailViewController {
                    dvc.restaurant = (searchController.active) ? searchResult[indexPath.row] : RestaurantData.restaurants[indexPath.row]
                }
            }
        }
    }
    
    @IBAction func unwindSegueToHomeScreen(segue: UIStoryboardSegue) {}

    
    //MARK: Instance Methods
    func filterContentForSearchText(searchText: String)
    {
        searchResult = RestaurantData.restaurants.filter({ (restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            let locationMatch = restaurant.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return ( nameMatch != nil || locationMatch != nil )
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
}