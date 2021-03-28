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
class EditProfileViewConroller: UIViewController {
    
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
        
        //Get Child Data
        getChildData()
        

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
            ProfilePic.image = UIImage(named: "BoyWithCircle-1")
        }else{
            ProfilePic.image = UIImage(named: "GirlWithCircle")        }
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
        let ageYearSub = age.index(age.startIndex, offsetBy: 4)..<age.endIndex
        // Access substring from range.
        print(year)
        let ageYear = age[ageYearSub]
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
        let AgeEN = formatter.number(from: String(ageYear))
        let convertAge = Int(AgeEN!)
        let calculateAge = year-convertAge
        print(calculateAge)
        
        yearTextfield.placeholder = age.substring(with: 4..<8)
        monthTextfield.placeholder = age.substring(with: 2..<3)
        dayTextfield.placeholder = age.substring(with: 0..<1)
       // AgeLable.text = "العمر |\(String(calculateAge))"
    }
    @IBAction func changePic(_ sender: Any) {
        
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
    
    func buyItem(_ cost:Float){
        
//        FirebaseRequest.updateMoney(4.6)
        
    }
    //اه
}
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
