//
//  SignUpNameViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FirebaseCore
import SwiftValidator

class SignUpNameViewController: UIViewController ,UITextFieldDelegate, ValidationDelegate {
    
    //MARK:- Proprities
    
    //variables
    var isValidated = false
    let alert = AlertService()
    let validator = Validator()
    var password = ""
    var progressBar = ProgressBar(stepNum: 3)
    
    //outlets
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharachterType(charachter: User.sex)
        nameTextfield.delegate = self
        validation()
        styleUI()
    }
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.tintColor = .gray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 
        charachterImage.layer.cornerRadius = charachterImage.frame.size.height/2
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
        nameTextfield.layer.cornerRadius = nameTextfield.frame.size.height/2
        nameTextfield.clipsToBounds = true
        
        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom:0.71 , blueBottom: 0.71, type: "radial", isFirstTimeInserting: true)
        
        progressBar.setupProgressBarWithoutLastState(view: self.view)
    }
    
    //Validation
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
        
        validator.registerField(nameTextfield, rules: [RequiredRule(), ZipCodeRule(regex : "^[ء-ي]+$")])
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
                field.layer.borderWidth = 3.0
            }
            errorLabel?.text = error.errorMessage // works if you added labels
            errorLabel?.isHidden = false
        }
        isValidated = false
    }
    
    func CharachterType(charachter : String ){
        if (charachter == "girl"){
            self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial", isFirstTimeInserting: true)
            self.charachterImage.image = UIImage(named: "croped-girl")
        } else{
            self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial",  isFirstTimeInserting: true)
            self.charachterImage.image =  UIImage(named: "croped-boy")
            
        }
        
    }
    
    //MARK:- Actions
    @IBAction func next(_ sender: Any) {
        validator.validate(self)
        if !isValidated{
            self.present(alert.Alert(body:errorLabel.text!), animated: true)
            
        } else {
            User.name = nameTextfield!.text!
            let signUpManager = FirebaseRequest()
            signUpManager.createUser(email: User.email, password: password, name:User.name, sex:User.sex, DOB:User.DOB) {
                [weak self] (success,error) in
                guard let self = self else { return }
                
                if (success) {
                    self.errorLabel.text = "User was sucessfully created."
                    //Store in local Storage
                    LocalStorageManager.setChild(Child(DOB: User.DOB, currentLevel: 1, email: User.email, money: 0, name: User.name, score: 0, sex: User.sex))
                    
                    //navogation
                    self.transition()
                } else {
                    self.errorLabel.text = error
                }
            }
        }
        
        
    }
    
    func transition(){
        let homeNavigationController =   storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeNavigationController) as? UINavigationController
        
        view.window?.rootViewController = homeNavigationController
        view.window?.makeKeyAndVisible()
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
