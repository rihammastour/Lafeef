//
//  EditProfileViewController.swift
//  Lafeef
//
//  Created by MACBOOKPRO on 3/20/21.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
class EditProfileViewConroller: UIViewController, UITextFieldDelegate {
    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var yearTextfield: UITextField!
    
    @IBOutlet weak var monthTextfield: UITextField!
    @IBOutlet weak var dayTextfield: UITextField!

    @IBOutlet weak var ProfileRectangle: UIButton!
    
    @IBOutlet weak var ImageToChange: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var levelNumLabel: UILabel!
    
    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var ProfilePic: UIImageView!
    
    
    @IBOutlet weak var ChangePasword: UIButton!
    var db: Firestore!
    let year = Calendar.current.component(.year, from: Date())
    let formatter: NumberFormatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.navigationController?.isNavigationBarHidden = true
        
        logOut.layer.cornerRadius = logOut.frame.size.height/2
         ProfileRectangle.layer.cornerRadius = ProfileRectangle.frame.size.height/8
        NameTextField.layer.cornerRadius = NameTextField.frame.size.height/2
        NameTextField.clipsToBounds = true
        monthTextfield.layer.cornerRadius = monthTextfield.frame.size.height/2
        monthTextfield.clipsToBounds = true
        dayTextfield.layer.cornerRadius = dayTextfield.frame.size.height/2
        dayTextfield.clipsToBounds = true
        yearTextfield.layer.cornerRadius = yearTextfield.frame.size.height/2
        yearTextfield.clipsToBounds = true
        
        
        ChangePasword.layer.cornerRadius = ChangePasword.frame.size.height/2
        //Get Child Data
        getChildData()
        
        monthTextfield.delegate = self
        dayTextfield.delegate = self
        yearTextfield.delegate = self
        
        createDatePicker()
        
        

    }
    
    
    // Get child object from local storage
    func getChildData(){
        let child = LocalStorageManager.getChild()
        if child != nil {
            setUIChildInfo(child!)
        }
      
    }
    
    //Set child info
    func setUIChildInfo(_ child:Child){
        self.setName(child.name)
        self.setCurrentLevel(child.currentLevel)
        self.setMoney(child.money)
       self.setImage(child.sex)
        self.setEmail(child.email)
        self.setAge(child.DOB)

    }
    
    //Name
    func setName(_ name:String) {
        NameTextField.placeholder = String(name)
    }
//    //Name
//    func setDay(_ name:String) {
//        dayTextfield.placeholder = String(name)
//    }
//    //Name
//    func setMonth(_ name:String) {
//        monthTextfield.placeholder = String(name)
//    }
//    //Name
//    func setYear(_ name:String) {
//        yearTextfield.placeholder = String(name)
//    }
    
//    func changePic(){
//        if sex == "girl"{
//            ProfilePic.image = UIImage(named: "BoyWithCircle-1")
//        }else{
//            ProfilePic.image = UIImage(named: "GirlWithCircle")        }
//
//    }
    //Level
    func setCurrentLevel(_ level:Int) {
        levelNumLabel.text = String(level)
    }
    
    //Money
    func setMoney(_ money:Float) {
        moneyLabel.text = String(money)
    }
    
    //Email
    func setEmail(_ email:String) {
        emailLabel.text = "البريد الإلكتروني|\(String(email))"
    }
    
    //Image
    func setImage(_ sex:String) {
        if sex != "girl"{
            ProfilePic.image = UIImage(named: "BoyWithCircle")
            ImageToChange.setImage( UIImage.init(named: "GirlWithCircle"), for: .normal)
        }else{
            ProfilePic.image = UIImage(named: "GirlWithCircle")
            ImageToChange.setImage( UIImage.init(named: "BoyWithCircle"), for: .normal)
        }
    }
    
//    func setImageToChange(_ sex:String){
//        if sex != "girl"{
//            ProfilePic.image = UIImage(named: "BoyWithCircle-1")
//        }else{
//            ProfilePic.image = UIImage(named: "GirlWithCircle")        }
//
//    }
    
    //set birthday
    func setAge(_ age:String) {
        // Get range based on the string index.
        let ageYearSub = age.index(age.startIndex, offsetBy: 6)..<age.endIndex
        // Access substring from range.
        print(year)
        let ageYear = age[ageYearSub]
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        let AgeEN = formatter.number(from: String(ageYear))
        let convertAge = Int(AgeEN!)
        let calculateAge = year-convertAge
        print(calculateAge)
        
        yearTextfield.placeholder = age.substring(with: 6..<10)
        monthTextfield.placeholder = age.substring(with: 3..<5)
        dayTextfield.placeholder = age.substring(with: 0..<2)
       // AgeLable.text = "العمر |\(String(calculateAge))"
    }
    
    
    //Datepicker
    @objc func datePickerValueChange(sender:UIDatePicker){
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        yearTextfield.text =  formatter.string(from: components.year! as NSNumber)
        monthTextfield.text = formatter.string(from: components.month! as NSNumber)
        dayTextfield.text = formatter.string(from: components.day! as NSNumber)
//        errorLabel.isHidden = true
//        isValidated = true
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
    
    @objc func doneDatePickerPressed(){
       self.view.endEditing(true)
    }
    
    @objc func cancelDatePickerPressed(){
       self.view.endEditing(true)
        
       yearTextfield.text = ""
       monthTextfield.text = ""
       dayTextfield.text = ""
      // isValidated = false
    }
    @IBAction func changePic(_ sender: Any) {
        
        if (ProfilePic.image == UIImage(named: "BoyWithCircle")){
            ProfilePic.image = UIImage(named: "GirlWithCircle")
    
            ImageToChange.setImage( UIImage.init(named: "BoyWithCircle"), for: .normal)


           // ProfilePic.image = UIImage(named: "GirlWithCircle")
            
        }else{
            ProfilePic.image = UIImage(named: "BoyWithCircle")
            ImageToChange.setImage( UIImage.init(named: "GirlWithCircle"), for: .normal)
        }
        
        
        }
    @IBAction func changeInfo(_ sender: Any) {
        var newName = NameTextField!.text!
        if(!(newName=="")){
        updateName(newName)
        }
        
        var month = monthTextfield.text!
        var day = dayTextfield.text!
        if(!(day=="")){
          
            if (dayTextfield.text!.count<2){
                day = "٠"+dayTextfield.text!
            }
            if (monthTextfield.text!.count<2){
                month = "٠"+monthTextfield.text!
            }
            var newBOD = day+"-"+month+"-"+yearTextfield.text!
            updateBOD(newBOD)
            
        }
       
        var sex = ""
        if (ProfilePic.image == UIImage(named: "BoyWithCircle")){
            sex="boy"
        }else{
            sex="girl"
        }
        updateSex(sex)
        
//        var newImage = NameTextField!.text!
//        updateName(newName)
        }
     
        
        //MARK:- Functions
        
        func getChildMoney(){
            
            let child = LocalStorageManager.getChild()
            if let child = child {
                setMoney(child.money)
            }else{
                
                print("No Child Found")
                //TODO: Alert and back button..
            }
            
        }
    
    func updateName(_ newName:String){
            FirebaseRequest.updateName(newName) { (success, errore) in
                if !success{
                    //Purches won't complated
                  //  self.showAlert(with: "خطأ حدث اثناء اتمام عملية الشراء ، الرجاء اعادة المحاولة لاحقاً")
                    
                }else{
                    self.setName(newName)
                }
            }
        }
    
    func updateBOD(_ newDOB:String){
     
        
            FirebaseRequest.updateDOB(newDOB) { (success, errore) in
                if !success{
                    //Purches won't complated
                  //  self.showAlert(with: "خطأ حدث اثناء اتمام عملية الشراء ، الرجاء اعادة المحاولة لاحقاً")
                    
                }else{
                    self.setAge(newDOB)
                }
            }
        }
    func updateSex(_ newSex:String){
     
        
            FirebaseRequest.updateSex(newSex) { (success, errore) in
                if !success{
                    //Purches won't complated
                  //  self.showAlert(with: "خطأ حدث اثناء اتمام عملية الشراء ، الرجاء اعادة المحاولة لاحقاً")
                    
                }else{
                    self.setImage(newSex)
                }
            }
        }
        
    
       
  

    //اه
}//end class
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
