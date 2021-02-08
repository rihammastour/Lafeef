//
//  ChallengeViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 07/02/2021.
//

import UIKit
import CodableFirebase
import SpriteKit
import GameplayKit
class ChallengeViewController: UIViewController {
    
    //MARK: - Proprites
    var levelNum:String?
    var orderNum:String?
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 18//change
    let timeLeft1=18//change
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    let timer2 = OrderTimer()
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    var startTheTimer = false
   
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        setUpElements()
        fetchChallengeLevel()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // move the setup of animation here
//        strokeIt.fromValue = 0
//        strokeIt.toValue = 1
//        strokeIt.duration = timeLeft
//        if(startTheTimer){
//            startOrderTimer()
//        }
//        timeLeftShapeLayer.add(strokeIt, forKey: nil)
    }
    //MARK: -Set up UI Element
    func setUpElements(){
        //Set Bekary background
//        setScene()
    }
    
    
    func setScene(){
        if let scene = GKScene(fileNamed: "tryChallenge") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
    }
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY), radius:
            55, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
//        bgShapeLayer.strokeColor = UIColor.white.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 15
        view.layer.addSublayer(bgShapeLayer)
    }
    
    
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX - 100, y: view.frame.midY-100 ), radius:
            30, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.1222, saturation: 0.46, brightness: 0.94, alpha: 1.0).cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        //change the circle size
        timeLeftShapeLayer.lineWidth = 60
        view.layer.addSublayer(timeLeftShapeLayer)
    }
    
    func addTimeLabel() {
        timeLabel = UILabel(frame: CGRect(x: view.frame.midX-150 ,y: view.frame.midY-125, width: 100, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = timeLeft.time
        view.addSubview(timeLabel)
//        print(timeLeft.time)
    }
    







    
    //MARK: - Functions
    
    @IBAction func TimerTapped(_ sender: Any) {
        startTheTimer = true
    }
    
    func fetchChallengeLevel(){
       
       
        self.present(timer2.timer(time: 18), animated: true)
        
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
    
    @objc func updateTime() {
//        let greenTime=timeLeft+1//18
       
        print(timeLeft1)
        let greenTime=timeLeft1/3*2//12
        
        let yellowTime=timeLeft1/3*1//6
        
        
        if(Int(timeLeft)>greenTime){
        timeLeft = endTime?.timeIntervalSinceNow ?? 0
        timeLabel.text = timeLeft.time
        //green
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0).cgColor
       
    }
        else  if (Int(timeLeft) > yellowTime){
     timeLeft = endTime?.timeIntervalSinceNow ?? 0
     timeLabel.text = timeLeft.time
     //yellow
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.1333, saturation: 0.86, brightness: 1, alpha: 1.0).cgColor
     }
    
       else  if (timeLeft > 0 ){
        timeLeft = endTime?.timeIntervalSinceNow ?? 0
        timeLabel.text = timeLeft.time
        //orange
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.0972, saturation: 0.55, brightness: 0.91, alpha: 1.0).cgColor
        }
    else {
        timeLabel.text = "انتهى الوقت!"
        //red
            timeLeftShapeLayer.strokeColor = UIColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0).cgColor
        timer.invalidate()
        }
    }

    
func startOrderTimer(){
    drawBgShape()
    drawTimeLeftShape()
//        addTimeLabel()
    strokeIt.fromValue = 0
    strokeIt.toValue = 1
    strokeIt.duration = timeLeft
    timeLeftShapeLayer.add(strokeIt, forKey: nil)
    endTime = Date().addingTimeInterval(timeLeft)
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
}
    
 


}//END CLASS


//MARK

//
//extension TimeInterval {
//    var time: String {
//        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
//    }
//}
//extension Int {
//    var degreesToRadians : CGFloat {
//        return CGFloat(self) * .pi / 180
//    }
//}

