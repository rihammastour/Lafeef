//
//  SignUpCharachterViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FlexibleSteppedProgressBar

class SignUpCharachterViewController: UIViewController, FlexibleSteppedProgressBarDelegate {
    var childInfo = Child()
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!
    let alert = AlertService()
    
    @IBOutlet var charectarView: UIView!
    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var girl: UIButton!
    @IBOutlet var charectarButton: [UIButton]!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var boy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        // Do any additional setup after loading the view.
        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial", isFirstTimeInserting: true)
        
        self.setupProgressBarWithoutLastState()
        
    }

    //---------------------------------------- progress bar
    func setupProgressBarWithoutLastState() {
        progressBarWithoutLastState = FlexibleSteppedProgressBar()
        progressBarWithoutLastState.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressBarWithoutLastState)
        
        // iOS9+ auto layout code
        let horizontalConstraint = progressBarWithoutLastState.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let verticalConstraint = progressBarWithoutLastState.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: -30
        )
        let widthConstraint = progressBarWithoutLastState.widthAnchor.constraint(equalToConstant: 450)
        let heightConstraint = progressBarWithoutLastState.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        // Customise the progress bar here
        let backgroundColor = UIColor(red:0.96, green: 0.96, blue: 0.91, alpha: 1.0)
        let progressColor = UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00)
        let textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
        progressBarWithoutLastState.numberOfPoints = 4
        progressBarWithoutLastState.lineHeight = 3
        progressBarWithoutLastState.radius = 20
        progressBarWithoutLastState.progressRadius = 25
        progressBarWithoutLastState.progressLineHeight = 3
        progressBarWithoutLastState.delegate = self
        progressBarWithoutLastState.selectedBackgoundColor = progressColor
        progressBarWithoutLastState.backgroundShapeColor = backgroundColor
        progressBarWithoutLastState.selectedOuterCircleStrokeColor = progressColor
        progressBarWithoutLastState.currentSelectedCenterColor = progressColor
        progressBarWithoutLastState.stepTextColor = textColorHere
        progressBarWithoutLastState.currentSelectedTextColor = progressColor
        
        progressBarWithoutLastState.currentIndex = 2
        
    }

    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                     textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        if position == FlexibleSteppedProgressBarTextLocation.center {
            switch index {
                
            case 0: return ""
            case 1: return ""
            case 2: return ""
            case 3: return ""
            default: return "Date"
                
            }
        }
    return ""
    }
    @IBAction func girl(_ sender: UIButton) {
        childInfo.sex = "girl"
        selectButton(sender)
        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial", isFirstTimeInserting: false)
        self.charachterImage.image = UIImage(named: "girl")
        errorLabel.isHidden = true
        
    }
    @IBAction func boy(_ sender: UIButton) {
        childInfo.sex = "boy"
        selectButton(sender)
        self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial",  isFirstTimeInserting: false)
        self.charachterImage.image =  UIImage(named: "boy")
    }
    
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! SignUpNameViewController
        destinationVC.childInfo.pass = childInfo.pass
        destinationVC.childInfo.email = childInfo.email
        destinationVC.childInfo.DOB = childInfo.DOB
        destinationVC.childInfo.sex = childInfo.sex
    }
    

    @IBAction func next(_ sender: Any) {
        if childInfo.sex != ""{
                self.performSegue(withIdentifier: "charachterNext", sender: self)
            }
                else{
                    errorLabel.text = "لطفًا، اختر شخصيتك"
                    self.present(alert.Alert(body:"لطفًا، اختر شخصيتك"),animated: true)
        }
    }
}
