//
//  AlertViewController.swift
//  Lafeef
//
//  Created by Mihaf on 17/06/1442 AH.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var alertButtonOutlet: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertBody: UILabel!
    var body : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        alertBody.text = body
        
        alertButtonOutlet.layer.cornerRadius = alertButtonOutlet.frame.size.height/2
        alertView.layer.cornerRadius = 20
    }
    

    @IBAction func next(_ sender: Any) {
        self.dismiss(animated: true)
        }

}
