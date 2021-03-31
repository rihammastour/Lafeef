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

  
    
    
}
