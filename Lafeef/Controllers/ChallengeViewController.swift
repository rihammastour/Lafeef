//
//  ChallengeViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 07/02/2021.
//

import UIKit
import CodableFirebase

class ChallengeViewController: UIViewController {
    
    //MARK: - Proprites
    var levelNum:String?

    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        setUpElements()
        fetchChallengeLevel()
    }
    
    //MARK: - Functions
    
    func fetchChallengeLevel(){

        guard let levelNum = levelNum else {
            print("Return number does't passed")
            //TODO: Alert..
            return
        }
        
        FirebaseRequest.getChallengeLvelData(for: levelNum ) { (data, err) in
            if err != nil{
                print("Challenge View Controller",err!)
                 if err?.localizedDescription == "Failed to get document because the client is offline."{
                    print("تأكد من اتصال الانترنيت")
                    //TODO: Alert and update button and logout
                }

            }else{
                
                do{
                    //Convert data to type Child
                    let level = try FirebaseDecoder().decode(Level.self, from: data!)
                    print("Level information object",level)

                }catch{
                    print("error while decoding ",error.localizedDescription)
                    //TODO:Alert..
                }
                
            }
        }
    }
    
    //MARK: - Setup UI Elements
    func setUpElements(){
        
        //Set Bekary background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "game-background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        
    }
    

}
