//
//  InstructionViewController.swift
//  Lafeef
//
//  Created by Mihaf on 17/06/1442 AH.
//

import UIKit

class InstructionViewController: UIViewController {
    
    
    @IBOutlet weak var passImages: UIImageView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
//        passImages.layer.cornerRadius = 80
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }

    @IBAction func dimiss(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
