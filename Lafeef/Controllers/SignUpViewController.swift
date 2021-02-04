//
//  SignUpViewController.swift
//  Lafeef
//
//  Created by Riham Mastour on 22/06/1442 AH.
//

import UIKit
import FlexibleSteppedProgressBar

class SignUpViewController: UIViewController, FlexibleSteppedProgressBarDelegate {
    
//    var progressBarWithoutLastState: FlexibleSteppedProgressBar!
    var stepNum :Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.setupProgressBarWithoutLastState()
    }

    init(stepNum: Int) {
      self.stepNum = stepNum
        super.init(nibName: nil, bundle: nil)
//        setupProgressBarWithoutLastState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(coder)
    }
//    //---------------------------------------- progress bar
//    func setupProgressBarWithoutLastState() {
//        progressBarWithoutLastState = FlexibleSteppedProgressBar()
//        progressBarWithoutLastState.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(progressBarWithoutLastState)
//
//        // iOS9+ auto layout code
//        let horizontalConstraint = progressBarWithoutLastState.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        let verticalConstraint = progressBarWithoutLastState.topAnchor.constraint(
//            equalTo: view.topAnchor,
//            constant: -30
//        )
//        let widthConstraint = progressBarWithoutLastState.widthAnchor.constraint(equalToConstant: 450)
//        let heightConstraint = progressBarWithoutLastState.heightAnchor.constraint(equalToConstant: 150)
//        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//
//        // Customise the progress bar here
//        let backgroundColor = UIColor(red:0.96, green: 0.96, blue: 0.91, alpha: 1.0)
//        let progressColor = UIColor(red: 0.85, green: 0.89, blue: 0.56, alpha: 1.00)
//        let textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
//        progressBarWithoutLastState.numberOfPoints = 4
//        progressBarWithoutLastState.lineHeight = 3
//        progressBarWithoutLastState.radius = 20
//        progressBarWithoutLastState.progressRadius = 25
//        progressBarWithoutLastState.progressLineHeight = 3
//        progressBarWithoutLastState.delegate = self
//        progressBarWithoutLastState.selectedBackgoundColor = progressColor
//        progressBarWithoutLastState.backgroundShapeColor = backgroundColor
//        progressBarWithoutLastState.selectedOuterCircleStrokeColor = progressColor
//        progressBarWithoutLastState.currentSelectedCenterColor = progressColor
//        progressBarWithoutLastState.stepTextColor = textColorHere
//        progressBarWithoutLastState.currentSelectedTextColor = progressColor
//
//        progressBarWithoutLastState.currentIndex = 0
//
//    }
//
//    func progressBar(_ progressBar: FlexibleSteppedProgressBar,
//                     textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
//        if position == FlexibleSteppedProgressBarTextLocation.center {
//            switch index {
//
//            case 0: return ""
//            case 1: return ""
//            case 2: return ""
//            case 3: return ""
//            default: return "Date"
//
//            }
//        }
//    return ""
//    }

}
