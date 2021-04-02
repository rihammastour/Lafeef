//
//  SignUpOrLoginViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 26/01/2021.
//

import UIKit
import SwiftyGif
import CodableFirebase

class SignUpOrLoginViewController: UIViewController, SwiftyGifDelegate {

    //MARK:- Proprities
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        setUpElements()

        }
    
    func setUpElements() {
        //Styling Text Label
        // Utilities.styleTextField(emailTextField)
            
        //Styling Buttons
        Utilities.styleFilledButton(logInButton, color: "whiteApp")
        Utilities.styleFilledButton(signUpButton, color: "whiteApp")
        
    }

}
