//
//  loginViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 11/06/1442 AH.
//
import UIKit
import Foundation
class LoginViewController: UIViewController{
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
    @IBOutlet weak var resetPass:UIButton!
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
//        berry.layer.cornerRadius = 40
//        berry.layer.backgroundColor = whiteColor
        berry.layer.cornerRadius = 40
        berry.imageView?.backgroundColor = UIColor.white
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2
        emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height/2
        emailTextfield.clipsToBounds = true
        
        self.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial")
        
        
    }
    
    
   
}

