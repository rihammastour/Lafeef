//
//  SignUpEmailViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import SwiftValidator
import FirebaseAuth

class SignUpEmailViewController: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    //MARK:- Proprities
    
    //variables
    var isValidated = false
    let alert = AlertService()
    let instructionVC = instruction()
    let validator = Validator()
    var password = ""
    var progressBar = ProgressBar(stepNum: 0)
    
    //outlets
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var passwordGuid: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var lemon: UIButton!
    @IBOutlet weak var strawberry: UIButton!
    @IBOutlet weak var pineapple: UIButton!
    @IBOutlet weak var orange: UIButton!
    @IBOutlet weak var kiwi: UIButton!
    @IBOutlet weak var berry: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet var deSelectedButton: [UIButton]!

    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.delegate = self
        
        validation()
        styleUI()
        
        Timer.scheduledTimer(timeInterval:0.5 , target: self, selector: #selector(self.presentInstruction), userInfo: nil, repeats: false)
    }
    
    //MARK:- Functions
    @objc func presentInstruction(){
         self.present( instructionVC.Instruction(), animated: true)
     }
    
    // Styling UI
    func styleUI(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.tintColor = .gray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        //buttons shape
        logo.layer.zPosition = 2
        lemon.layer.cornerRadius = 40
        pineapple.layer.cornerRadius = 40
        strawberry.layer.cornerRadius = 40
        orange.layer.cornerRadius = 40
        kiwi.layer.cornerRadius = 40
        berry.layer.cornerRadius = 40
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
        emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height/2
        emailTextfield.clipsToBounds = true
        
        self.view.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial", isFirstTimeInserting: true)
        
        progressBar.setupProgressBarWithoutLastState(view: self.view)
    }
    
    //Button Selection
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
    
    // validation
    func validation(){
        validator.styleTransformers(success:{ (validationRule) -> Void in
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
                                   
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
                textField.layer.borderWidth = 3
            } else if let textField = validationRule.field as? UITextView {
                textField.layer.borderColor = UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
                textField.layer.borderWidth = 3
                
            }
        }, error:{ (validationError) -> Void in
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 3
            } else if let textField = validationError.field as? UITextView {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 3
            }
        })
                        
        validator.registerField(emailTextfield, rules: [RequiredRule(), EmailRule()])
    }
    
    func validationSuccessful() {
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

    
    func alertValidation()  {
         if  password == "" && !isValidated{
                passLabel.text = "لطفًا، اختر صورة"
                        self.present(alert.Alert(body: "لطفًا، جميع الحقول مطلوبة"), animated: true)
             }else if emailTextfield.text == "" {
                        
                        self.present(alert.Alert(body:"لطفًا، البريد الإلكتروني مطلوب"), animated: true)
                        
             }else if !isValidated{
                self.present(alert.Alert(body:errorLabel.text!), animated: true)
                
             }
                        else if password == "" { // email error
                        passLabel.text = "لطفًا،اختر صورة"
                        self.present(alert.Alert(body: "لطفًا، اختر صورة "), animated: true)
                      
                    }else{
                        FirebaseRequest.Register(email: emailTextfield.text!, password: password) { (sucess, error) in
                         if error == nil{
                         
                         self.performSegue(withIdentifier: "emailNxt", sender: self)
                     }else{
                        print(error?.localizedDescription)
                         if let errorCode = AuthErrorCode(rawValue: error!._code) {
                           
                             switch errorCode {
                             case .emailAlreadyInUse:
                             self.present(self.alert.Alert(body: "لطفًا، البريد مستخدم من قبل"), animated: true)
                             break
                             
                         

                             case .invalidEmail:
                                 self.present(self.alert.Alert(body: "لطفًا، تحقق من البريد الالكتروني"), animated: true)
                      
                              
                                 break
                             case .networkError:
                                 self.present(self.alert.Alert(body: "فضلًا تحقق من اتصالك بالانترنت"), animated: true)
                                 
                       
                                 break


                             @unknown default:
                                 self.present(self.alert.Alert(body: "يوجد خطأ بإنشاء الحساب ، حاول مرة اخرى"), animated: true)
                                
                                 break
                             }
                         }
                          //Tells the user that there is an error and then gets firebase to tell them the error
                         self.present(self.alert.Alert(body: "يوجد خطأ بالدخول، حاول مرة اخرى"), animated: true)
                    
                      }
                  }
              }
       
                      
     }
    
    //MARK:- Actions
    @IBAction func berryPass(_ sender: UIButton) {
        validator.validate(self)
        passLabel.isHidden = true
        password = "berry123"
            selectButton(sender)
    }
    
    @IBAction func kiwiPass(_ sender: UIButton) {
        validator.validate(self)
        passLabel.isHidden = true
        password = "kiwi123"
            selectButton(sender)
    }
    @IBAction func orangePass(_ sender: UIButton) {
        validator.validate(self)
        passLabel.isHidden = true
        password = "orange123"
            selectButton(sender)
    }
    
    @IBAction func lemonPass(_ sender: UIButton) {
        validator.validate(self)
        passLabel.isHidden = true
        password = "lemon123"
            selectButton(sender)
    }
    
    @IBAction func strawberryPass(_ sender: UIButton) {
        validator.validate(self)
        passLabel.isHidden = true
        password = "strawberry123"
            selectButton(sender)
    }
    
    @IBAction func pineapplePass(_ sender: UIButton) {
        validator.validate(self)
        passLabel.isHidden = true
        password = "pineapple123"
            selectButton(sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "emailNxt") {
             let destinationVC = segue.destination as! SignUpDOBViewController
             destinationVC.password =  password
             User.email = emailTextfield?.text ?? ""
        }

    }

    @IBAction func next(_ sender: Any) {
        validator.validate(self)
        alertValidation()
    }
    
    //MARK:- Delegate Handling
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validator.validate(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            validator.validate(self)
            return true
    }
    
}

