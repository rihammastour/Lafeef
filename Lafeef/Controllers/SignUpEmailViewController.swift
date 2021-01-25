//
//  SignUpEmailViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit

class SignUpEmailViewController: UIViewController{
    var password : String = ""
  
  @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var lemon: UIButton!
    @IBOutlet weak var strawberry: UIButton!
    @IBOutlet weak var pineapple: UIButton!
    @IBOutlet weak var orange: UIButton!
    @IBOutlet weak var kiwi: UIButton!
    @IBOutlet weak var berry: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.layer.zPosition = -1
        emailTextfield.delegate = self as? UITextFieldDelegate
    
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
        
        self.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial")
    }
    
   
    @IBAction func berryPass(_ sender: UIButton) {
        password = "berry123"
        selectButton(sender)

    }
    
    @IBAction func kiwiPass(_ sender: UIButton) {
        password = "kiwi123"
        selectButton(sender)

    }
    @IBAction func orangePass(_ sender: UIButton) {
        password = "orange123"
        selectButton(sender)

    }
    
    @IBAction func lemonPass(_ sender: UIButton) {
        password = "lemon123"
        selectButton(sender)

    }
    
    @IBAction func strawberryPass(_ sender: UIButton) {
        password = "strawberry123"
        selectButton(sender)

    }
    
    @IBAction func pineapplePass(_ sender: UIButton) {
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
        destinationVC.pass = password
        destinationVC.email = emailTextfield.text ?? ""
     }
    @IBAction func next(_ sender: Any) {
        if password != "" && emailTextfield.text != ""{
            self.performSegue(withIdentifier: "emailNxt", sender: self)
        }
        
    }
  
}
