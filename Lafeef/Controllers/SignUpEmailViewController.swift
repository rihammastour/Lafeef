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
    
   
    @IBAction func berryPass(_ sender: Any) {
        password = "berry123"

    }
    
    @IBAction func kiwiPass(_ sender: Any) {
        password = "kiwi123"

    }
    @IBAction func orangePass(_ sender: Any) {
        password = "orange123"

    }
    
    @IBAction func lemonPass(_ sender: Any) {
        password = "lemon123"

    }
    
    @IBAction func strawberryPass(_ sender: Any) {
        password = "strawberry123"

    }
    
    @IBAction func pineapplePass(_ sender: Any) {
        password = "pineapple123"

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
