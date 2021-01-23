//
//  SignUpDOBViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit

class SignUpDOBViewController: UIViewController {
    var email = ""
    var pass = ""
    @IBOutlet weak var monthTextfield: UITextField!
    @IBOutlet weak var dayTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.layer.zPosition = -1
        let back = UIImage(named: "back")// to replace back button
        self.navigationController?.navigationBar.backIndicatorImage = back
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = back
        monthTextfield.delegate = self as? UITextFieldDelegate
        monthTextfield.text = ""
        dayTextfield.delegate = self as? UITextFieldDelegate
        dayTextfield.text = ""
        yearTextfield.delegate = self as? UITextFieldDelegate
        yearTextfield.text = ""
       
        
        
        nextOutlet .layer.cornerRadius = nextOutlet.frame.size.height/2
        monthTextfield.layer.cornerRadius = monthTextfield.frame.size.height/2
        monthTextfield.clipsToBounds = true
        dayTextfield.layer.cornerRadius = dayTextfield.frame.size.height/2
        dayTextfield.clipsToBounds = true
        yearTextfield.layer.cornerRadius = yearTextfield.frame.size.height/2
        yearTextfield.clipsToBounds = true
   

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

         let destinationVC = segue.destination as! SignUpCharachterViewController
        destinationVC.pass = pass
        destinationVC.email = email
        destinationVC.day = dayTextfield.text ?? ""
        destinationVC .month  = monthTextfield.text ?? ""
        destinationVC.year = yearTextfield.text ?? ""
   
     }
    
    @IBAction func next(_ sender: Any) {
        if monthTextfield.text != ""  && yearTextfield.text != "" && dayTextfield.text != ""  {
            self.performSegue(withIdentifier: "DOBNext", sender: self)
            
            //validation for future year
        }
    
    }
    

}
