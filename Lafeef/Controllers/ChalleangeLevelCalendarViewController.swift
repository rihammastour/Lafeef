//
//  ChalleangeLevelCalendarViewController.swift
//  Lafeef
//
//  Created by Mihaf on 08/07/1442 AH.
//

import UIKit
import CodableFirebase

class ChalleangeLevelCalendarViewController:UIViewController

{
    
    @IBOutlet weak var levelTwoLock: UIImageView!
    @IBOutlet weak var levelThreeLock: UIImageView!
    @IBOutlet weak var leveloneOutlet: UIButton!

    @IBOutlet weak var levelFourView: UIView!
    @IBOutlet weak var levelThreeOutlet: UIButton!
    @IBOutlet weak var levelFourOutlet: UIButton!
    @IBOutlet weak var levelTwoOutlet: UIButton!
    @IBOutlet weak var levelFourStar: UIImageView!
    
    @IBOutlet weak var levelFourLabel: UILabel!
    @IBOutlet weak var levelTwoLabel: UILabel!
    @IBOutlet weak var levelOneLabel: UILabel!
    @IBOutlet weak var levelThreeLabel: UILabel!
    
    @IBOutlet weak var levelOneStar: UIImageView!
    
    @IBOutlet weak var levelThreeStar: UIImageView!
    @IBOutlet weak var levelTwoStar: UIImageView!
    
    @IBOutlet weak var levelThreeView: UIView!
    @IBOutlet weak var levelTwoView: UIView!
    @IBOutlet weak var leveOneView: UIView!
    
    let formatter = NumberFormatter()
    var completedLevels = [CompletedLevel]()
    var levelMinScore = [Float]()
    var levelMaxScore = [Float]()
    var completed :CompletedLevel?
    var maxScoreLevels = [Float]()
    var minScoreLevels = [Float]()
    
    
    // colors
      let green = "#EBF0C4"
      let red = "#F2E6E4"
 
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getlevelsScores()
        getChildReports()
        hideStars()
        disableButtons()
        formatter.locale = Locale(identifier: "ar")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.setLevelsData()
        }
       
   
        }
    
      func hideStars(){
            levelOneStar.isHidden = true
            levelTwoStar.isHidden = true
            levelThreeStar.isHidden = true
            levelFourStar.isHidden = true
        
            }
    func disableButtons(){
        levelTwoOutlet.isEnabled = false
        levelThreeOutlet.isEnabled = false
        levelFourOutlet.isEnabled = false
    }
    // levels methods
    
    @IBAction func levelOne(_ sender: Any) {
        print("levelone")
    }
    
    @IBAction func levelTwo(_ sender: Any) {
        print("leveltwo")
    }
    
    
    @IBAction func levelThree(_ sender: Any) {
        print("levelthree")
    }
    
 
    func setLevelsData(){
        print(self.completedLevels)

      if completedLevels.count != 0 {
            for (index,level) in completedLevels.enumerated() {
                
                switch index {
                case 0:
                    if level.reportData.isPassed{
                        leveOneView.backgroundColor = UIColor.fromHex(hexString: green)
                        levelOneStar.image = UIImage(systemName: "star.fill")
                        levelTwoView.backgroundColor = UIColor.fromHex(hexString: red)
                        levelTwoOutlet.isEnabled = true
                        levelTwoLock.isHidden = true
                    }else{
                        levelOneStar.image = UIImage(systemName: "star")
                    }
                    levelOneLabel.text = "\(maxScoreLevels[index])" + "/" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
                    levelOneStar.isHidden = false
                   

                
                break
                case 1:
                if level.reportData.isPassed{
                    levelTwoView.backgroundColor = UIColor.fromHex(hexString: green)
                    levelTwoStar.image = UIImage(systemName: "star.fill")
                    levelTwoLock.isHidden = false
                    levelThreeView.backgroundColor = UIColor.fromHex(hexString: red)
                    levelThreeOutlet.isEnabled = true
                 }else{
                    levelTwoStar.image = UIImage(systemName: "star")
                }
                levelTwoLabel.text =  "\(maxScoreLevels[index])" + "/" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
                levelTwoStar.isHidden = false
               
                //inside else
                break
                case 2:
                if level.reportData.isPassed{
                    levelThreeView.backgroundColor = UIColor.fromHex(hexString: green)
                    levelThreeStar.image = UIImage(systemName: "star.fill")
                    levelThreeLock.isHidden = false
                    levelFourView.backgroundColor = UIColor.fromHex(hexString: red)
                    levelFourOutlet.isEnabled = true
                 }else{
                    levelThreeStar.image = UIImage(systemName: "star")
                }
                levelThreeLabel.text =  "\(maxScoreLevels[index])" + "/" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
                levelThreeStar.isHidden = false
               
    
                break

                   
                default:
                    if level.reportData.isPassed{
                        levelThreeView.backgroundColor = UIColor.fromHex(hexString: green)
                        levelThreeStar.image = UIImage(systemName: "star.fill")
                        levelTwoLock.isHidden = false
                        levelThreeView.backgroundColor = UIColor.fromHex(hexString: red)
                        levelThreeOutlet.isEnabled = true
                     }else{
                        levelFourStar.image = UIImage(systemName: "star")
                    }
                    levelFourLabel.text  = "\(maxScoreLevels[index])" + "/" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
                    levelFourStar.isHidden = false
                break
                }


    
            }
        }
    }
//     firestore methods
    func   getlevelsScores(){

        FirebaseRequest.getChalleangeLevels { (data, error) in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                do{

           let level = try FirebaseDecoder().decode(Level.self, from: data!)
                    self.setScores(Level: level)

            }catch{
             print("error while decoding ",error.localizedDescription)
               }

   }



            }
        }
    func setScores(Level:Level){
        minScoreLevels.append(Level.minScore)
        maxScoreLevels.append(Level.maxScore)
        
    }
      
           func getChildReports(){
              // need child id
        
            FirebaseRequest.getChalleangeLevelesReports(childID: "fIK2ENltLvgqTR5NODCx4MJz5143") { (level, error) in
                if error != ""{
                    print(error)
           }else{
                   
                    do{
                 
               let level = try FirebaseDecoder().decode(CompletedLevel.self, from: level!)
                        self.setLevel(level)
                    
      
                }catch{
                 print("error while decoding ",error.localizedDescription)
                   }
                   
       }
                
            }


           }

                func setLevel(_ level:CompletedLevel) -> Void {
                    self.completed = level
                    self.completedLevels.append(level)
                    print("inside set")
                 
                
                }
              
//
//
    }




