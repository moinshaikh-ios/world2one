//
//  AppDelegate.swift
//  Cabby
//
//  Created by Zain on 14/10/2024.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
//        AppDefault.filterId = []
//        AppDefault.groupId = []
//        AppDefault.filterArray2 = []
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self

           // Request Notification Permissions
           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
             print("Permission granted: \(granted)")
           }

           application.registerForRemoteNotifications()
           
           Messaging.messaging().delegate = self
        
        if AppDefault.accessToken == "" {
            let vc = SplashViewController.getVC(.main)
            window?.rootViewController = UINavigationController(rootViewController: vc)
        }else {
            let homeVC = HomeViewController.getVC(.home)
            window?.rootViewController = UINavigationController(rootViewController: homeVC)
        }

      
        return true
    }
    

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let url = userActivity.webpageURL {
            deepLinkAPi(LinkPath: url.absoluteString)
        }
        return true
    }
    
    func deepLinkAPi(LinkPath: String) {
        APIManager.shared.deepLink(LinkPath: LinkPath){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    Utility.showWarningAlert(message: "Group has been successfully added")

                    if response.modelList?.first?.accessToken != nil {
                        AppDefault.currentUser = response.modelList?.first
                        AppDefault.accessToken = response.modelList?.first?.accessToken ?? ""
                        AppDefault.username = response.modelList?.first?.username ?? ""
                        self.GotoOnBoard()
                    }
                    
                case .failure(let error):
                    Utility.showWarningAlert(message: "\(error)")
                }
            }
        }
    }
    
    
    func GotoLogin() {
        guard let chooseOptionVC = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(withIdentifier: "ChooseOptionViewController") as? ChooseOptionViewController else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: chooseOptionVC)
        navigationController.setNavigationBarHidden(true, animated: false) 

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func GotoOnBoard() {
        guard let onBoardVC = UIStoryboard(name: "OnBoarding", bundle: nil)
            .instantiateViewController(withIdentifier: "OnBoardingViewController") as? OnBoardingViewController else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: onBoardVC)
        navigationController.setNavigationBarHidden(true, animated: false)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    // Called when APNs has assigned the device a token
      func application(_ application: UIApplication,
                       didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
      }

      // Firebase Messaging token update
      func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(String(describing: fcmToken))")
          deviceAPi(PushRegistrationId: fcmToken ?? "")
      }

      // Foreground notification display
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
                                  withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
      }
    
    func deviceAPi(PushRegistrationId: String) {
        APIManager.shared.device(PushRegistrationId: PushRegistrationId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let res):
                  print(res)
                    
                case .failure(let error):
                    Utility.showWarningAlert(message: "\(error)")
                }
            }
        }
    }
    
    
    
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
