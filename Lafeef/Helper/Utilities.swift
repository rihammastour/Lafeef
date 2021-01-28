//
//  Utilities.swift
//  customauth


import Foundation
import UIKit

class Utilities {
    
    //Not updated yet
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(named: "whiteApp")
        button.layer.cornerRadius = 30.0
//        button.titleLabel?.font =  UIFont(name: "FFHekaya-Light", size: 30.7)
        button.clipsToBounds = true
        button.tintColor = UIColor.init(named: "blackApp")
        
        //Shadow
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 7
        button.layer.masksToBounds = false
    }
    
    static func styleBarView(_ view:UIView){
        //Round
        view.layer.cornerRadius = 20;
        view.layer.masksToBounds = true;
        
        //Shadow
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 7
        view.layer.masksToBounds = false
    }
    
    //Not updated yet
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    
}
