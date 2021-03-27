//
//  SignUpDOBViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import SwiftValidator

class SignUpDOBViewController: UIViewController, UITextFieldDelegate  {
    
    //MARK:- Proprities
    
    //variables
    var isValidated : Bool  = false
    let alert = AlertService()
    let instructionVC = instruction()
    let validator = Validator()
    let datePicker = UIDatePicker()
    var password = ""
    var progressBar = ProgressBar(stepNum: 1)

    //outlets
    @IBOutlet weak var monthTextfield: UITextField!
    @IBOutlet weak var dayTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextOutlet: UIButton!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthTextfield.delegate = self
        monthTextfield.text = ""
        dayTextfield.delegate = self
        dayTextfield.text = ""
        yearTextfield.delegate = self
        yearTextfield.text = ""
        
        createDatePicker()
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
        
        //buttons shape
        nextOutlet .layer.cornerRadius = nextOutlet.frame.size.height/2
        monthTextfield.layer.cornerRadius = monthTextfield.frame.size.height/2
        monthTextfield.clipsToBounds = true
        dayTextfield.layer.cornerRadius = dayTextfield.frame.size.height/2
        dayTextfield.clipsToBounds = true
        yearTextfield.layer.cornerRadius = yearTextfield.frame.size.height/2
        yearTextfield.clipsToBounds = true
        
        self.view.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial", isFirstTimeInserting: true)
        
        progressBar.setupProgressBarWithoutLastState(view: self.view)
    }
    
    //Datepicker
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
    
    //MARK:- Actions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SignUpCharachterViewController
        destinationVC.password = password
        var month = monthTextfield.text!
        var day = dayTextfield.text!
        if (dayTextfield.text!.count<2){
            day = "٠"+dayTextfield.text!
        }
        if (monthTextfield.text!.count<2){
            month = "٠"+monthTextfield.text!
        }
        
        User.DOB = day+"-"+month+"-"+yearTextfield.text!
     }
    
    @IBAction func next(_ sender: Any) {
        if isValidated {
            self.performSegue(withIdentifier: "DOBNext", sender: self)
        }else{
            errorLabel .text = "لطفَا، تاريخ الميلاد مطلوب"
            self.present(alert.Alert(body:"لطفَا، تاريخ الميلاد مطلوب" ),animated: true)
             
        }
    }
    
    
}

