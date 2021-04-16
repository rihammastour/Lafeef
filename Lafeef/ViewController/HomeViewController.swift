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
    
    
    let formatter = NumberFormatter()
    let  sound = SoundManager()
    let alertservice = AlertService()
    
    
    
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        //Register child obj to observe changes
//        RegisterObserver(for:"child")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.locale = Locale(identifier: "ar")
        sound.playSound(sound: Constants.Sounds.hello)
        //Additional setup after loading the view.
        
        //Style elemnts
        setUpElements()
        //Get Child Data
        getChildData()
        RegisterObserver(for:"child")
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        getChildData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    
    //MARK: Functions
    
    //MARK: - Setup UI Elements
    func setUpElements() {
        
        //Set Bekary background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "blank-bakery")
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
    
    //Activity Indcator anmation
    //     func startSpinning() {
    //        activityIndicator.startAnimating()
    //    }
    //
    //    func stopSpinning() {
    //        activityIndicator.stopAnimating()
    //    }
    //MARK:- Set content for UI elemnnts
    //Set child info
    func setUIChildInfo(_ child:Child){
        self.setName(child.name)
        self.setCurrentLevel(child.currentLevel)
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
        
        levelNumLabel.text = formatter.string(from: NSNumber(value: level))!
    }
    
    //Score
    func setScore(_ score:Float) {
        scoreLabel.text = formatter.string(from: NSNumber(value: score))!
    }
    func setChildPrefrence(name:String){
        characterUIImageView.image = UIImage(named: name)
        
    }
    
    //Money
    func setMoney(_ money:Float) {
        moneyLabel.text = formatter.string(from: NSNumber(value: money))!
    }
    
    //Image
    func setImage(_ sex:String) {
        if sex != "girl"{
            characterUIImageView.image = UIImage(named: "boy-icon")
        }else if LoginViewController.userPrfrence != ""{
            characterUIImageView.image = UIImage(named: LoginViewController.userPrfrence)
        }else{
            characterUIImageView.image = UIImage(named: "girl-icon")
        }
    }
    //MARK:- Get User Data
    
    //Fetch Child info from db 
    func feachUserData(){
        
        let userId = FirebaseRequest.getUserId()
        FirebaseRequest.getChildData(for: userId!) { (data, err) in
            if err != nil{
                print("Home View Controller",err!)
                if err?.localizedDescription == "Failed to get document because the client is offline."{
                    print("تأكد من اتصال الانترنيت")
                    self.present(self.alertservice.Alert(body: "تأكد من اتصالك بالإنترنت"),animated:true)
                    //TODO: Alert and update button and logout
                }
                
            }else{
                let child = data!
                self.setUIChildInfo(child as! Child)
            }
        }
        
    }
    
    // Get child object from local storage
    func getChildData(){
        let child = LocalStorageManager.getChild()
        
        if let child = child {
            setUIChildInfo(child)
        }else{
            print("No Child Found")
            self.present(self.alertservice.Alert(body: "لايوجد مستخدم"),animated:true)
            
            //TODO: Alert..
            
        }
        
    }
    //MARK: - Local Storage Notifications
    
    //Register key value to be observed
    func RegisterObserver(for key:String){
        UserDefaults.standard.addObserver(self, forKeyPath: key, options: .new, context: nil)
    }
    
    //Observe Handlere
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "child" {
            getChildData()
        }
    }
    
    //MARK: - Actions, Elements Tapped
    @IBAction func profileBarViewTapped(_ sender: Any) {
        
        profileBarUIView.showAnimation({
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.profileViewController ) as! ProfileViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        })
        
    }
    
    @IBAction func challeange(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.performSegue(withIdentifier: Constants.Segue.goToChalleange, sender: self)
        }
        sound.playSound(sound: Constants.Sounds.challeange)
    }
    
    @IBAction func train(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.performSegue(withIdentifier: Constants.Segue.goToTraining, sender: self)
            //
        }
        
        
        sound.playSound(sound: Constants.Sounds.train)
    }
    
    @IBAction func store(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.56) {
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.storeViewController) as? StoreViewController {
                if let navigator = self.navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        
        sound.playSound(sound: Constants.Sounds.store)
    }
}


//MARK: - Extention
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
