//
//  Reminder.swift
//  Task Alerting App
//
//  Created by Tech on 2020-03-12.
//  Copyright © 2020 DeliveryGuys. All rights reserved.
//

import Foundation
import UIKit

class Reminder: NSObject, NSCoding {
    
    var notification: UILocalNotification
    var name: String
    var time: NSDate
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("reminders")
    
    
    struct PropertyKey {
        static let nameKey = "name"
        static let timeKey = "time"
        static let notificationKey = "notification"
    }
    
    
    init(name: String, time: NSDate, notification: UILocalNotification) {
        self.name = name
        self.time = time
        self.notification = notification
        super.init()
    }
    
    
    deinit {
        
        UIApplication.sharedApplication().cancelLocalNotification(self.notification)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(time, forKey: PropertyKey.timeKey)
        aCoder.encodeObject(notification, forKey: PropertyKey.notificationKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let time = aDecoder.decodeObjectForKey(PropertyKey.timeKey) as! NSDate
        let notification = aDecoder.decodeObjectForKey(PropertyKey.notificationKey) as! UILocalNotification
        self.init(name: name, time: time, notification: notification)
    }
}
