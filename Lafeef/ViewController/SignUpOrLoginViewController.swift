//
//  SignUpOrLoginViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 26/01/2021.
//

import UIKit
import SwiftyGif
import SwiftySound
import AVFoundation

class SignUpOrLoginViewController: UIViewController, SwiftyGifDelegate, AVAudioPlayerDelegate {

    //MARK:- Proprities
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    var player = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
     
  
        
        
        // Additional setup after loading the view.
        setUpElements()

    
        }
    
    func setUpElements() {
    
        let path = Bundle.main.path(forResource: "q", ofType : "mp3")
        let url = URL(fileURLWithPath : path!)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print ("There is an issue with this code!")
        }
    
        //Styling Text Label
        // Utilities.styleTextField(emailTextField)
            
        //Styling Buttons
        Utilities.styleFilledButton(logInButton, color: "whiteApp")
        Utilities.styleFilledButton(signUpButton, color: "whiteApp")
    }

}
