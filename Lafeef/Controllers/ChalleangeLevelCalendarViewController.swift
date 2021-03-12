//
//  ChalleangeLevelCalendarViewController.swift
//  Lafeef
//
//  Created by Mihaf on 08/07/1442 AH.
//

import UIKit
import CodableFirebase
import NVActivityIndicatorView

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
    
    @IBOutlet weak var activityIndicaitor: NVActivityIndicatorView!
    @IBOutlet weak var calendarView: UIView!
    let formatter = NumberFormatter()
    var completedLevels = [CompletedLevel]()
    var levelMinScore = [Float]()
    var levelMaxScore = [Float]()
    var maxScoreLevels = [Float]()
    var minScoreLevels = [Float]()
    var childId = ""
    // activity indicaitor
    var  activityIndicatorView :NVActivityIndicatorView?
  
    override func viewWillAppear(_ animated: Bool) {
   
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
        getlevelsScores()
        getChildReports()

        let x =  CGRect(x:  self.activityIndicaitor.center.x-80, y: self.activityIndicaitor.center.y-100 , width: 200, height: 200)
       activityIndicatorView = NVActivityIndicatorView(frame: x, type:.ballBeat, color:UIColor.init(named: "blueApp"), padding: 0)
        self.calendarView.addSubview(activityIndicatorView!)

        activityIndicatorView!.startAnimating()
       

        hideStars()
        disableButtons()
        formatter.locale = Locale(identifier: "ar")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setLevelsData()
        }
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "calendarBackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ChallengeViewController
        if segue.identifier == Constants.Segue.showLevelOne{
            vc.levelNum = "1"
            
        }else if segue.identifier == Constants.Segue.showLevelTwo{
            vc.levelNum = "2"
            
        }
        else if segue.identifier == Constants.Segue.showLevelThree{
            vc.levelNum = "3"
            
        }
        else if segue.identifier == Constants.Segue.showLevelFour{
            vc.levelNum = "4"
            
        }
    }
    
    @IBAction func levelOne(_ sender: Any) {
        print("level one")
        self.performSegue(withIdentifier:  Constants.Segue.showLevelOne, sender: self)
    }
    
    @IBAction func levelTwo(_ sender: Any) {
        print("leveltwo")
        self.performSegue(withIdentifier:  Constants.Segue.showLevelTwo, sender: self)
    }
    
    
    @IBAction func levelThree(_ sender: Any) {
        print("levelthree")
        self.performSegue(withIdentifier:  Constants.Segue.showLevelThree, sender: self)
    }
    
    @IBAction func levelFour(_ sender: Any) {
        print("levelFour")
        self.performSegue(withIdentifier:  Constants.Segue.showLevelFour, sender: self)
    }
    

    func setLevelsData(){

       activityIndicatorView!.stopAnimating()
        
        print(self.completedLevels)

      if completedLevels.count != 0 {
            for (index,level) in completedLevels.enumerated() {
                
                switch index {
                case 0:
                    if level.reportData.isPassed{
                        leveOneView.backgroundColor = UIColor.init(named: "passChallenge")
                        levelOneStar.image = UIImage(systemName: "star.fill")
                        levelTwoView.backgroundColor = UIColor.init(named: "failChallenge")
                        levelTwoOutlet.isEnabled = true
                        levelTwoLock.isHidden = true
                    }else{
                        levelOneStar.image = UIImage(systemName: "star")
                    }
                    levelOneLabel.text = "١٠٠ /" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
                    levelOneStar.isHidden = false
                   

                
                break
                case 1:
                if level.reportData.isPassed{
                    levelTwoView.backgroundColor =  UIColor.init(named: "passChallenge")
                    levelTwoStar.image = UIImage(systemName: "star.fill")
                    levelTwoLock.isHidden = false
                    levelThreeView.backgroundColor =  UIColor.init(named: "failChallenge")
                    levelThreeOutlet.isEnabled = true
                 }else{
                    levelTwoStar.image = UIImage(systemName: "star")
                }
                    levelTwoLabel.text = "١٠٠/" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
                levelTwoStar.isHidden = false
               
                //inside else
                break
                case 2:
                if level.reportData.isPassed{
                    levelThreeView.backgroundColor = UIColor.init(named: "passChallenge")
                    levelThreeStar.image = UIImage(systemName: "star.fill")
                    levelThreeLock.isHidden = false
                    levelFourView.backgroundColor = UIColor.init(named: "failChallenge")
                    levelFourOutlet.isEnabled = true
                 }else{
                    levelThreeStar.image = UIImage(systemName: "star")
                }
                levelThreeLabel.text = "١٠٠/" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
                levelThreeStar.isHidden = false
               
    
                break

                   
                default:
                    if level.reportData.isPassed{
                        levelThreeView.backgroundColor = UIColor.init(named: "passChallenge")
                        levelThreeStar.image = UIImage(systemName: "star.fill")
                        levelTwoLock.isHidden = false
                        levelThreeView.backgroundColor = UIColor.init(named: "failChallenge")
                        levelThreeOutlet.isEnabled = true
                     }else{
                        levelFourStar.image = UIImage(systemName: "star")
                    }
                    levelFourLabel.text  = "١٠٠/" + formatter.string(from: NSNumber(value: level.reportData.collectedScore))!
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
             print("error while decoding challeangeelevel ",error.localizedDescription)
               }

   }
            }
        }
    func getChildId(){
        self.childId =  FirebaseRequest.getUserId() ?? ""
    }

    func getChildReports(){
        FirebaseRequest.getChalleangeLevelesReports(childID: "fIK2ENltLvgqTR5NODCx4MJz5143") { (level, error) in
//    FirebaseRequest.getChalleangeLevelesReports(childID: self.childId) { (level, error) in
                if error != ""{
                    print(error)
           }else{
                   
                    do{
                 
               let level = try FirebaseDecoder().decode(CompletedLevel.self, from: level!)
                        self.setLevel(level)
                    
      
                }catch{
                 print("error while decoding child report  ",error.localizedDescription)
                   }
                   
       }
                
            }


           }

     func setLevel(_ level:CompletedLevel) -> Void {
        self.completedLevels.append(level)
                    }
    
    func setScores(Level:Level){
        minScoreLevels.append(Level.minScore)
   
        maxScoreLevels.append(Level.maxScore)
        
    }
      
    }




