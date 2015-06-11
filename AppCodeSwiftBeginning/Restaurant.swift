//
//  Restaurant.swift
//  AppCodeSwiftBeginning
//
//  Created by Ahmad Ayman on 3/20/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import Foundation
import CoreData

public class Restaurant : NSManagedObject {
    
    @NSManaged var name: String!
    @NSManaged var type: String!
    @NSManaged var location: String!
    @NSManaged var image: NSData!
    @NSManaged var isVisited: NSNumber!
}

