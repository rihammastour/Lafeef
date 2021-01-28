//
//  HomeViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 27/01/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
//MARK:- Proprites
    
    //BarUIView
    @IBOutlet weak var moneyBarUIView: UIView!
    @IBOutlet weak var scoreBarUIView: UIView!
    @IBOutlet weak var profileBarUIView: UIView!
    
    //Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var levelNumLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var storeButton: UIButton!
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Additional setup after loading the view.
       setUpElements()
              }
//MARK: - Functions
  // - Setup UI Elements
              func setUpElements() {
                
                //Bekary background
                let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "Bakery")
                backgroundImage.contentMode = UIView.ContentMode.scaleToFill
                self.view.insertSubview(backgroundImage, at: 0)
                
                view.backgroundColor = UIColor(white: 1, alpha: 0.5)
                
                //Bars style
                Utilities.styleBarView(moneyBarUIView)
                Utilities.styleBarView(scoreBarUIView)
                Utilities.styleBarView(profileBarUIView)
                
                //Store Button Style
                Utilities.styleCircleButton(storeButton)
                  //image
                let image = UIImage(named: "storeIcon") as UIImage?
                storeButton.setImage(image, for: .normal)
                  //style image
                storeButton.contentVerticalAlignment = .fill
                storeButton.contentHorizontalAlignment = .fill
                storeButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)


                   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func profileBarViewTapped(_ sender: Any) {

        profileBarUIView.showAnimation({
            print("Anmite")

        })
    
    }
    
    
    
}

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}
