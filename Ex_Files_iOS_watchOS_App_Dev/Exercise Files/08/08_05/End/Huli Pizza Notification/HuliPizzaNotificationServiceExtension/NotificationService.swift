//
//  NotificationService.swift
//  HuliPizzaNotificationServiceExtension
//
//  Created by Steven Lipton on 11/28/18.
//  Copyright © 2018 Steven Lipton. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [Push]"
            switch bestAttemptContent.categoryIdentifier{
            case "snooze.category":
                let newContent = changePizzaNotification(content: request.content)
                newContent.title = newContent.title + "[Push]"
                contentHandler(newContent)
            default:contentHandler(bestAttemptContent)
            }
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

    func changePizzaNotification(content oldContent:UNNotificationContent) -> UNMutableNotificationContent{
        let content = oldContent.mutableCopy() as! UNMutableNotificationContent
        let userInfo = content.userInfo as! [String:Any]
        if let orders = userInfo["order"] as? [String]{
            content.body = "You are going to love this:\n"
            for item in orders{
                content.body += surferBullet + item + "\n"
            }
        }
        return content
    }
    
    
    //MARK: - Support Methods
    let surferBullet = "🏄🏽‍♀️ "
}
