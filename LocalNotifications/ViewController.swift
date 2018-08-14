//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Bart Jacobs on 22/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let dateAsString = "2018-07-6 04:32 PM"
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"

      let date = dateFormatter.date(from: dateAsString)
      print(date ?? "")

        // Configure User Notification Center
        UNUserNotificationCenter.current().delegate = self
        let notificationContent = UNMutableNotificationContent()
        notificationContent.sound = UNNotificationSound(named: "001.mp3")
      
        // Configure Notification Content
        notificationContent.title = "Cocoacasts"
        notificationContent.subtitle = "Local Notifications"
        notificationContent.body = "In this tutorial, you learn how to schedule local notifications with the User Notifications framework."
        var triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date!)
        triggerDate.second = triggerDate.second!
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,repeats: true)
        
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: trigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }

   // MARK: - Private Methods

    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            completionHandler(success)
        }
    }
}

extension ViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
}
