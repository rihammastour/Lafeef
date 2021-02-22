//
//  GameScene.swift
//  Lafeef
//
//  Created by Riham Mastour on 05/06/1442 AH.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //MARK: - Proprites
    
    //MARK: Variables
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
    var toopingCounter : Int = 0
    var moneyCounter : Int = 0
    
    //MARK:  Nodes Variables
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var bakeryBackgroundNode : SKNode?
    private var tableNode : SKSpriteNode?
    
    //Order Conent node variables
    private var orderContiner : SKSpriteNode?
    private var base : SKSpriteNode?
    
    //Payment node variables
    private var bill : SKSpriteNode?
    private var paymentContainer : SKSpriteNode?
    private var totalBillLabel : SKLabelNode?
    private var totalBillWithTaxLabel : SKLabelNode?

    
    //Timer variables
    var timeLeft: TimeInterval = 120//change
    let timeLeft1=120//change
    var timer = Timer()
    private var displayTime : SKLabelNode?
    var endTime: Date?
    
    //MARK: - Lifecycle Functons
    override func sceneDidLoad() {
        print("scene")
        
        setupSceneElements()
        
    }
    
    //MARK: - Functions
    
    //MARK: - Set up Scene Eslements Functions
    
    //setupSceneElements
    func setupSceneElements(){
        
        //Set background Bakery
        self.setBackgroundBakary()
        
        // Get table node from scene and store it for use later
        self.tableNode = bakeryBackgroundNode?.childNode(withName: "tableNode") as? SKSpriteNode

        
        // Get Camera node from scene and store it for use later
        self.camera = self.childNode(withName: "camera") as? SKCameraNode
        if self.camera != nil {
            setCameraConstraints()
        }
        
        // Get Order Continer node from scene and store it for use later
        self.orderContiner = self.childNode(withName: "orderContiner") as? SKSpriteNode
        self.orderContiner?.isHidden = true
        
        // Create shape node to use during mouse interaction ????
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        
        //Creat leble to display time ????
        self.displayTime = self.childNode(withName: "displayTimeLabel") as? SKLabelNode
        if self.displayTime != nil {
            
            endTime = Date().addingTimeInterval(timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            displayTime?.text=timeLeft.time
            displayTime?.run(SKAction.fadeIn(withDuration: 2.0))
            displayTime?.isHidden=true
            
        }
        
        // Get Payment Continer node from scene and store it for use later
        self.paymentContainer = tableNode?.childNode(withName: "paymentContainer") as? SKSpriteNode
        //................................. Don't forget to hide it when it totally done!
        self.paymentContainer?.isHidden = false
        
        self.bill = tableNode?.childNode(withName: "bill") as? SKSpriteNode
        self.totalBillLabel = bill?.childNode(withName: "totalBillLabel") as? SKLabelNode
        self.totalBillWithTaxLabel = bill?.childNode(withName: "totalBillWithTaxLabel") as? SKLabelNode
    }
    
    //setBackgroundBakary
    func setBackgroundBakary(){
        
        //Get real device size
        let deviceWidth = UIScreen.main.bounds.width
        let deviceHeight = UIScreen.main.bounds.height
        
        //Get the aspect ratio
        let maxAspectRatio: CGFloat = (deviceWidth + 1370) / (deviceHeight + 790)
        
        // Get Bakery background node scene and store it for use later
        self.bakeryBackgroundNode = self.childNode(withName: "bakery")

        if let bakery = self.bakeryBackgroundNode{
            bakery.setScale(maxAspectRatio)
        }
    }
    
    
    //MARK: - Question Functions
    
    //MARK: - Set up Order Contents Functions
    
    //setOrderContent
    func setOrderContent(with baseType:Base,_ toppings:[Topping]?){
        
        //unwrap order continer
        guard self.orderContiner != nil else {
            print("no order continer")
            return
        }
        
        //make order visible
        self.orderContiner?.isHidden = false
        
        //Create base node
        self.base = createBaseNode(with: baseType)
        
        if let base = self.base {
            
            //add base to continerOrder
            self.orderContiner?.addChild(base)
            
            //unwrap toopings array if any
            if let toppings = toppings {
                
                //Topping
                for t in toppings {
                    
                    switch self.toopingCounter{
                    case 0:
                        createTopping(at: PositionTopping.topRight(baseType),as: t)
                    case 1:
                        createTopping(at: PositionTopping.topLeft(baseType),as: t)
                    case 2:
                        createTopping(at: PositionTopping.bottomLeft(baseType),as: t)
                    case 3:
                        createTopping(at: PositionTopping.bottomRight(baseType),as: t)
                    default:
                        print("cannot add more than 4 toppings")
                    }
                    
                }
            }
            
        }
        
        //Start the Timer
        let circle = SKShapeNode(circleOfRadius: 46)
        circle.position = CGPoint(x: frame.midX+310, y: frame.midY+320)
        circle.fillColor = SKColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0)
        circle.strokeColor = SKColor.clear
        circle.zRotation = CGFloat.pi / 2
        addChild(circle)
        
        countdown(circle: circle, steps: 120, duration: 120) {
        }
        //self.startTimer()
        
    }
    
    
    //setTopping
    func createTopping(at position:PositionTopping,as topping:Topping){
        
        toopingCounter += 1
        
        let node = SKSpriteNode(imageNamed: topping.rawValue)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = position.getPosition()
        node.size = CGSize(width: 60, height: 60)
        node.zRotation = position.getZRotation(for: topping)
        
        base?.addChild(node)
        
    }
    
    func createBaseNode(with base:Base) -> SKSpriteNode{
        
        let node = SKSpriteNode(imageNamed: base.rawValue)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = CGPoint(x: 0, y: 15)
        
        //get base size depens on base type
        node.size = base.getBaseSize()
        return node
    }
    
    //MARK:  - Set up Payment Contents Functions
    func setPaymentContent(with money:[Money]?){

        //unwrap payment continer
        guard self.paymentContainer != nil else {
            print("no payment continer")
            return
        }
        
        //make payment visible
        self.paymentContainer?.isHidden = false
        
        //positionate payment
        self.paymentContainer?.position = CGPoint(x: 1000, y: 230)
        
            //unwrap money array if any
            if let money = money {
                
                //money
                for m in money {
                    
                    switch self.moneyCounter {
                    case 0:
                        createMoney(at: PositionMoney.first(m), as: m)
                    case 1:
                        createMoney(at: PositionMoney.seconed(m), as: m)
                    case 2:
                        createMoney(at: PositionMoney.third(m), as: m)
                    case 3:
                        createMoney(at: PositionMoney.fourth(m), as: m)
                    case 4:
                        createMoney(at: PositionMoney.fifth(m), as: m)
                    case 5:
                        createMoney(at: PositionMoney.sixth(m), as: m)
                    default:
                        print("cannot add more")
                    }
                }
            }

        }
    
    func createMoney(at position:PositionMoney,as money:Money){
        moneyCounter += 1
        let node = SKSpriteNode(imageNamed: "\(money.rawValue)")
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = position.getPosition()
        node.size = money.getMoneySize()
        node.zRotation = position.getZRotation()
        paymentContainer?.addChild(node)
    }
    
    func setTotalBill(totalBill: Float, tax: Float){
        totalBillLabel?.position = CGPoint(x: 20, y: -40)
        totalBillLabel?.numberOfLines = 3
        totalBillLabel?.fontName =  "FF Hekaya"
        totalBillLabel?.fontSize = 25
        totalBillLabel?.text = "المبلغ = \(totalBill) \n الضريبة (١٥٪) = \(tax) \n المجموع =".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    func setTotalBillWithTax(totalBillWithTax: Float){
        totalBillWithTaxLabel?.position = CGPoint(x: 30, y: -90)
        totalBillWithTaxLabel?.fontSize = 40
        totalBillWithTaxLabel?.fontName =  "FF Hekaya"
        totalBillWithTaxLabel?.text = "\(totalBillWithTax) ريـال".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
    
    //MARK: - Answer Functions
    
    //MARK:- Timer function
    //startTimer
    func startTimer(){
        
    }
    // Creates an animated countdown timer
    func countdown(circle:SKShapeNode, steps:Int, duration:TimeInterval, completion:@escaping ()->Void) {
        print("dddd")
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
            
            if( Int(self.timeLeft) < 120){
                circle.fillColor = SKColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0)
                
            }
            
            if( Int(self.timeLeft) < 60){
                circle.fillColor = SKColor(hue: 0.1222, saturation: 0.46, brightness: 0.94, alpha: 1.0)
            }
            
            if( Int(self.timeLeft) < 30 && Int(self.timeLeft)>=0){
                circle.fillColor = SKColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0)
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
    
    //update time
    @objc func updateTime() {
        
        let greenTime=timeLeft1/3*2//12
        
        let yellowTime=timeLeft1/3*1//6
        
        
        if(Int(timeLeft)>greenTime){
            displayTime?.fontName =  "FF Hekaya"
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            displayTime?.text = timeLeft.time
            //green
            
            
        }
        else  if (Int(timeLeft) > yellowTime){
            displayTime?.fontName =  "FF Hekaya"
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            displayTime?.text = timeLeft.time
            //yellow
            
        }
        
        else  if (timeLeft > 0 ){
            displayTime?.fontName =  "FF Hekaya"
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            displayTime?.text = timeLeft.time
            //orange
            
        }
        else {
            displayTime?.isHidden=false
            displayTime?.fontName =  "FF Hekaya"
            displayTime?.text = "انتهى الوقت!"
            displayTime?.color=SKColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0)
            //red
            
            timer.invalidate()
        }
    }
    
    //MARK: - Actions Functions
    
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
    
    
    
    //MARK:- Constrains Functos
    
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
