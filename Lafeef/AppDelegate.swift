//
//  AppDelegate.swift
//  Lafeef
//
//  Created by Riham Mastour on 05/06/1442 AH.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

 
    var window: UIWindow?

    var activeController: UIViewController!

    var navigationController: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        check()
        
        return true
    }
    //Auto Login
    func check(){
        //Areej code
//        if UserDefaults.standard.value(forKey: "email") != nil{
//            let vc = UIStoryboard.init(name: "ProfileScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileScreen")
//            let navVC = UINavigationController(rootViewController: vc)
//            let share = UIApplication.shared.delegate as! AppDelegate
//            share.window?.rootViewController = navVC
//            share.window?.makeKeyAndVisible()
//        }
        
        //Raghad code
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                
                Auth.auth().addStateDidChangeListener { (_, user) in
                    print("auth state did change \(user)")
                    switch user {
                    case nil:
                        guard self.activeController! is ProfileViewController else { return }
                        let publicController = sb.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
                        self.navigationController.setViewControllers([publicController], animated: false)
                        self.navigationController.popToViewController(publicController, animated: true)
                        self.activeController = publicController
                        
                        
                        
                    default:
                        /// secret view should be shown
                        guard self.activeController! is LoginViewController else { return }
                        let secretViewController = sb.instantiateViewController(withIdentifier: "ProfileScreen") as! ProfileViewController
                        self.navigationController.setViewControllers([secretViewController], animated: false)
                        self.navigationController.popToViewController(secretViewController, animated: true)
                        self.activeController = secretViewController
                    }
                    
                
    }
        
        let publicController = sb.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
               let secretController = sb.instantiateViewController(withIdentifier: "ProfileScreen") as! ProfileViewController
        
        activeController = publicController
                
                switch Auth.auth().currentUser != nil {
                case true:
                    activeController = secretController
                    print("user was logged on start up")
                default: break
                }
        navigationController = UINavigationController.init(rootViewController: activeController)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

