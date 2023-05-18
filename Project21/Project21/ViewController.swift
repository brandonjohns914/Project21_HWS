//
//  ViewController.swift
//  Project21
//
//  Created by Brandon Johns on 5/16/23.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
    }//viewDidLoad
    
    @objc func registerLocal()
    {
                                                                                                                                //request premission to show alerts
        let center = UNUserNotificationCenter.current()
                                                                                                                                // .alert = show message
                                                                                                                                //. badge = alert onicon
                                                                                                                                // .sound = play a sound
        center.requestAuthorization(options: [.alert, .badge, .sound ]) { granted, error in
            if granted                                                                                                          //yes for alerts
            {
                print("Yay!")
            }
            else
            {
                print("D'oh")
            }
        }
    }//registerLocal
    
                                                                                                                            //what and when content to show
    @objc func scheduleLocal()
    {
        registerCategories()                                                                                                // ios now knows what alarm is
        let center = UNUserNotificationCenter.current()                                                                     // messages to home screen
        
        let content = UNMutableNotificationContent()
        
        content.title = "Late Wake Up Call"                                                                                 // title that flashes on home screen
        
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        
        
        content.categoryIdentifier = "alarm"
        
        content.userInfo = ["customData": "fizzbuzz"]
        
        content.sound = .default                                                                                            //default sound
        
        var dateComponents = DateComponents()
        
        dateComponents.hour = 10
        dateComponents.minute = 30
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)                           //alert at 10:30
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                                                                                                            // identifer UUID.uuidString = random string
                                                                                                                            // content = early bird. . .
                                                                                                                            // trigger = alert in 5 sec
        
        center.add(request)
        
    }//scheduleLocal
    
    func registerCategories()
    {
        let center = UNUserNotificationCenter.current()
        
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground)
                                                                                                        //"show" only i can see
                                                                                                        // title shows the user
                                                                                                        // .foreground = open the app instantly
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
                                                                                                        //alarm comes from the content.categoryIDentifer set earlier
                                                                                                        // actions come the show the method
                                                                                                        
        center.setNotificationCategories([category])
        
        
        
    }//registerCategories
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
                                                                    // response what the user did
                                                                    // notification that we created
                                                                    // content what the notification did
        
        if let customData = userInfo["customData"] as? String                                                           // customData comes from the content.userInfo created in scheduleLocal
        {
            print("Custom data receieved: \(customData)")
            
            
            switch response.actionIdentifier
            {
            case UNNotificationDefaultActionIdentifier:
                // user swiped to unlock
                print("Default Identifier")
                
            case "show":                                                                                                            // came from the show aalert created in registerCategories
                print("Show more infomation...")
                
            default:
                break
                
            }
            
            completionHandler() 
        }//customData
        
        
        
    }// userNotificationCenter
    
    
}//viewController

