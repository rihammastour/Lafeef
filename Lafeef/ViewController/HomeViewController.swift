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
    
    @IBOutlet weak var characterUIImageView: UIImageView!
    //Labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var levelNumLabel: UILabel!
    
    //Buttons
    @IBOutlet weak var storeButton: UIButton!
    
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feachUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Additional setup after loading the view.
        setUpElements()
    }
    
    //MARK: - Functions
    // - Setup UI Elements
    func setUpElements() {
        
        //Set Bekary background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Bakery")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        //Bars style
        Utilities.styleBarView(moneyBarUIView)
        Utilities.styleBarView(scoreBarUIView)
        Utilities.styleBarView(profileBarUIView)
        
        //Store Button style
        Utilities.styleCircleButton(storeButton)
            //create image
        let image = UIImage(named: "storeIcon") as UIImage?
        storeButton.setImage(image, for: .normal)
            //style image
        storeButton.contentVerticalAlignment = .fill
        storeButton.contentHorizontalAlignment = .fill
        storeButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
    }
    
    //MARK:- Set content for UI elemnnts
    //Set child info
    func setUIChildInfo(_ child:Child){
        self.setName(child.name)
        self.setCurrentLevel(child.curretLevel)
        self.setMoney(child.money)
        self.setScore(child.score)
        self.setImage(child.sex)
    }
    
    //Name
    func setName(_ name:String) {
        nameLabel.text = String(name)
    }
    //Level
    func setCurrentLevel(_ level:Int) {
        levelNumLabel.text = String(level)
    }
    
    //Score
    func setScore(_ score:Int) {
        scoreLabel.text = String(score)
    }
    
    //Money
    func setMoney(_ money:Float) {
        moneyLabel.text = String(money)
    }
    
    //Image
    func setImage(_ sex:String) {
        if sex != "girl"{
            characterUIImageView.image = UIImage(named: "boy-icon")
        }else{
            characterUIImageView.image = UIImage(named: "girl-icon")
        }
    }
    //MARK:- Feach User Data
    
    func feachUserData(){

        let userId = FirebaseRequest.getUserId()
        FirebaseRequest.getChildData(for: userId!) { (data, err) in
            if err != nil{
                print("Home View Controller",err!)
                if err?.localizedDescription == "Failed to get document because the client is offline."{
                    print("تأكد من اتصال الانترنيت")
                }
                
            }else{
                let child = data!
                self.setUIChildInfo(child)
            }
        }
        
    }
    
    //MARK: - Elements Tapped
    @IBAction func profileBarViewTapped(_ sender: Any) {
        
        profileBarUIView.showAnimation({

            let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.profileViewController ) as! ProfileViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
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
