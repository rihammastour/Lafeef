//
//  ChalleangeLevelCalendarViewController.swift
//  Lafeef
//
//  Created by Mihaf on 08/07/1442 AH.
//

import UIKit
import CodableFirebase
import NVActivityIndicatorView
import AVFoundation

class ChalleangeLevelCalendarViewController:UIViewController,AVAudioPlayerDelegate

{
    
    @IBOutlet weak var levelFourLock: UIImageView!
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
    
    var audioPlayer = AVAudioPlayer()
    let formatter = NumberFormatter()
    let goalService  = GoalService()
    var completedLevels = CompletedLevel(reportData: [])
    var levelMinScore = [Float]()
    var levelMaxScore = [Float]()
    var maxScoreLevels = [Float]()
    var minScoreLevels = [Float]()
    var childId = ""
    var challengeVC = ChallengeViewController()
    // activity indicaitor
    var  activityIndicatorView :NVActivityIndicatorView?
  
    override func viewWillAppear(_ animated: Bool) {
   
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      
   
       getChildReports()

        let x =  CGRect(x:  self.activityIndicaitor.center.x-80, y: self.activityIndicaitor.center.y-100 , width: 200, height: 200)
       activityIndicatorView = NVActivityIndicatorView(frame: x, type:.ballBeat, color:UIColor.init(named: "blueApp"), padding: 0)
        self.calendarView.addSubview(activityIndicatorView!)

        activityIndicatorView!.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
       

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
    

    
    @IBAction func levelOne(_ sender: Any) {
        print("level one")
    
        let path = Bundle.main.path(forResource: "a", ofType : "mp3")
        let url = URL(fileURLWithPath : path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print ("There is an issue with this code!")
        }
           
//        self.present(goalService.goal(levelNum: "1"),animated:true)
       
      
    }
    
    @IBAction func levelTwo(_ sender: Any) {
        print("leveltwo")
        self.present(goalService.goal(levelNum: "2"),animated:true)
    }
    
    
    @IBAction func levelThree(_ sender: Any) {
        print("levelthree")
        self.present(goalService.goal(levelNum: "3"),animated:true)
    }
    
    @IBAction func levelFour(_ sender: Any) {
        print("levelFour")
        self.present(goalService.goal(levelNum: "4"),animated:true)
    }
    

    func setLevelsData(){


        print(self.completedLevels)

   
        for level in completedLevels.reportData {
            print("inside fore")

            switch level.levelNum {
                case "1":
                    if level.isPassed{
                        leveOneView.backgroundColor = UIColor.init(named: "passChallenge")
                        levelOneStar.image = UIImage(systemName: "star.fill")
                        levelTwoView.backgroundColor = UIColor.init(named: "failChallenge")
                        levelTwoOutlet.isEnabled = true
                        levelTwoLock.isHidden = true
                        levelTwoLabel.text = "١٠٠/٠"
                        levelTwoStar.image = UIImage(systemName: "star")
                        levelTwoStar.isHidden = false
            
                    }else{
                        levelOneStar.image = UIImage(systemName: "star")
                    }
                    levelOneLabel.text =  "١٠٠/" + formatter.string(from: NSNumber(value: level.collectedScore))!
                    levelOneStar.isHidden = false



                break
                case "2":
                if level.isPassed{
                    levelTwoView.backgroundColor =  UIColor.init(named: "passChallenge")
                    levelTwoStar.image = UIImage(systemName: "star.fill")
                    levelThreeLock.isHidden = true
                    levelThreeView.backgroundColor =  UIColor.init(named: "failChallenge")
                    levelThreeOutlet.isEnabled = true
                    levelThreeLabel.text = "١٠٠/٠"
                    levelThreeStar.image = UIImage(systemName: "star")
                    levelThreeStar.isHidden = false
                 }else{
                    levelTwoStar.image = UIImage(systemName: "star")
                }
                    levelTwoLabel.text = "١٠٠/" + formatter.string(from: NSNumber(value: level.collectedScore))!
                levelTwoStar.isHidden = false

                //inside else
                break
                case "3":
                if level.isPassed{
                    levelThreeView.backgroundColor = UIColor.init(named: "passChallenge")
                    levelThreeStar.image = UIImage(systemName: "star.fill")
                    levelFourLock.isHidden = true
                    levelFourView.backgroundColor = UIColor.init(named: "failChallenge")
                    levelFourOutlet.isEnabled = true
                    levelFourLabel.text = "١٠٠/٠"
                    levelFourStar.image = UIImage(systemName: "star")
                    levelFourStar.isHidden = false
                
                    
                 }else{
                    levelThreeStar.image = UIImage(systemName: "star")
                }
                levelThreeLabel.text = "١٠٠/" + formatter.string(from: NSNumber(value: level.collectedScore))!
                levelThreeStar.isHidden = false
               
                    


                break


                default:
                    if level.isPassed{
                        levelFourView.backgroundColor = UIColor.init(named: "passChallenge")
                        levelFourStar.image = UIImage(systemName: "star.fill")

                        levelThreeView.backgroundColor = UIColor.init(named: "failChallenge")
                        levelThreeOutlet.isEnabled = true
                     }else{
                        levelFourStar.image = UIImage(systemName: "star")
                    }
                    levelFourLabel.text  = "١٠٠/" + formatter.string(from: NSNumber(value: level.collectedScore))!
                    levelFourStar.isHidden = false

                break
                }



            }
      
    }

    func getChildId(){
        self.childId =  FirebaseRequest.getUserId() ?? ""
    }

    func getChildReports(){
        FirebaseRequest.getChalleangeLevelesReports(childID: FirebaseRequest.getUserId()!) { [self] (data, error) in
            if error == ""{
                do{
           let level = try FirebaseDecoder().decode(CompletedLevel.self, from: data!)
                    self.setLevel(level)
                    
                    activityIndicatorView!.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                  
                 

            }catch{
             print("error while decoding child report ",error)
               }


            }else{
                print("error")

            }
        }
    }
     func setLevel(_ level:CompletedLevel) -> Void {
        self.completedLevels = level
                    }
    
  
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          //...
      }
    }





