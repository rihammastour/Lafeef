//
//  UpdatePasswordViewController.swift
//  Lafeef
//
//  Created by Riham Mastour on 10/08/1442 AH.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    
    
    //MARK:- Proprities
    
    //variables
    var oldPassword = ""
    var newPassword = ""
    let alert = AlertService()
    
    //outlets
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var passwordGuid: UILabel!
    
    @IBOutlet weak var oldLemon: UIButton!
    @IBOutlet weak var oldStrawberry: UIButton!
    @IBOutlet weak var oldPineapple: UIButton!
    @IBOutlet weak var oldOrange: UIButton!
    @IBOutlet weak var oldKiwi: UIButton!
    @IBOutlet weak var oldBerry: UIButton!
    @IBOutlet var deSelectedOldButton: [UIButton]!
    
    @IBOutlet weak var newLemon: UIButton!
    @IBOutlet weak var newStrawberry: UIButton!
    @IBOutlet weak var newPineapple: UIButton!
    @IBOutlet weak var newOrange: UIButton!
    @IBOutlet weak var newKiwi: UIButton!
    @IBOutlet weak var newBerry: UIButton!
    @IBOutlet var deSelectedNewButton: [UIButton]!
    
    @IBOutlet weak var updateOutlet: UIButton!
    
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        styleUI()
    }
    
    //MARK:- Functions
    // Styling UI
    func styleUI(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.tintColor = .gray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        //buttons shape
        oldLemon.layer.cornerRadius = 25
        oldPineapple.layer.cornerRadius = 25
        oldStrawberry.layer.cornerRadius = 25
        oldOrange.layer.cornerRadius = 25
        oldKiwi.layer.cornerRadius = 25
        oldBerry.layer.cornerRadius = 25
        newLemon.layer.cornerRadius = 25
        newPineapple.layer.cornerRadius = 25
        newStrawberry.layer.cornerRadius = 25
        newOrange.layer.cornerRadius = 25
        newKiwi.layer.cornerRadius = 25
        newBerry.layer.cornerRadius = 25
        updateOutlet.layer.cornerRadius = updateOutlet.frame.size.height/2
        
        self.view.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial", isFirstTimeInserting: true)
        
        passLabel.isHidden = true
    }
    
    //Button Selection
    func selectButton(_ sender: UIButton, isOld:Bool){
        //deselect all buttons first
        if isOld {
            deselectOldButton()
        } else {
            deselectNewButton()
        }
        //select one button seconed
        sender.layer.borderWidth = 3.5
        sender.layer.borderColor =  UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
    }
    
    func deselectOldButton(){
        deSelectedOldButton.forEach({$0.layer.borderWidth = 0
                                        $0.layer.borderColor = .none})
    }
    
    func deselectNewButton(){
        deSelectedNewButton.forEach({$0.layer.borderWidth = 0
                                        $0.layer.borderColor = .none})
    }
    
    
    func updatePassword() -> String{
        if oldPassword != ""  {
            if newPassword != "" {
                if newPassword != oldPassword {
                    FirebaseRequest.updatePassword(oldPassword: oldPassword, newPassword: newPassword) { (success, err) in
                        if success {
                            self.present(self.alert.Alert(body:"تم تغيير رمز مرورك بنجاح 🎉", isSuccess: true ), animated: true){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    
                                    self.back()
                                }
                            }
                            
                        } else {
                            //error happend while perform update password
                            self.present(self.alert.Alert(body:err, isSuccess: false), animated: true)
                        }
                    }
                } else{
                    // new password as old password
                    let body = "اختر رمز مرور جديد"
                    self.present(self.alert.Alert(body:body, isSuccess: false), animated: true)
                    return body
                }
            } else {
                // new password nil
                let body = "هلّا أدخلت رمز مرورك الجديد؟"
                self.present(self.alert.Alert(body: body, isSuccess: false), animated: true)
                return body
            }
        } else {
            // old password nil
            let body = "هلّا أدخلت رمز مرورك السابق؟"
            self.present(self.alert.Alert(body:body, isSuccess: false), animated: true)
            return body
        }
        return "تم تغيير رمز مرورك بنجاح 🎉"
    }
    
    //MARK:- Actions
    @IBAction func oldBerryPass(_ sender: UIButton) {
        passLabel.isHidden = true
        oldPassword = "berry123"
        selectButton(sender, isOld: true)
    }
    
    @IBAction func oldKiwiPass(_ sender: UIButton) {
        passLabel.isHidden = true
        oldPassword = "kiwi123"
        selectButton(sender, isOld: true)
    }
    @IBAction func oldOrangePass(_ sender: UIButton) {
        passLabel.isHidden = true
        oldPassword = "orange123"
        selectButton(sender, isOld: true)
    }
    
    @IBAction func oldLemonPass(_ sender: UIButton) {
        passLabel.isHidden = true
        oldPassword = "lemon123"
        selectButton(sender, isOld: true)
    }
    
    @IBAction func oldStrawberryPass(_ sender: UIButton) {
        passLabel.isHidden = true
        oldPassword = "strawberry123"
        selectButton(sender, isOld: true)
    }
    
    @IBAction func oldPineapplePass(_ sender: UIButton) {
        passLabel.isHidden = true
        oldPassword = "pineapple123"
        selectButton(sender, isOld: true)
    }
    
    @IBAction func newBerryPass(_ sender: UIButton) {
        passLabel.isHidden = true
        newPassword = "berry123"
        selectButton(sender, isOld: false)
    }
    
    @IBAction func newKiwiPass(_ sender: UIButton) {
        passLabel.isHidden = true
        newPassword = "kiwi123"
        selectButton(sender, isOld: false)
    }
    @IBAction func newOrangePass(_ sender: UIButton) {
        passLabel.isHidden = true
        newPassword = "orange123"
        selectButton(sender, isOld: false)
    }
    
    @IBAction func newLemonPass(_ sender: UIButton) {
        passLabel.isHidden = true
        newPassword = "lemon123"
        selectButton(sender, isOld: false)
    }
    
    @IBAction func newStrawberryPass(_ sender: UIButton) {
        passLabel.isHidden = true
        newPassword = "strawberry123"
        selectButton(sender, isOld: false)
    }
    
    @IBAction func newPineapplePass(_ sender: UIButton) {
        passLabel.isHidden = true
        newPassword = "pineapple123"
        selectButton(sender, isOld: false)
    }
    
    @IBAction func updatePassword(_ sender: Any) {
        updatePassword()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        back()
    }
    
    func back(){
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
