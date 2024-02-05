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
    
    let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: [])
    let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze 5 Seconds", options: [])
    
    
    func didReceive(_ notification: UNNotification) {
        content = notification.request.content.mutableCopy() as! UNMutableNotificationContent
        contentTitle.text = content.title
        contentSubtitle.text = content.subtitle
        contentBody.text = content.body
        
        extensionContext?.notificationActions = [snoozeAction,likeAction]
    }

}
