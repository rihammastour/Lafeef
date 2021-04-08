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
   
        frameImage.image = UIImage(named:framename)
        lampImage.isHidden = showLamp
        changeBackgroud()

       
    }
    func changeBackgroud(){
        if !isStore {
            // hide background image
            previewImage(background: false, charachter: true, frame: false, lamp: false)
            charachterImage.image = UIImage(named: charachterImageName)
       
            if isGirl{
                self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.96, greenBottom: 0.71, blueBottom: 0.71, type: "radial", isFirstTimeInserting: false)
            }else{
                self.view.setGradientBackground(redTop: 1, greenTop: 1, blueTop: 1, redBottom: 0.67, greenBottom: 0.82, blueBottom: 0.76, type: "radial",  isFirstTimeInserting: false)
            }
        }else{
            //show background 
            if showLamp{
                self.previewImage(background: true, charachter: false, frame: false, lamp: showLamp)
           
            }else{
                self.previewImage(background: true, charachter: false, frame: true, lamp: false)
            }
    
    }
    }
    func previewImage(background:Bool,charachter:Bool,frame:Bool,lamp:Bool){
        frameImage.isHidden = frame
        lampImage.isHidden = lamp
        previewBackground.isHidden = background
        charachterImage.isHidden  = charachter
    }
    
}
