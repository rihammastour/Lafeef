//
//  SignUpCharachterViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit

class SignUpCharachterViewController: UIViewController {
    
    //MARK:- Proprities
    
    //variables
    var password = ""
    let alert = AlertService()
    var progressBar = ProgressBar(stepNum: 2)
    
    //outlets
    @IBOutlet var charectarView: UIView!
    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var girl: UIButton!
    @IBOutlet var charectarButton: [UIButton]!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var boy: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        boy.isSelected =  true
        User.sex = "boy"
    }
    
    //MARK:- Functions
    
    // Styling UI
    func styleUI(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.tintColor = .gray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
 
        girl.layer.cornerRadius = 0.5 * girl.bounds.size.width
        girl.clipsToBounds = true
        boy.layer.cornerRadius = 0.5 * boy.bounds.size.width
        boy.clipsToBounds = true
        boy.layer.borderWidth = 3.5
        boy.layer.borderColor =  UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2

        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial", isFirstTimeInserting: true)
        progressBar.setupProgressBarWithoutLastState(view: self.view)
    }
    
    //Button Selection
    func selectButton(_ sender: UIButton){
        //deselect all buttons first
        deselectButton()
        //select one button seconed
        sender.layer.borderWidth = 3.5
        sender.layer.borderColor =  UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00).cgColor
    }
    
    func deselectButton(){
        charectarButton.forEach({$0.layer.borderWidth = 0
                                $0.layer.borderColor = .none})
    }
    
    //MARK:- Actions
    @IBAction func girl(_ sender: UIButton) {
        User.sex = "girl"
        selectButton(sender)
        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial", isFirstTimeInserting: false)
        self.charachterImage.image = UIImage(named: "girl")
        errorLabel.isHidden = true
        
    }
    @IBAction func boy(_ sender: UIButton) {
        User.sex = "boy"
        selectButton(sender)
        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial",  isFirstTimeInserting: false)
        self.charachterImage.image =  UIImage(named: "boy")
        errorLabel.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! SignUpNameViewController
        destinationVC.password = password
    }
    

    @IBAction func next(_ sender: Any) {
        if User.sex != ""{
                self.performSegue(withIdentifier: "charachterNext", sender: self)
            }
                else{
                    errorLabel.text = "لطفًا، اختر شخصيتك"
                    self.present(alert.Alert(body:"لطفًا، اختر شخصيتك", isSuccess: false),animated: true)
        }
    }
    
  
}
