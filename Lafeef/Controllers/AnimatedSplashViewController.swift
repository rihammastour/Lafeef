//
//  AnimatedSplashViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 06/02/2021.
//

import UIKit
import SwiftyGif

class AnimatedSplashViewController: UIViewController, SwiftyGifDelegate {
    
    //MARK:- Proprities
    let splashAnimation = SplashAnimationView()
    var isChild : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        
        // Splash view
        view.addSubview(splashAnimation)
        splashAnimation.pinEdgesToSuperView(to: self.view)
        splashAnimation.logoGifImageView.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashAnimation.logoGifImageView.startAnimatingGif()
        
    }
    
    func gifDidStop(sender: UIImageView) {
        splashAnimation.isHidden = true
        self.NextViewController()

    }
    
    func NextViewController() {

        
        if isChild! {
            let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
            view.window?.rootViewController = controller
            view.window?.makeKeyAndVisible()

        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.signUpOrLoginViewController) as! SignUpOrLoginViewController
            view.window?.rootViewController = controller
            view.window?.makeKeyAndVisible()


            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    func getChildPrefrence(){
        //Get Child Prefrences
        FirebaseRequest.getChildEquipments { (data, err) in
            if data != nil {
                print("Data ",data)
                do{
                    let equipments = try FirebaseDecoder().decode([ChildEquipment].self, from: data)
                    self.childEquipment = equipments
                  
                }catch{
                    print("Incorrect Format")
                }
            }else{
                print("error")
            }
        }
        print("dddddddd ",childEquipment)
   
    }

  
    func reflecBackerytUserEquipment(equipmentName:String){
        print("inside reflect")
        for item in self.childEquipment{
            if !item.inUse && item.name.contains("Frame"){
                print("frame")
                GameScene.presentBackeyEquipment(at: item.name)
                FirebaseRequest.updateUserEquipment(equipmentName: item.name) { (update, error) in
                        if error == nil {
                            print("updated")
                        }else{
                            print("eror")
                        }
                    }
                    
            }else if !item.inUse && item.name == "lamp"{
                print("lamp")
                GameScene.presentBackeyEquipment(at: item.name)
                FirebaseRequest.updateUserEquipment(equipmentName:item.name) { (update, error) in
                        if error == nil {
                            print("updated")
                        }else{
                            print("eror")
                        }
                    }
            }
        }
        }
    func reflecCharachtertUserEquipment(equipmentName:String){
        print("inside reflect")
        for item in self.childEquipment{
            if !item.inUse && item.name == equipmentName{
                print("frame")
           
//                HomeViewController.setImage(<#String#>)
                FirebaseRequest.updateUserEquipment(equipmentName: item.name) { (update, error) in
                        if error == nil {
                            print("updated")
                        }else{
                            print("eror")
                        }
                    }

            }
        }
    
        }
    
}
