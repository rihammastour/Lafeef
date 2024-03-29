//
//  SignUpNameViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FirebaseCore
import SwiftValidator
import FirebaseAuth

class SignUpNameViewController: UIViewController ,UITextFieldDelegate, ValidationDelegate {
    
    //MARK:- Proprities
    
    //variables
    var isValidated = false
    let alert = AlertService()
    let validator = Validator()
    var password = ""
    var progressBar = ProgressBar(stepNum: 3)
    var userId = ""
    var user = User(DOB: "", email: "", name: "", sex: "")
    
    //outlets
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharachterType(charachter: user.sex)
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
            if error.errorMessage == "This field is required"{
                errorLabel?.text = "لطفًا، الاسم مطلوب "
            }
            else if error.errorMessage == "Enter a valid 5 digit zipcode"||error.errorMessage == "Invalid Regular Expression"{
                errorLabel?.text = "لطفًا، أدخل اسمك الأول باللغة العربية "
            }// works if you added labels
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
    
    func signup(email: String, name: String, password: String, sex: String, DOB: String){

        self.userId =  FirebaseRequest.getUserId() ?? ""
        
        FirebaseRequest.createUser(id: self.userId,email: email, password: password, name:name, sex:sex, DOB:DOB) {
            [weak self] (success,error) in
            guard let self = self else { return }
            
            if (success) {
                print("success inside")
                self.isValidated = true
                self.transition()
            } else {
                print("error inside")
                if let errorCode = AuthErrorCode(rawValue: error!._code){
                    
                    switch errorCode {
                    case .invalidEmail:
                        self.present(self.alert.Alert(body: "لطفًا، تحقق من البريد الالكتروني", isSuccess: false), animated: true)
                        self.isValidated = false
                        break
                    case .networkError:
                        self.present(self.alert.Alert(body: "فضلًا تحقق من اتصالك بالانترنت",isSuccess: false), animated: true)
                        self.isValidated = false
                        break
                    @unknown default:
                        self.present(self.alert.Alert(body: "يوجد خطأ بإنشاء الحساب ، حاول مرة اخرى",isSuccess: false), animated: true)
                        self.isValidated = false
                        
                        break
                    }
                }
                //Tells the user that there is an error and then gets firebase to tell them the error
                self.present(self.alert.Alert(body: "يوجد خطأ بالدخول، حاول مرة اخرى", isSuccess: false), animated: true)
                
            }
        }
    }
    //MARK:- Actions
    @IBAction func next(_ sender: Any) {
        validator.validate(self)
        if !isValidated{
            self.present(alert.Alert(body:errorLabel.text!, isSuccess: false), animated: true)
            
        } else {
            user.name = nameTextfield!.text!
            print("signup success")
            signup(email: user.email, name: user.name, password: password, sex: user.sex, DOB: user.DOB)
        }
    }
    
    
    func transition(){
        adddefaultReport()
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeNavigationController) as! UINavigationController
        view.window?.rootViewController = controller
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
    
    func adddefaultReport(){
        var  levelTwocount = 0
        var  levelFourCount = 0
        let defaults = UserDefaults.standard
        defaults.set(levelTwocount, forKey: "levelTwoCount")
        defaults.set(levelFourCount, forKey: "levelFourCount")
        
        let ReportData = LevelReportData(levelNum:"1", collectedMoney: 0, collectedScore: 0, isPassed:false)
        var array = [LevelReportData]()
        
        array.append(ReportData)
        let completedLevel = CompletedLevel(reportData: array)
        
        
        FirebaseRequest.passCompletedLevelData(childID:FirebaseRequest.getUserId()! , reports: completedLevel) { (success, err) in
            if (err != nil){
                
                print("success")
            } else{
                print("error")
            }
        }
        
    }
    
    
    
}
