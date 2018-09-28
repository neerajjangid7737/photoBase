//
//  UserData+CoreDataProperties.swift
//  photoBase
//
//  Created by neeraj on 07/09/18.
//  Copyright © 2018 neeraj. All rights reserved.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var titletext: String?
    @NSManaged public var desctext: String?
    @NSManaged public var image: NSData?

}
