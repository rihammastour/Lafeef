//
//  SignUpNameViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FlexibleSteppedProgressBar

class SignUpNameViewController: UIViewController, FlexibleSteppedProgressBarDelegate {
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!
    var childInfo = Child()

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

        self.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom:0.71 , blueBottom: 0.71, type: "radial")
        
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
        progressBarWithoutLastState.viewBackgroundColor = UIColor(red: 1.00, green: 0.82, blue: 0.82, alpha: 1.0)
        progressBarWithoutLastState.currentSelectedTextColor = progressColor
        
        progressBarWithoutLastState.currentIndex = 3
        
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
    

   
    @IBAction func next(_ sender: Any) {
    }
    
}
