//
//  LogoutViewController.swift
//  Lafeef
//
//  Created by Mihaf on 24/09/1442 AH.
//

import UIKit
import Firebase

class LogoutViewController: UIViewController {

    @IBOutlet weak var yesoutlet: UIButton!
    @IBOutlet weak var canceloutlet: UIButton!
    @IBOutlet weak var logoutView: UIView!
    var controller: UIViewController!
    
    var sound = SoundManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yesoutlet.layer.cornerRadius = yesoutlet.frame.size.height/2
        canceloutlet.layer.cornerRadius = canceloutlet.frame.size.height/2
        
        logoutView.layer.cornerRadius = 20
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yes(_ sender: Any) {
        sound.playSound(sound: Constants.Sounds.bye)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            if Auth.auth().currentUser != nil {
                do {
                    
                    if let vc = self.controller.navigationController?.viewControllers.first{
                        UserDefaults.standard.removeObserver(vc.self, forKeyPath: "child", context: nil)}
                    
                    self.removeDataStorage(for: "child")
                    self.removeDataStorage(for: "levelTwoCount")
                    self.removeDataStorage(for: "levelFourCount")
                    
                    try Auth.auth().signOut()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.signUpOrLoginViewController) as! SignUpOrLoginViewController
                    self.view.window?.rootViewController = controller
                    self.view.window?.makeKeyAndVisible()
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
    }

        
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
func removeDataStorage(for key:String){
    if(key == "child"){
        LocalStorageManager.removeChild()}
    
    if(key == "levelTwoCount" ||
        key == "levelFourCount"){
        LocalStorageManager.removeAdvertisments()
    }
}
}
