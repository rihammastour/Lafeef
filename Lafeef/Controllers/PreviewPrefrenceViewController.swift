//
//  PreviewPrefrenceViewController.swift
//  Lafeef
//
//  Created by Mihaf on 23/08/1442 AH.
//

import UIKit

class PreviewPrefrenceViewController: UIViewController {
    var framename  = ""
    var showLamp  = false
    var isStore = false
    var isGirl = false
    var charachterImageName = ""
    
    @IBOutlet weak var charachterImage: UIImageView!
    @IBOutlet weak var previewBackground: UIImageView!
    @IBOutlet weak var frameImage: UIImageView!
    @IBOutlet weak var lampImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        previewBackground.isHidden = false
        print(framename)
        print(isStore,"isstore")
        print(isGirl,"girl")
        print(charachterImageName,"char")
   
//        frameImage.image = UIImage(named:framename)
//        lampImage.isHidden = showLamp
        changeBackgroud()

       
    }
    func changeBackgroud(){
        if !isStore { // charachter
            // hide background image
            previewBackground.isHidden = true
            
         
            previewImage(charachter: false, frame: true, lamp: true )
            charachterImage.image = UIImage(named: charachterImageName)
       
            if isGirl{
                self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial", isFirstTimeInserting: false)
            }else{
                self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial",  isFirstTimeInserting: false)
            }
        }else{
            previewBackground.isHidden = false
            //show background
            print(showLamp,"lamp")
           
            self.previewImage(charachter: true , frame: false, lamp: showLamp)
            if framename == ""{
                frameImage.isHidden = true
                
                
            }else{
                frameImage.isHidden = false
                frameImage.image = UIImage(named: framename)
            }
         
    
    }
    }
    func previewImage(charachter:Bool,frame:Bool,lamp:Bool){
        frameImage.isHidden = frame
        lampImage.isHidden = !lamp
        charachterImage.isHidden  = charachter
    }
    
    
    @IBAction func closePreview(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
