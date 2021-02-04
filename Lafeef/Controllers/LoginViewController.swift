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
import FirebaseUI
//import FirebaseAuthUI
class LoginViewController: UIViewController, UITextFieldDelegate, ValidationDelegate, FUIAuthDelegate{
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
    @IBOutlet weak var passLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
       self.navigationController?.navigationBar.layer.zPosition = -1 
        validator.styleTransformers(success:{ (validationRule) -> Void in
                                 print("here")
                                 // clear error label
                                 validationRule.errorLabel?.isHidden = false
                                 validationRule.errorLabel?.text = " "

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
                      emailTextfield.delegate = self

        //Front-End
    
//        logo.layer.zPosition = 2
        lemon.layer.cornerRadius = 40
        pineapple.layer.cornerRadius = 40
        strawberry.layer.cornerRadius = 40
        orange.layer.cornerRadius = 40
        kiwi.layer.cornerRadius = 40
        berry.layer.cornerRadius = 40
        berry.imageView?.backgroundColor = UIColor.white
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
        emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height/2
        emailTextfield.clipsToBounds = true
        
        self.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial")
        
        
        
    }
    @IBAction func berryPass(_ sender: UIButton) {
        password = "berry123"
        passLabel.text = " "
        selectButton(sender)
        

    }
    
    @IBAction func kiwiPass(_ sender: UIButton) {
        password = "kiwi123"
        passLabel.text = " "
        selectButton(sender)


    }
    @IBAction func orangePass(_ sender: UIButton) {
        password = "orange123"
        passLabel.text = " "
        selectButton(sender)

    }
    
    @IBAction func lemonPass(_ sender: UIButton) {
        password = "lemon123"
        passLabel.text = " "
        selectButton(sender)

    }
    
    @IBAction func strawberryPass(_ sender: UIButton) {
        password = "strawberry123"
        passLabel.text = " "
        selectButton(sender)

    }
    
    @IBAction func pineapplePass(_ sender: UIButton) {
        password = "pineapple123"
        passLabel.text = " "
        selectButton(sender)

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      validator.validate(self)
          }
  //        func textFieldShouldEndEditing(_ textField:UITextField){
  //
  //            validator.validate(self)
  //        }
  //
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
              validator.validate(self)
              return true
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
          errorLabel?.isHidden = false
        errorLabel?.text = " "
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

    @IBAction func loginAction(_ sender: AnyObject) {
            
        validator.validate(self)

        if password == "" {
            passLabel.text = "لطفًا، اختر صورة 🙁 "
            
        }
  
        if self.emailTextfield.text == "" || self.password == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "تنبيه", message: "لطفًا، يجب تعبئة البريد الالكتروني ورمز المرور ", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "حسنًا", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        
        } else {
           
            Auth.auth().signIn(withEmail: self.emailTextfield.text!, password: self.password) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    //Go to the ProfileViewController if the login is sucessful

                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileScreen")
                  
                    self.present(vc!, animated: true, completion: nil)
                    
                             } else {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                  
                                    switch errorCode {
                                    case.wrongPassword:
                                        let alertController = UIAlertController(title: "تنبيه", message: "لطفًا، تحقق من البريد الالكتروني ورمز المرور", preferredStyle: .alert)
                                        
                                        let defaultAction = UIAlertAction(title: "حسنًا", style: .cancel, handler: nil)
                                        alertController.addAction(defaultAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)
                                        break

                                    case .invalidEmail:
                                        let alertController = UIAlertController(title: "تنبيه", message: "لطفًا، تحقق من البريد الالكتروني", preferredStyle: .alert)
                                        
                                        let defaultAction = UIAlertAction(title: "حسنًا", style: .cancel, handler: nil)
                                        alertController.addAction(defaultAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)
                                        break

                                    case .userNotFound:
                                        let alertController = UIAlertController(title: "تنبيه", message: "هذا البريد الالكتروني غير مسجل لدى لفيف🧁", preferredStyle: .alert)
                                        
                                        let defaultAction = UIAlertAction(title: "حسنًا", style: .cancel, handler: nil)
                                        alertController.addAction(defaultAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)
                                        break
                                        
                                    case .networkError:
                                        let alertController = UIAlertController(title: "تنبيه", message: "فضلًا تحقق من اتصالك بالانترنت", preferredStyle: .alert)
                                        
                                        let defaultAction = UIAlertAction(title: "حسنًا", style: .cancel, handler: nil)
                                        alertController.addAction(defaultAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)
                                        break


                                    @unknown default:
                                        let alertController = UIAlertController(title: "تنبيه", message: "يوجد خطأ بالدخول، حاول مرة اخرى", preferredStyle: .alert)
                                        
                                        let defaultAction = UIAlertAction(title: "حسنًا", style: .cancel, handler: nil)
                                        alertController.addAction(defaultAction)
                                        
                                        self.present(alertController, animated: true, completion: nil)
                                        break
                                    }
                                }
                                 //Tells the user that there is an error and then gets firebase to tell them the error
                                let alertController = UIAlertController(title: "تنبيه", message: "يوجد خطأ بالدخول، حاول مرة اخرى", preferredStyle: .alert)
                                 
                                 let defaultAction = UIAlertAction(title: "حسنًا", style: .cancel, handler: nil)
                                 alertController.addAction(defaultAction)
                                 
                                 self.present(alertController, animated: true, completion: nil)
                             }
                         }
                     }
                 }
     
   
}

