//
//  SignUpNameViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit

class SignUpNameViewController: UIViewController {
    var email  = ""
    var pass = ""
    var day = ""
    var month = ""
    var year = ""
     var charachter = ""
    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextfield.delegate = self as? UITextFieldDelegate
        charachterImage.layer.cornerRadius = charachterImage.frame.size.height/2
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
        nameTextfield.layer.cornerRadius = nameTextfield.frame.size.height/2
        nameTextfield.clipsToBounds = true

        self.setGradientBackground(redTop: 0.96, greenTop: 0.71, blueTop: 0.71, redBottom: 1, greenBottom: 1, blueBottom: 1, type: "radial")
    }
    

   
    @IBAction func next(_ sender: Any) {
    }
    
}
