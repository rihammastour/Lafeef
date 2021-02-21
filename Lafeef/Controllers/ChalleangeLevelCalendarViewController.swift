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

    
    @IBOutlet weak var levelThreeOutlet: UIButton!
    @IBOutlet weak var levelTwoOutlet: UIButton!

    @IBOutlet weak var levelTwoLabel: UILabel!
    @IBOutlet weak var levelOneLabel: UILabel!
    @IBOutlet weak var levelThreeLabel: UILabel!
    
    @IBOutlet weak var levelOneStar: UIImageView!
    
    @IBOutlet weak var levelThreeStar: UIImageView!
    @IBOutlet weak var levelTwoStar: UIImageView!
    
    @IBOutlet weak var levelThreeView: UIView!
    @IBOutlet weak var levelTwoView: UIView!
    
    
    @IBOutlet weak var leveOneView: UIView!
    
    var completedLevels = [CompletedLevel]()
    var levelMinScore = [Float]()
    var levelMaxScore = [Float]()
    var completed :CompletedLevel?
    var array = [Level]()
    var level:Level?
    var levelNum:String? = "1"
    var currentOrder = 0
    var duration:Float?
    var orders:[Order]?
    
    // colors
      let green = "#EBF0C4"
      let red = "#F2E6E4"
      var CVColors:[UIColor] = []
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getlevelsScores()
        getChildReports()
       hideStars()
        setLevelsData()
   
        }
    
    func hideStars(){
        levelOneStar.isHidden = true
        levelTwoStar.isHidden = true
        levelThreeStar.isHidden = true
        print(self.duration)
    print("ccccc")
    print(level)
     print(self.completed)
     print(self.completedLevels.count)
    }
    func disableButtons(){
        levelTwoOutlet.isEnabled = false
        levelThreeOutlet.isEnabled = false
    }
    // levels methods
    
    @IBAction func levelOne(_ sender: Any) {
    }
    
    @IBAction func levelTwo(_ sender: Any) {
    }
    
    
    @IBAction func levelThree(_ sender: Any) {
    }
    
 
    func setLevelsData(){
        print("inside setdata")
        print(self.completedLevels)
        if completedLevels.count != 0 {
            for (index,level) in completedLevels.enumerated() {

                if (index == 0){
                    if level.reportData.isPassed{
                    leveOneView.backgroundColor = UIColor.fromHex(hexString: green)
                        levelOneStar.image = UIImage(named: "star.fill")
                        levelTwoView.backgroundColor = UIColor.fromHex(hexString: red)
                        levelTwoOutlet.isEnabled = true
                     }
//                    levelOneLabel.text = level.reportData.collectedScore.description + "/" + completedLevels[index].description
                    levelOneStar.isHidden = false
                    levelOneStar.image = UIImage(named: "star")

                }
                if (index == 1){
                    if level.reportData.isPassed{
                        levelTwoView.backgroundColor = UIColor.fromHex(hexString: green)
                        levelOneStar.image = UIImage(named: "star.fill")
                        levelTwoLock.isHidden = false
                        levelTwoView.backgroundColor = UIColor.fromHex(hexString: red)
                        levelThreeOutlet.isEnabled = true
                     }
//                    levelTwoLabel.text = level.reportData.collectedScore.description + "/" + completedLevels[index].description
                    levelTwoStar.isHidden = false
                    levelTwoStar.image = UIImage(named: "star")
                }
                if (index == 2){
                    if level.reportData.isPassed{
                        levelThreeView.backgroundColor = UIColor.fromHex(hexString: green)
                        levelThreeStar.image = UIImage(named: "star.fill")
//                        levelTwoLock.isHidden = false
//                        levelThreeView.backgroundColor = UIColor.fromHex(hexString: red)
//                        levelThreeOutlet.isEnabled = true
                     }
//                    levelThreeLabel.text = level.reportData.collectedScore.description + "/" + completedLevels[index].description
                    levelThreeStar.isHidden = false
                    levelThreeStar.image = UIImage(named: "star")
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
               //                            self.setLevelInfo(level)
                self.level = level
                    self.array.append(level)
//                        self.hideStars()
               
                                           //self.startLevelTimer()
            }catch{
             print("error while decoding ",error.localizedDescription)
               }
               
   }
            
        
                
            }
        }
       func setLevelInfo(_ level:[CompletedLevel]) -> Void {
           print("insdieset")
           self.completedLevels = level
   //        self.array?.append(self.levels!)
           print(self.completedLevels)


       }
       //feachChalengeLevelHandeler
      
           func getChildReports(){
              // need child id
            var newItems: [CompletedLevel] = []
            FirebaseRequest.getChalleangeLevelesReports(childID: "fIK2ENltLvgqTR5NODCx4MJz5143") { (level, error) in
                if error != ""{
              print("Challenge View Controller",error)
           }else{
                   
                    do{
                 
               let level = try FirebaseDecoder().decode(CompletedLevel.self, from: level!)
                   //                            self.setLevelInfo(level)
                    self.completed = level
                    self.completedLevels.append(level)
//                        self.hideStars()
                   
                                               //self.startLevelTimer()
                }catch{
                 print("error while decoding ",error.localizedDescription)
                   }
                   
       }
                
            }
//            self.setLevelInfo(newItems)
           
            
//                   FirebaseRequest.getChalleangeLevelesReports(childID: "fIK2ENltLvgqTR5NODCx4MJz5143", completionBlock:  {  (Level, error)
//                    in
//                    if error != ""{
//                        print("Challenge View Controller",error)
//
//                    }else{
//
//                        do{
//                            //Convert data to type Child
//                            let level = try FirebaseDecoder().decode(CompletedLevel.self, from: Level!)
////                            self.setLevelInfo(level)
//                            self.completedLevels.append(level)
//
//                            //self.startLevelTimer()
//                        }catch{
//                            print("error while decoding ",error.localizedDescription)
//                            //TODO:Alert..
//                        }
//
//               }
//
//           }
//
           }
    
    func fetchChallengeLevel(){
        
        guard let levelNum = levelNum else {
            //TODO: Alert and go back
//            showAlert(with: "لا يوجد طلبات لهذا اليوم")//Not working
            return
        }
        
        FirebaseRequest.getChallengeLvelData(for: levelNum, completion:feachChallengeLevelHandler(_:_:))
        
    }
         
func setLevelInfo(_ level:Level) -> Void {
    self.duration = level.duration
    self.orders = level.orders
// be Moved to be called after user provid the answer
}
//feachChalengeLevelHandeler
func feachChallengeLevelHandler(_ data:Any?,_ err:Error?) -> Void {
    
    if err != nil{
        print("Challenge View Controller",err!)
        
        if err?.localizedDescription == "Failed to get document because the client is offline."{
            print("تأكد من اتصال الانترنيت")
            //TODO: Alert and update button and go back
        }
        
    }else{
        
        do{
            //Convert data to type Child
            let level = try FirebaseDecoder().decode(Level.self, from: data!)
            self.setLevelInfo(level)
            //self.startLevelTimer()
          
        }catch{
            print("error while decoding ",error.localizedDescription)
            //TODO:Alert..
        }
        
        
    }
}

}

