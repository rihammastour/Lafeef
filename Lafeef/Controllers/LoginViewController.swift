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
import CodableFirebase
//import FirebaseAuthUI
class LoginViewController: UIViewController, UITextFieldDelegate, ValidationDelegate, FUIAuthDelegate{
    var password : String = ""
    let validator = Validator()
    let alert = AlertService()
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
        
        self.view.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial", isFirstTimeInserting: true)
        
        
        
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
    
    func validation(){
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
    }
    //---------------------------------------- validation
    func validationSuccessful()  {
        print("Validation Success!")
        errorLabel?.isHidden = true
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
            
            if error.errorMessage == "This field is required"{
                errorLabel?.text = "لطفًا، البريد الإلكتروني مطلوب "
            }
            if error.errorMessage == "Must be a valid email address"{
                errorLabel?.text = "لطفًا، أدخل البريد الإلكتروني بصيغة صحيحة"
            }
            errorLabel?.isHidden = false
        }
        isValidated = false
    }
    
    func login(with email: String, pass: String) -> Bool{
        var isSuccess = false
        print("isFieldValidated", isFieldValidated())
        if isFieldValidated() {
            FirebaseRequest.login(email: email, password: pass) { [self] (user, error) in

                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    //Go to the ProfileViewController if the login is sucessful
                    
                    let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeNavigationController) as! UINavigationController
                    view.window?.rootViewController = controller
                    view.window?.makeKeyAndVisible()
                    isSuccess = true
        
                } else {
                    isSuccess = false
                    print("error")
                    if let errorCode = AuthErrorCode(rawValue: error!._code) {
                        
                        switch errorCode {
                        
                        case .invalidEmail:
                            self.present(alert.Alert(body: "لطفًا، تحقق من البريد الالكتروني", isSuccess: false), animated: true)
                            break
                            
                        case .userNotFound:
                            self.present(alert.Alert(body: "هذا البريد الالكتروني غير مسجل لدى لفيف🧁",isSuccess: false), animated: true)
                            break
                        case .networkError:
                            self.present(alert.Alert(body: "فضلًا تحقق من اتصالك بالانترنت", isSuccess: false), animated: true)
                            break
                            
                        @unknown default:
                            self.present(alert.Alert(body: "يوجد خطأ بالدخول، حاول مرة اخرى", isSuccess: false), animated: true)
                            
                            break
                        }
                    }
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    self.present(alert.Alert(body: "يوجد خطأ بالدخول، حاول مرة اخرى", isSuccess: false), animated: true)
                    
                }

            }
  
        }
        print (isSuccess)
        return isSuccess
    }
    
    func isFieldValidated() -> Bool{
        validator.validate(self)
        if  password == "" && !isValidated{
            passLabel.text = "لطفًا، اختر صورة"
            self.present(alert.Alert(body: "لطفًا، جميع الحقول مطلوبة", isSuccess:false), animated: true)
            return false
        }else if emailTextfield.text == "" {
            
            self.present(alert.Alert(body:"لطفًا، البريد الإلكتروني مطلوب", isSuccess: false), animated: true)
            return false
        }else if !isValidated{
            self.present(alert.Alert(body:errorLabel.text!, isSuccess: false), animated: true)
            return false
        }
        else if password == "" { // email error
            passLabel.text = "لطفًا،اختر صورة"
            self.present(alert.Alert(body: "لطفًا، اختر صورة ", isSuccess: false), animated: true)
            return false
        }
        return true
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
        login(with: self.emailTextfield.text!, pass: self.password)
        
    }
    
    
}

