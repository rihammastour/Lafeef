//
//  SignUpOrLoginViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 26/01/2021.
//

import UIKit
import SwiftyGif

class SignUpOrLoginViewController: UIViewController, SwiftyGifDelegate {

    //MARK:- Proprities
    let splashAnimation = SplashAnimationView()

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        setUpElements()

        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Splash view
//        view.addSubview(splashAnimation)
//        splashAnimation.pinEdgesToSuperView(to: self.view)
//        splashAnimation.logoGifImageView.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  splashAnimation.logoGifImageView.startAnimatingGif()
    }
    
    func gifDidStop(sender: UIImageView) {
      //  splashAnimation.isHidden = true
    }
    
    func setUpElements() {
        //Styling Text Label
        // Utilities.styleTextField(emailTextField)
            
        //Styling Buttons
        Utilities.styleFilledButton(logInButton)
        Utilities.styleFilledButton(signUpButton)
    }

}
