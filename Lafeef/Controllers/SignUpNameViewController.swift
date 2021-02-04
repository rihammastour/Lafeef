//
//  SignUpNameViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FirebaseCore
import SwiftValidator
import FlexibleSteppedProgressBar

class SignUpNameViewController: UIViewController, FlexibleSteppedProgressBarDelegate ,UITextFieldDelegate, ValidationDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    var isValidated = false
    let alert = AlertService()
    let validator = Validator()
    var password = ""
//    var signUpManger = SignUpViewController(stepNum: 3)
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!

    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.tintColor = .gray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 
        
         CharachterType(charachter: Child.sex)
         nameTextfield.delegate = self
        validation()
         charachterImage.layer.cornerRadius = charachterImage.frame.size.height/2
         nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
         nameTextfield.layer.cornerRadius = nameTextfield.frame.size.height/2
         nameTextfield.clipsToBounds = true

        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom:0.71 , blueBottom: 0.71, type: "radial", isFirstTimeInserting: true)
        
        self.setupProgressBarWithoutLastState()
    }
    //---------------------------------------- progress bar
    func setupProgressBarWithoutLastState() {
        progressBarWithoutLastState = FlexibleSteppedProgressBar()
        progressBarWithoutLastState.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressBarWithoutLastState)
        
        // iOS9+ auto layout code
        let horizontalConstraint = progressBarWithoutLastState.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let verticalConstraint = progressBarWithoutLastState.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: -30
        )
        let widthConstraint = progressBarWithoutLastState.widthAnchor.constraint(equalToConstant: 450)
        let heightConstraint = progressBarWithoutLastState.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        // Customise the progress bar here
        let backgroundColor = UIColor(red:0.96, green: 0.96, blue: 0.91, alpha: 1.0)
        let progressColor = UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00)
        let textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
        progressBarWithoutLastState.numberOfPoints = 4
        progressBarWithoutLastState.lineHeight = 3
        progressBarWithoutLastState.radius = 20
        progressBarWithoutLastState.progressRadius = 25
        progressBarWithoutLastState.progressLineHeight = 3
        progressBarWithoutLastState.delegate = self
        progressBarWithoutLastState.selectedBackgoundColor = progressColor
        progressBarWithoutLastState.backgroundShapeColor = backgroundColor
        progressBarWithoutLastState.selectedOuterCircleStrokeColor = progressColor
        progressBarWithoutLastState.currentSelectedCenterColor = progressColor
        progressBarWithoutLastState.stepTextColor = textColorHere
        progressBarWithoutLastState.currentSelectedTextColor = progressColor
        
        progressBarWithoutLastState.currentIndex = 3
        
    }

    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        if position == FlexibleSteppedProgressBarTextLocation.center {
            switch index {
                
            case 0: return ""
            case 1: return ""
            case 2: return ""
            case 3: return ""
            default: return "Date"
                
            }
        }
    return ""
    }
//--------------------------------------- validation
    func validation(){
        //validation
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
            print("error")
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validator.validate(self)
        }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            validator.validate(self)
            return true
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
      
    @IBAction func next(_ sender: Any) {
        validator.validate(self)
        if !isValidated{
           self.present(alert.Alert(body:errorLabel.text!), animated: true)
           
        } else {
            Child.name = nameTextfield!.text! 
            let signUpManager = FirebaseAuthManager()
            signUpManager.createUser(email: Child.email, password: password, name:Child.name, sex:Child.sex, DOB:Child.DOB) {
                       [weak self] (success,error) in
                             guard let self = self else { return }
                            
                             if (success) {
                               self.errorLabel.text = "User was sucessfully created."
                                //navogation
                                self.transition()
                             } else {
                               self.errorLabel.text = error
                    }
             }
        }
     

    }
    
    func transition(){
        let homeViewController =   storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
          
          view.window?.rootViewController = homeViewController
          
          view.window?.makeKeyAndVisible()
    }
       
       
   }
