//
//  SignUpCharachterViewController.swift
//  Lafeef
//
//  Created by Mihaf on 09/06/1442 AH.
//

import UIKit
import FlexibleSteppedProgressBar

class SignUpCharachterViewController: UIViewController, FlexibleSteppedProgressBarDelegate {
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!
    var childInfo = Child()
    
    @IBOutlet var charectarView: UIView!
    @IBOutlet weak var charachterImage: UIImageView!
    

    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var girl: UIButton!
    @IBOutlet var charectarButton: [UIButton]!
    
    @IBOutlet weak var boy: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        girl.layer.cornerRadius = 0.5 * girl.bounds.size.width
        girl.clipsToBounds = true
        boy.layer.cornerRadius = 0.5 * boy.bounds.size.width
        boy.clipsToBounds = true
        nextOutlet.layer.cornerRadius = nextOutlet.frame.size.height/2

        // Do any additional setup after loading the view.
        self.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial")
        
        setupProgressBarWithoutLastState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if childInfo.charachter == "girl" {
            self.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial")
        }
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
        progressBarWithoutLastState.currentSelectedTextColor = progressColor
        progressBarWithoutLastState.viewBackgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.91, alpha: 1.0)
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! SignUpNameViewController
        destinationVC.childInfo.pass = childInfo.pass
        destinationVC.childInfo.email = childInfo.email
        destinationVC.childInfo.day = childInfo.day
        destinationVC.childInfo.month  = childInfo.month
        destinationVC.childInfo.year = childInfo.year
        destinationVC.childInfo.charachter = childInfo.charachter
    }
    

    @IBAction func next(_ sender: Any) {
        self.performSegue(withIdentifier: "charachterNext", sender: self)
    }
    
    @IBAction func girl(_ sender: UIButton) {
        childInfo.charachter = "girl"
        selectButton(sender)
        self.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial")
        self.charachterImage.image = UIImage(named: "girl")
        
    }
    
    @IBAction func boy(_ sender: UIButton) {
        childInfo.charachter = "boy"
        selectButton(sender)
        self.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial")
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
}
