//
//  SignUpCharachterViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit

class SignUpCharachterViewController: UIViewController {
    var email  = ""
    var pass = ""
    var day = ""
    var month = ""
    var year = ""
    var charachter = ""
    
    @IBOutlet weak var charachterImage: UIImageView!
    

    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var girl: UIButton!
    
    @IBOutlet weak var boy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        girl.layer.cornerRadius = 0.5 * girl.bounds.size.width
        girl.clipsToBounds = true
        boy.layer.cornerRadius = 0.5 * boy.bounds.size.width
        boy.clipsToBounds = true
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2

        // Do any additional setup after loading the view.
        self.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! SignUpNameViewController
        destinationVC.pass = pass
        destinationVC.email = email
        destinationVC.day = day
        destinationVC.month  = month
        destinationVC.year = year
        destinationVC.charachter = charachter
    }
    

    @IBAction func next(_ sender: Any) {
        self.performSegue(withIdentifier: "charachterNext", sender: self)
    }
    
    @IBAction func girl(_ sender: Any) {
        charachter = "girl"
        self.view.backgroundColor = .gray
        self.charachterImage.image = UIImage(named: "girl")
        
    }
    
    @IBAction func boy(_ sender: Any) {
        charachter = "girl"
        self.view.backgroundColor = .green
        self.charachterImage.image = UIImage(named: "boy")
        
    }
}
