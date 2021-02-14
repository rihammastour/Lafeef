//
//  GameScene.swift
//  Lafeef
//
//  Created by Riham Mastour on 05/06/1442 AH.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var displayTime : SKLabelNode?
    private var timerCircle : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var bakeryBackgroundNode : SKNode?
    private var circle1 : SKShapeNode?
    
    var gameTimer: Timer?
    var fireworks = [SKNode]()

    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 18//change
    let timeLeft1=18//change
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    let radius=15
    let timerTouch=UITouch()
    private var downTimer:SKNode?
    let bounds = CGRect(x: 0, y: 0, width: 400, height: 200)
    let uiview = UIView(frame:  CGRect(x: 0, y: 0, width: 400, height: 200))
    
    
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")

    var score = 0 {
        didSet {
            // your code here
        }
    }
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        //Get real device size
        
        //1. Get the aspect ratio of the device
        let deviceWidth = UIScreen.main.bounds.width + 1370
        let deviceHeight = UIScreen.main.bounds.height + 790
        let maxAspectRatio: CGFloat = deviceWidth / deviceHeight
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.displayTime = self.childNode(withName: "Raghad") as? SKLabelNode
        if self.displayTime != nil {
           
//            drawBgShape()
//            drawTimeLeftShape()
//            addTimeLabel()
//            strokeIt.fromValue = 0
//            strokeIt.toValue = 1
//            strokeIt.duration = timeLeft
            endTime = Date().addingTimeInterval(timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            displayTime?.text=timeLeft.time
            displayTime?.run(SKAction.fadeIn(withDuration: 2.0))
            
            
            
            
            
            
        }
        
        self.timerCircle = self.childNode(withName: "circle") as? SKLabelNode
        if let label = self.timerCircle {
//            label.alpha = 0.0
//            drawBgShape()
//             drawTimeLeftShape()
//
//            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.downTimer = self.childNode(withName: "downTimer")
        if self.downTimer != nil{
//                        drawBgShape()
//                        drawTimeLeftShape()
        }
        
        // Get Bakery backbround node scene and store it for use later
        self.bakeryBackgroundNode = self.childNode(withName: "bakery")
        if let bakery = self.bakeryBackgroundNode{
            bakery.setScale(maxAspectRatio)
        }
        
        // Get Camera node from scene and store it for use later
        self.camera = self.childNode(withName: "camera") as? SKCameraNode
        if self.camera != nil {
            setCameraConstraints()
        }

        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
//        drawBgShape()
//        drawTimeLeftShape()
        addTimeLabel()
    }
    
    //touchDown
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    //touchMoved
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
        
        
    }
    
    //touchUp
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    //touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    //touchesMoved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches {
           
            self.touchMoved(toPoint: t.location(in: self))
            
            let location = t.location(in: self)
            let previousLocation = t.previousLocation(in: self)

            self.camera?.position.x += location.x - previousLocation.x
          
        
          
            
            
        }
    }
    
    // override touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    //override touchesCancelled
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    //override update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    //setCameraConstraints
    private func setCameraConstraints() {
        // Don't try to set up camera constraints if we don't yet have a camera.
        guard let camera = camera else { return }

        /*
            Also constrain the camera to avoid it moving to the very edges of the scene.
            First, work out the scaled size of the scene. Its scaled height will always be
            the original height of the scene, but its scaled width will vary based on
            the window's current aspect ratio.
        */
        let scaledSize = CGSize(width: size.width * camera.xScale, height: size.height * camera.yScale)

        /*
            Find the root "board" node in the scene (the container node for
            the level's background tiles).
        */
        guard let bekary = bakeryBackgroundNode else {
            return
        }
        /*
            Calculate the accumulated frame of this node.
            The accumulated frame of a node is the outer bounds of all of the node's
            child nodes, i.e. the total size of the entire contents of the node.
            This gives us the bounding rectangle for the level's environment.
        */
        let boardContentRect = bekary.calculateAccumulatedFrame()

        /*
            Work out how far within this rectangle to constrain the camera.
            We want to stop the camera when we get within 100pts of the edge of the screen,
            unless the level is so small that this inset would be outside of the level.
        */
        let xInset = min((scaledSize.width / 2) + 100, (boardContentRect.width / 2.5)  )
        let yInset = min((scaledSize.height / 2) - 100.0, boardContentRect.height / 2)

        // Use these insets to create a smaller inset rectangle within which the camera must stay.
        let insetContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)

        // Define an `SKRange` for each of the x and y axes to stay within the inset rectangle.
        let xRange = SKRange(lowerLimit: insetContentRect.minX, upperLimit: insetContentRect.maxX)
        let yRange = SKRange(lowerLimit: insetContentRect.minY, upperLimit: insetContentRect.maxY)

        // Constrain the camera within the inset rectangle.
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        levelEdgeConstraint.referenceNode = bekary

        /*
            Add both constraints to the camera. The scene edge constraint is added
            second, so that it takes precedence over following the `PlayerBot`.
            The result is that the camera will follow the player, unless this would mean
            moving too close to the edge of the level.
        */
        camera.constraints = [levelEdgeConstraint]
    }
    
 
    
    override func  didMove( to view: SKView) {
//        let background = SKSpriteNode(imageNamed: "background")
//        background.position = CGPoint(x: 512, y: 384)
//        background.blendMode = .replace
//        background.zPosition = -1
//        addChild(background)
//        strokeIt.fromValue = 0
//        strokeIt.toValue = 1
//        strokeIt.duration = timeLeft
        
        
//        addTimeLabel()
//        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//        let currentCenter = CGPoint(x: 150 + 15 / 2, y: 150 + 15 / 2)
//        let finalPosition = CGPoint(x: currentCenter.x - 1600 / 2, y: currentCenter.y - 1600 / 2)
        
        drawBgShape()
        drawTimeLeftShape()
        addTimeLabel()
        strokeIt.fromValue = 0
        strokeIt.toValue = 1
        strokeIt.duration = timeLeft
//
//        endTime = Date().addingTimeInterval(timeLeft)
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        
        
        let circle = SKShapeNode(circleOfRadius: 50)
         circle.fillColor = SKColor.blue
         circle.strokeColor = SKColor.clear
         circle.zRotation = CGFloat.pi / 2
         addChild(circle)

        countdown(circle: circle, steps: 18, duration: 18) {
             print("done")
         }
        
    }
    
    // Creates an animated countdown timer
    func countdown(circle:SKShapeNode, steps:Int, duration:TimeInterval, completion:@escaping ()->Void) {
        guard let path = circle.path else {
            return
        }
        
      
        let radius = path.boundingBox.width/2
        let timeInterval = duration/TimeInterval(steps)
        let incr = 1 / CGFloat(steps)
        var percent = CGFloat(1.0)

        let animate = SKAction.run {
            percent -= incr
            circle.path = self.circle(radius: radius, percent:percent)
            print("step here")
            print(self.timeLeft)
            print("end steps")
            if( Int(self.timeLeft) == 12){
                circle.fillColor = SKColor(hue: 0.1222, saturation: 0.46, brightness: 0.94, alpha: 1.0)
            }
            
            if( Int(self.timeLeft) == 6){
                circle.fillColor = SKColor.black
            }
            
            if( Int(self.timeLeft) == 3){
                circle.fillColor = SKColor.green
            }
            
        }
        let wait = SKAction.wait(forDuration:timeInterval)
        let action = SKAction.sequence([wait, animate])

        run(SKAction.repeat(action,count:steps-1)) {
           

            if( percent == 15){
                circle.fillColor = SKColor.red
            }
            self.run(SKAction.wait(forDuration:timeInterval)) {
                circle.path = nil
//                circle.fillColor = SKColor.red
                completion()
            }
        
        }
       
        
    }
    
    // Creates a CGPath in the shape of a pie with slices missing
    func circle(radius:CGFloat, percent:CGFloat) -> CGPath {
        let start:CGFloat = 0
        let end = CGFloat.pi * 2 * percent
        let center = CGPoint.zero
        let bezierPath = UIBezierPath()
        bezierPath.move(to:center)
        bezierPath.addArc(withCenter:center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        bezierPath.addLine(to:center)
        return bezierPath.cgPath
    }
    
    
    func drawBgShape() {
 
     
        
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: frame.midX , y: frame.midY), radius:
            55, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.position = CGPoint(x: frame.midX+300, y: frame.midY+300)
//        bgShapeLayer.strokeColor = UIColor.white.cgColor
            
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 15
//        self.view?.layer.addSublayer(bgShapeLayer)
        
       
    }
    func drawTimeLeftShape() {


      

        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: frame.midX+300 , y: frame.midY+300), radius:
            30, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.position = CGPoint(x: uiview.bounds.minX, y: uiview.bounds.minY + 200)
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.1222, saturation: 0.46, brightness: 0.94, alpha: 1.0).cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        //change the circle size
        timeLeftShapeLayer.lineWidth = 60
    
        self.view?.layer.addSublayer(timeLeftShapeLayer)
    }
    func addTimeLabel() {
//        timeLabel = UILabel(frame: CGRect(x: (view?.frame.midX)!-150 ,y: view!.frame.midY-125, width: 100, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = timeLeft.time
        view?.addSubview(timeLabel)
//        print(timeLeft.time)
    }
    
    @objc func updateTime() {
//        let greenTime=timeLeft+1//18

        print(timeLeft1)
        let greenTime=timeLeft1/3*2//12

        let yellowTime=timeLeft1/3*1//6


        if(Int(timeLeft)>greenTime){
        timeLeft = endTime?.timeIntervalSinceNow ?? 0
            displayTime?.text = timeLeft.time
        //green
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0).cgColor

    }
        else  if (Int(timeLeft) > yellowTime){
     timeLeft = endTime?.timeIntervalSinceNow ?? 0
            displayTime?.text = timeLeft.time
     //yellow
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.1333, saturation: 0.86, brightness: 1, alpha: 1.0).cgColor
     }

       else  if (timeLeft > 0 ){
        timeLeft = endTime?.timeIntervalSinceNow ?? 0
        displayTime?.text = timeLeft.time
        //orange
        timeLeftShapeLayer.strokeColor = UIColor(hue: 0.0972, saturation: 0.55, brightness: 0.91, alpha: 1.0).cgColor
        }
    else {
        displayTime?.text = "انتهى الوقت!"
        //red
            timeLeftShapeLayer.strokeColor = UIColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0).cgColor
        timer.invalidate()
        }
    }
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

