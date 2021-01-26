//
//  SignUpOrLoginViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 26/01/2021.
//

import UIKit

class SignUpOrLoginViewController: UIViewController {

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
                 Utilities.styleFilledButton(logInButton)
                 Utilities.styleFilledButton(signUpButton)
             }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
