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
    var button: SKNode! = nil
    var cashierbutton: SKNode! = nil
    let cam = SKCameraNode()
    var flag = false
    var flag2 = false
    //MARK:  Charachters  Variables
    let orange = CustomerNode(customerName: "Orange")
    let apple = CustomerNode(customerName: "Apple")
    let pineapple = CustomerNode(customerName: "Pineapple")
    let strawberry = CustomerNode(customerName: "Strawberry")
    let pear = CustomerNode(customerName: "Pear")
    let watermelon = CustomerNode(customerName: "Watermelon")
    
    
    //MARK:  Nodes Variables
    
   
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var bakeryBackgroundNode : SKNode?
    
    //Order Conent node variables
    private var orderContiner : SKSpriteNode?
    private var base : SKSpriteNode?
    
    //Timer variables
    var timeLeft: TimeInterval = 120//change
    let timeLeft1=120//change
    var timer = Timer()
    private var displayTime : SKLabelNode?
    var endTime: Date?
    
    //MARK: - Lifecycle Functons
    override func sceneDidLoad() {
        
        setupSceneElements()
        
    }
    override func didMove(to view: SKView) {
        backgroundColor = .white
        self.camera = cam
        buildCustomer(customerNode: orange)
        
        //to trash
        button = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 44))
        button.position = CGPoint(x:self.frame.midX, y:self.frame.midY+100);
               self.addChild(button)
    
        cashierbutton = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 44))
        cashierbutton.position = CGPoint(x:600,y:0);
               self.addChild(cashierbutton)
        

    }
    
    //MARK: - Functions
    
  
    //MARK: -  Charachters Functions
    func buildCustomer(customerNode: CustomerNode) {
        customerNode.buildCustomer()
        customerNode.customer.position = CGPoint(x: frame.midX-550, y: frame.midY)
        customerNode.walkingCustomer()
        
        //move to take cake
        let moveAction = SKAction.moveBy(x: (view?.frame.midX)!+200 , y: (view?.frame.midY)!-510 , duration: 3)
     
               let StopAction = SKAction.run({ [weak self] in
                customerNode.stopCustomer()
               })
        let WaitingAction = SKAction.run({ [weak self] in
            customerNode.waitingCustomer()
        })
               let moveActionWithDone = SKAction.sequence([moveAction,WaitingAction] )
        customerNode.customer.run(moveActionWithDone, withKey:"sequence\(customerNode.customerName)")

        print (customerNode.customer.position)
        
        // for cashier
        
        customerNode.customer.size = CGSize(width: 300, height: 350)
        addChild(customerNode.customer)
    }
   
    //MARK: - Set up Scene Eslements Functions
    
    //setupSceneElements
    func setupSceneElements(){
        
        //Set background Bakery
        self.setBackgroundBakary()
        
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
    
    
    
    //MARK:  - Set up Order Contents Functions
    
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
            guard let toppings = toppings else{
                return
            }
            
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
        
        //Start the Timer
        self.startTimer()
        
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
    
    //startTimer
    func startTimer(){
      
        let circle = SKShapeNode(circleOfRadius: 46)
        circle.position = CGPoint(x: frame.midX+310, y: frame.midY+320)
        circle.fillColor = SKColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0)
        circle.strokeColor = SKColor.clear
        circle.zRotation = CGFloat.pi / 2
        addChild(circle)
        
        countdown(circle: circle, steps: 120, duration: 120) {
        }
    }
    
    //MARK:- Timer function
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
            //كود من ريناد وسويت له كومنت 
           // self.camera?.position.x += location.x - previousLocation.x
            
        }
    }
    
    // override touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            let location = t.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if button.contains(location) {
               // orange.happyCustomer()
                flag = true
                orange.movetoCashier(customerNode: orange, customerSatisfaction: "happy")
                // will go left
                //move to take cake
          
            }
            
            if cashierbutton.contains(location) {
                flag = false
                orange.moveOut(customerNode: orange, customerSatisfaction: "sad")
                flag2=true
           
          
            }
        }
    
           }
    
    
    //override touchesCancelled
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    //override update
    override func update(_ currentTime: TimeInterval) {
        if (flag){
        cam.position = orange.customer.position
        }
        if (flag2){
           // cam.position = CGPoint(x: 0, y: 0)
            flag2=false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [self] in
//                cam.position = CGPoint(x: 0, y: 0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) {
                self.cam.position = CGPoint(x: 0, y: 0)
            }
        }
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
    
    // ----------------- charachter animation
    
    
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
