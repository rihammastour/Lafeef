//
//  SignUpDOBViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FlexibleSteppedProgressBar

class SignUpDOBViewController: UIViewController, FlexibleSteppedProgressBarDelegate {
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!
    var childInfo = Child()

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
        
        self.setGradientBackground(redTop: 0.96, greenTop: 0.96, blueTop: 0.91, redBottom: 0.98, greenBottom: 0.98, blueBottom: 0.96, type: "axial")
        
        setupProgressBarWithoutLastState()
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
        
        progressBarWithoutLastState.currentIndex = 1
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

         let destinationVC = segue.destination as! SignUpCharachterViewController
        destinationVC.childInfo.pass = childInfo.pass
        destinationVC.childInfo.email = childInfo.email
        destinationVC.childInfo.day = dayTextfield.text ?? ""
        destinationVC .childInfo.month  = monthTextfield.text ?? ""
        destinationVC.childInfo.year = yearTextfield.text ?? ""
   
     }
    
    @IBAction func next(_ sender: Any) {
        if monthTextfield.text != ""  && yearTextfield.text != "" && dayTextfield.text != ""  {
            self.performSegue(withIdentifier: "DOBNext", sender: self)
            
            //validation for future year
        }
    
    }
    

}
