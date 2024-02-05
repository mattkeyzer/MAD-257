//
//  NotificationViewController.swift
//  HuliPizzaNotificationContentExtension
//
//  Created by Steven Lipton on 11/29/18.
//  Copyright © 2018 Steven Lipton. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contentSubtitle: UILabel!
    @IBOutlet weak var contentBody: UILabel!
    var content = UNMutableNotificationContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    let unlikeAction = UNNotificationAction(identifier: "unlike", title: "Unlike", options: [])
    let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: [])
    let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze 5 Seconds", options: [])
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        let action = response.actionIdentifier
        if action == "like"{
            extensionContext?.notificationActions = [snoozeAction, unlikeAction]
        }
        if action == "unlike"{
            extensionContext?.notificationActions = [snoozeAction, likeAction]
        }
        if action == "snooze"{
            completion(.dismissAndForwardAction)
        }
        
        completion(.doNotDismiss)
    }
    func didReceive(_ notification: UNNotification) {
        content = notification.request.content.mutableCopy() as! UNMutableNotificationContent
        contentTitle.text = content.title
        contentSubtitle.text = content.subtitle
        contentBody.text = content.body
        
        extensionContext?.notificationActions = [snoozeAction,likeAction]
    }

}
