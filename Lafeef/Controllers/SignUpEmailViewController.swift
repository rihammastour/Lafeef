//
//  SignUpEmailViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import SwiftValidator
import MaterialShowcase
import FlexibleSteppedProgressBar

class SignUpEmailViewController: UIViewController, FlexibleSteppedProgressBarDelegate, ValidationDelegate, UITextFieldDelegate {
    var isValidated = false
    let alert = AlertService()
    let instructionVC = instruction()
    let validator = Validator()
    var password = ""
//    var signUpManger = SignUpViewController(stepNum: 0)
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!

    
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
 

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.delegate = self
        validation()
        
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
        

        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.presentInstruction), userInfo: nil, repeats: false)
        self.setupProgressBarWithoutLastState()
  
    }

    @objc func presentInstruction(){
         self.present( instructionVC.Instruction(), animated: true)
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
        
        progressBarWithoutLastState.currentIndex = 0
        
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
    //---------------------------------------- validation
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destinationVC = segue.destination as! SignUpDOBViewController
        destinationVC.password =  password
        User.email = emailTextfield?.text ?? ""

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
                       self.performSegue(withIdentifier: "emailNxt", sender: self)
                   }
    }
    @IBAction func next(_ sender: Any) {
        validator.validate(self)
        alertValidation()

}
    
    
}

