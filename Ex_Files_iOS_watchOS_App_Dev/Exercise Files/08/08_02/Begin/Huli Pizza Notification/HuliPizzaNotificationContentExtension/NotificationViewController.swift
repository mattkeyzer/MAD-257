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

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
