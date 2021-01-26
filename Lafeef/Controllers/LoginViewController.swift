//
//  loginViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 11/06/1442 AH.
//
import UIKit
import Foundation
import Firebase
import FirebaseAuth
import SwiftValidator

class LoginViewController: UIViewController, UITextFieldDelegate{
    var password : String = ""
    let validator = Validator()
       var isValidated : Bool  = false

    @IBOutlet weak var logo: UIImageView!
      @IBOutlet weak var lemon: UIButton!
      @IBOutlet weak var strawberry: UIButton!
      @IBOutlet weak var pineapple: UIButton!
      @IBOutlet weak var orange: UIButton!
      @IBOutlet weak var kiwi: UIButton!
      @IBOutlet weak var berry: UIButton!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var resetPass:UIButton!
    @IBOutlet var deSelectedButton: [UIButton]!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.layer.zPosition = -1 // ما ندري وش فايدته
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
                                 print("here")
                                 // clear error label
                                 validationRule.errorLabel?.isHidden = true
                                 validationRule.errorLabel?.text = ""

                                 if let textField = validationRule.field as? UITextField {
                                     textField.layer.borderColor =  UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
                                     textField.layer.borderWidth = 3
                                 } else if let textField = validationRule.field as? UITextView {
                                     textField.layer.borderColor =  UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
                                     textField.layer.borderWidth = 3
                                 }
                             }, error:{ (validationError) -> Void in
                                 print("error")
                                 validationError.errorLabel?.isHidden = false
                                 validationError.errorLabel?.text = validationError.errorMessage
                                 if let textField = validationError.field as? UITextField {
                                     textField.layer.borderColor = UIColor.red.cgColor
                                     textField.layer.borderWidth = 3.0
                                 } else if let textField = validationError.field as? UITextView {
                                     textField.layer.borderColor = UIColor.red.cgColor
                                     textField.layer.borderWidth = 3.0
                                 }
                             })

                      validator.registerField(emailTextfield, rules: [RequiredRule(), EmailRule()])
                      self.navigationController?.isNavigationBarHidden = true
              //        self.navigationController?.navigationBar.layer.zPosition = -1
        emailTextfield.delegate = self

       // emailTextfield.delegate = self as? UITextFieldDelegate
    
        logo.layer.zPosition = 2
        lemon.layer.cornerRadius = 40
        pineapple.layer.cornerRadius = 40
        strawberry.layer.cornerRadius = 40
        orange.layer.cornerRadius = 40
        kiwi.layer.cornerRadius = 40
//        berry.layer.cornerRadius = 40
//        berry.layer.backgroundColor = whiteColor
        berry.layer.cornerRadius = 40
        berry.imageView?.backgroundColor = UIColor.white
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
        emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height/2
        emailTextfield.clipsToBounds = true
        
        self.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial")
        
        
        
    }
    @IBAction func berryPass(_ sender: UIButton) {
        password = "berry123"
      //  berry.backgroundColor = UIColor.blue
        selectButton(sender)

    }
    
    @IBAction func kiwiPass(_ sender: UIButton) {
        password = "kiwi123"
     //   kiwi.backgroundColor = UIColor.blue
        selectButton(sender)


    }
    @IBAction func orangePass(_ sender: UIButton) {
        password = "orange123"
       // orange.backgroundColor = UIColor.blue
        selectButton(sender)

    }
    
    @IBAction func lemonPass(_ sender: UIButton) {
        password = "lemon123"
       // lemon.backgroundColor = UIColor.blue
        selectButton(sender)

    }
    
    @IBAction func strawberryPass(_ sender: UIButton) {
        password = "strawberry123"
      //  strawberry.backgroundColor = UIColor.blue
        selectButton(sender)

    }
    
    @IBAction func pineapplePass(_ sender: UIButton) {
        password = "pineapple123"
       // pineapple.backgroundColor = UIColor.blue
        selectButton(sender)

    }
    
    func selectButton(_ sender: UIButton){
           //deselect all buttons first
           deselectButton()
           //select one button seconed
           sender.layer.borderWidth = 3.5
           sender.layer.borderColor =  UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
       }
       
       func deselectButton(){
           deSelectedButton.forEach({$0.layer.borderWidth = 0
                                   $0.layer.borderColor = .none})
       }
    //---------------------------------------- validation
      func validationSuccessful()  {
                  print("Validation Success!")
          errorLabel?.isHidden = true
          isValidated = true
          
                 
              
              }
          func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
            // turn the fields to red
            for (field, error) in errors {
              if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
              }
             errorLabel?.text = error.errorMessage // works if you added labels
            errorLabel?.isHidden = false
            }
          }
//    @IBAction func next(_ sender: Any) {
//            validator.validate(self)
//            if password != "" &&  isValidated  {
//
//                self.performSegue(withIdentifier: "emailNxt", sender: self)
//            }else{
//                passLabel.text = "لطفًا، اختر صورة "
//            }
//
//        }
//
//    }
    @IBAction func loginAction(_ sender: AnyObject) {
        
        if self.emailTextfield.text == "" || self.password == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        
        } else {
           
            Auth.auth().signIn(withEmail: self.emailTextfield.text!, password: self.password) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the ProfileViewController if the login is sucessful
                  //  let vc = UIViewController()
             //       vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                   // self.present(vc, animated: true, completion: nil)
                    //
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileScreen")
                    //self.modalPresentationStyle = .fullScreen //or .overFullScreen
                  //  self.modalPresentationStyle = UIModalPresentationFullScreen;
                    self.present(vc!, animated: true, completion: nil)
                    
                             } else {
                                 
                                 //Tells the user that there is an error and then gets firebase to tell them the error
                                 let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                                 
                                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                 alertController.addAction(defaultAction)
                                 
                                 self.present(alertController, animated: true, completion: nil)
                             }
                         }
                     }
                 }
     
   
}

