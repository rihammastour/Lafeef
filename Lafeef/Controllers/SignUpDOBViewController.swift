//
//  SignUpDOBViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import SwiftValidator
import FlexibleSteppedProgressBar

class SignUpDOBViewController: UIViewController, FlexibleSteppedProgressBarDelegate, UITextFieldDelegate  {
    var isValidated : Bool  = false
    let alert = AlertService()
    let instructionVC = instruction()
    let validator = Validator()
    let datePicker = UIDatePicker()
    var password = ""
//    var signUpManger = SignUpViewController(stepNum: 1)
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!

    @IBOutlet weak var monthTextfield: UITextField!
    @IBOutlet weak var dayTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createDatePicker()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.tintColor = .gray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       
        monthTextfield.delegate = self
        monthTextfield.text = ""
        dayTextfield.delegate = self
        dayTextfield.text = ""
        yearTextfield.delegate = self
        yearTextfield.text = ""
       
        nextOutlet .layer.cornerRadius = nextOutlet.frame.size.height/2
        monthTextfield.layer.cornerRadius = monthTextfield.frame.size.height/2
        monthTextfield.clipsToBounds = true
        dayTextfield.layer.cornerRadius = dayTextfield.frame.size.height/2
        dayTextfield.clipsToBounds = true
        yearTextfield.layer.cornerRadius = yearTextfield.frame.size.height/2
        yearTextfield.clipsToBounds = true
        
        self.view.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial", isFirstTimeInserting: true)
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
        
        progressBarWithoutLastState.currentIndex = 1
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destinationVC = segue.destination as! SignUpCharachterViewController
        destinationVC.password = password
        User.DOB = dayTextfield.text!+"-"+monthTextfield.text!+"-"+yearTextfield.text!
     }
    
    @IBAction func next(_ sender: Any) {
        
        if isValidated {
            self.performSegue(withIdentifier: "DOBNext", sender: self)
        }else{
            errorLabel .text = "لطفَا، تاريخ الميلاد مطلوب"
            self.present(alert.Alert(body:"لطفَا، تاريخ الميلاد مطلوب" ),animated: true)
             
        }
    }
         @objc func datePickerValueChange(sender:UIDatePicker){
         
             let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
           
         
            let formatter: NumberFormatter = NumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        
            yearTextfield.text =  formatter.string(from: components.year! as NSNumber)
            monthTextfield.text = formatter.string(from: components.month! as NSNumber)
            dayTextfield.text = formatter.string(from: components.day! as NSNumber)
            errorLabel.isHidden = true
            isValidated = true
      
          
         }
         func createDatePicker(){
          
            datePicker.locale = Locale(identifier: "ar")
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
            datePicker.semanticContentAttribute = .forceRightToLeft
            datePicker.subviews.first?.semanticContentAttribute = .forceRightToLeft
            datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())
            datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
            datePicker.addTarget(self, action:#selector( datePickerValueChange(sender:)), for: UIControl.Event.valueChanged)
             let toolBar = UIToolbar()
             toolBar.sizeToFit()
             toolBar.barStyle = UIBarStyle.default
                toolBar.isTranslucent = true
                toolBar.tintColor = UIColor.black
                toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "تم", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneDatePickerPressed))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            
            let cancelButton = UIBarButtonItem(title: "إلغاء", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePickerPressed))

            toolBar.setItems([ cancelButton, spaceButton,doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
        

             yearTextfield.inputAccessoryView = toolBar
             monthTextfield.inputAccessoryView = toolBar
             dayTextfield.inputAccessoryView = toolBar
             yearTextfield.inputView = datePicker
             monthTextfield.inputView = datePicker
             dayTextfield.inputView = datePicker
         
     }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @objc func doneDatePickerPressed(){
        self.view.endEditing(true)
    }
    @objc func cancelDatePickerPressed(){
        self.view.endEditing(true)
        yearTextfield.text = ""
        monthTextfield.text = ""
        dayTextfield.text = ""
        isValidated = false
    }
    
     }

