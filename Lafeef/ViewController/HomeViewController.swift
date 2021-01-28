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
        print("Tapped")
    }
    
}
