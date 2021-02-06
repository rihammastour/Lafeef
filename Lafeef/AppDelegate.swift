//
//  AppDelegate.swift
//  Lafeef
//
//  Created by Riham Mastour on 05/06/1442 AH.
//

import UIKit
import Firebase
import CodableFirebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    var activeController: UIViewController!
    
    var navigationController: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        //Auto Login
        _ = Auth.auth().addStateDidChangeListener { auth, user in

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            if user != nil {
                print(user?.uid,"Logged  in ??")
                self.fetchUserInfo()
                let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            } else {
                let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.signUpOrLoginViewController) as! SignUpOrLoginViewController
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        }
        return true
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
    
    //MARK: - Functions
    func fetchUserInfo(){
        //TODO: Should check local storage before fetch
        //TODO: Fetch User Info , And check if previous two steps are needed
        print("EXCUTIIIIIIII")
        FirebaseRequest.setDBListener(completion: fetchChildChangesoHandler(_:_:))
    }
    
    func fetchChildChangesoHandler(_ data:Any?, _ error:Error?) -> Void {
        print("data in app delagate Handeler",data)
        if let data = data{
            do{
                let child = try FirebaseDecoder().decode(Child.self, from: data)
                print("child in appdalegate",child)
                LocalStorageManager.setChild(child)
            }catch{
                print("error while decoding ",error.localizedDescription)
            }
            
        }else{
            print("error!! App delagate - No data passed",error?.localizedDescription ?? "error localized Description" )
        }
    }
    
    
}

