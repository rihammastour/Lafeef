//
//  SignUpNameViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FirebaseCore


class SignUpNameViewController: UIViewController,UITextFieldDelegate {
    var email  = ""
    var pass = ""
    var day = ""
    var month = ""
    var year = ""
    var charachter = ""
    var name = ""
   

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 
        
       
        CharachterType(charachter: charachter)
        nameTextfield.delegate = self
        charachterImage.layer.cornerRadius = charachterImage.frame.size.height/2
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
        nameTextfield.layer.cornerRadius = nameTextfield.frame.size.height/2
        nameTextfield.clipsToBounds = true

        self.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom:0.71 , blueBottom: 0.71, type: "radial")
    }
    

   
    func CharachterType(charachter : String ){
           if (charachter == "Girl"){
               charachterImage.image = UIImage(named: "girl")
           } else{
               charachterImage.image = UIImage(named: "boy")
           }
           
       }
      
       @IBAction func next(_ sender: Any) {
           let signUpManager = FirebaseAuthManager()
        let DOB = day+"-"+month+"-"+year
        signUpManager.createUser(email: email, password: pass, name:name,sex:charachter,DOB:DOB) {
               [weak self] (success,error) in
                     guard let self = self else { return }
                    
                     if (success) {
                       self.errorLabel.text = "User was sucessfully created."
                        //navogation
                     } else {
                       self.errorLabel.text = error
                     }
           }

       }
       
       
   }
