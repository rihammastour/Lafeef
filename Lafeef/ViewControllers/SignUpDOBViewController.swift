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
  
    @IBOutlet weak var emaillabel: UILabel!
    
    @IBOutlet weak var passlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        emaillabel.text = email
        passlabel.text = pass

        // Do any additional setup after loading the view.
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        let destinationVC = segue.destination as! SignUpDOBViewController
//        destinationVC.Text.text = text
//    }
//

}
