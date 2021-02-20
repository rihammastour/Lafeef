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
    let alert = AlertService()
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
    var toopingCounter : Int = 0
    var button: SKNode! = nil
    var cashierbutton: SKNode! = nil
    let cam = SKCameraNode()
    var flag = false
   
    var viewController: ChallengeViewController?
    
    //MARK:  Charachters  Variables
    var customers : [CustomerNode]=[]
    var currentCustomer = 0
    
    //MARK:  Nodes Variables
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var bakeryBackgroundNode : SKNode?
    private var progessBarContiner : SKSpriteNode!
    
    //Order Conent node variables
    private var orderContiner : SKSpriteNode?
    private var base : SKSpriteNode?
    
    //Timer variables
    static var timeLeft: TimeInterval = 30//change
    let timeLeft1=30//change
    static var timer = Timer()
   static var displayTime : SKLabelNode?
   static var endTime: Date?
    static var isPaused11 = false
    static var incr2 = 1
    static var circleBool=true
    static var stopCircle=false
    static var circle : SKShapeNode?
    
//  static var percent = CGFloat(1.0)
    //MARK: - Lifecycle Functons
    

    override func sceneDidLoad() {
        
        setupSceneElements()
        setUpCatcter()
       // addChild(cam)
    }
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        
        buildCustomer(customerNode: customers[currentCustomer])
        
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
    func setUpCatcter(){
        while customers.count <= 3  {
            let randomInt = Int.random(in: 1..<6)
            var choosenCustomer = Customers(rawValue: randomInt)?.createCustomerNode()
            customers.append(choosenCustomer!)
            
        }
    }
    func buildCustomer(customerNode: CustomerNode) {
        customerNode.buildCustomer()
        customerNode.customer.position = CGPoint(x: frame.midX-550, y: frame.midY)
        customerNode.walkingCustomer()
        
        //move to take cake
        let moveAction = SKAction.moveBy(x: (view?.frame.midX)!+200 , y: (view?.frame.midY)!-510 , duration: 3)
        //
        //               let StopAction = SKAction.run({ [weak self] in
        //                customerNode.stopCustomer()
        //               })
        let WaitingAction = SKAction.run({ [weak self] in
            customerNode.waitingCustomer()
        })
        let moveActionWithDone = SKAction.sequence([moveAction,WaitingAction] )
        
        //        customerNode.customer.run(moveActionWithDone, withKey:"sequence\(customerNode.customerName)")
        customerNode.customer.run(moveActionWithDone) {
            //make order visible
            self.orderContiner?.isHidden = false
        }
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
        
        //Set progress bar
        createPrograssBar()
        
        // Get Camera node from scene and store it for use later
        self.camera = cam
        
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
        
        
//        //Creat leble to display time ????
//        self.displayTime = self.childNode(withName: "displayTimeLabel") as? SKLabelNode
//        if self.displayTime != nil {
//
//            endTime = Date().addingTimeInterval(timeLeft)
//            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//            displayTime?.text=timeLeft.time
//            displayTime?.run(SKAction.fadeIn(withDuration: 2.0))
//            displayTime?.isHidden=true
//
//        }
        
    }
    
    //createPrograssBar
    func createPrograssBar(){
        
        // Get Prograss bar Continer node from scene and store it for use later
        self.progessBarContiner = self.childNode(withName: "progressbarContainer") as? SKSpriteNode
        
        //Create prograss bar and hide it using SKCropNode Mask
        let bar = PrograssBar()
        bar.configure(at: CGPoint(x: 0, y: 0))
        progessBarContiner?.addChild(bar)
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
        
        //        //make order visible
        //        self.orderContiner?.isHidden = false
        
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
        //Creat leble to display time ????
        GameScene.displayTime = self.childNode(withName: "displayTimeLabel") as? SKLabelNode
        if GameScene.displayTime != nil {
            
            GameScene.endTime = Date().addingTimeInterval(GameScene.timeLeft)
            GameScene.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            print("first")
//            GameScene.displayTime?.text=GameScene.timeLeft.time
            GameScene.displayTime?.run(SKAction.fadeIn(withDuration: 2.0))
//            displayTime?.isHidden=true
            
        }
        
       // static let circle = SKShapeNode(circleOfRadius: 46)
        GameScene.circle = SKShapeNode(circleOfRadius: 46)
        GameScene.circle!.position = CGPoint(x: frame.midX+310, y: frame.midY+320)
        GameScene.circle!.fillColor = SKColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0)
        GameScene.circle!.strokeColor = SKColor.clear
        GameScene.circle!.zRotation = CGFloat.pi / 2
        addChild(GameScene.circle!)
        print("convert int here")
        print(Int(GameScene.timeLeft))
        print(TimeInterval(Int(GameScene.timeLeft)))
        
        countdown(circle: GameScene.circle!, steps: 30, duration: 30) {
            print("انا ما اطلع من الميثود")
        }
        //self.startTimer()
        
    }
    
    
    //create Topping
    func createTopping(at position:PositionTopping,as topping:Topping){
        
        toopingCounter += 1
        
        let node = SKSpriteNode(imageNamed: topping.rawValue)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = position.getPosition()
        node.size = CGSize(width: 60, height: 60)
        node.zRotation = position.getZRotation(for: topping)
        
        base?.addChild(node)
        
    }
    
    //create Base
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
        
    }
    
    //MARK:- Timer function
    // Creates an animated countdown timer
    
    func countdown(circle:SKShapeNode, steps:Int, duration:TimeInterval, completion:@escaping ()->Void) {
        guard let path = circle.path else {
            return
        }
        if(GameScene.stopCircle){
            self.removeAllActions()
        }
        
        
        let radius = path.boundingBox.width/2
        var timeInterval = duration/TimeInterval(steps)
        let incr = 1 / CGFloat(steps)
        var percent = CGFloat(1.0)
        
        let animate = SKAction.run { [self] in
            //            if(stopCircle){
            //                self.removeAllActions()
            //            }
            print("####")
            print(timeInterval)
//            timeInterval=duration/GameScene.timeLeft
            print("*****the percent******")
           // print(percent)
            print("******the redius*******")
            //print(radius)
//            GameScene.circleBool
            if(GameScene.circleBool)
            {percent -= incr}
//            percent -= incr
            circle.path = self.circle(radius: radius, percent:percent)
            
            if( Int(GameScene.timeLeft) < 30){
                circle.fillColor = SKColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0)
                
                
                
                
            }
            
            if( Int(GameScene.timeLeft) <= 20){
                circle.fillColor = SKColor(hue: 0.1222, saturation: 0.46, brightness: 0.94, alpha: 1.0)
                
            }
            
            if( Int(GameScene.timeLeft) <= 10 && Int(GameScene.timeLeft)>=0){
                circle.fillColor = SKColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0)
            }
            
            
        }
//        timeInterval=duration/GameScene.timeLeft
        let wait = SKAction.wait(forDuration:timeInterval)
        let action1 = SKAction.sequence([wait, animate])
       // self.action(forKey: "circleDone")
//        square.runAction(SKAction.repeatActionForever(moveSequence), withKey:"moving")
//        run(SKAction.repeatForever(action1)) {
//            if(GameScene.stopCircle){
//                self.removeAllActions()
//            }
//
        run(SKAction.repeatForever(action1), withKey: "stopTimer")
//        self.run(SKAction.repeatForever(SKAction.action1(forKey: "timer")!)){
         
        self.run(SKAction.wait(forDuration:TimeInterval(5))) {
                print("انا اتكرر ///////////////")
                if(Int(GameScene.timeLeft)==0){
                    //action1.speed = 0.0
                    self.removeAction(forKey: "stopTimer")
                    GameScene.stopCircle=true
                    //GameScene.circle = nil
print("امك تقول انك تدخل هنا")
                //                circle.fillColor = SKColor.red
                completion()
//                    circle.removeAllActions()

                }
            }
       

       // }
        
//        repeat {
//            run(SKAction.repeat(action, count: 1)) {
//            
//            
//                        self.run(SKAction.wait(forDuration:TimeInterval(Int(GameScene.timeLeft)))) {
//                            if(Int(GameScene.timeLeft)==0){
//                            circle.path = nil
//                                stopCircle=false
//                            //                circle.fillColor = SKColor.red
//                            completion()
//                              
//            //                    circle.removeAllActions()
//            
//                            }
//                        }
//            
//                    }
//        } while stopCircle
        
        
        
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
        
        
        if(Int(GameScene.timeLeft)>greenTime){
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            GameScene.displayTime?.text = GameScene.timeLeft.time
//            GameScene.displayTime?.text = GameScene.timeLeft.time+"99"
            print(GameScene.timeLeft.time)
            print("raghad")
//            if(GameScene.isPaused11==true){
//                print("is PAUSED IS TRUE ")
//                print(GameScene.timeLeft.time)
//                GameScene.displayTime?.text = "Areej"
//            }
            
            //green
            
            
        }
        else  if (Int(GameScene.timeLeft) > yellowTime){
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            GameScene.displayTime?.text = GameScene.timeLeft.time
//            GameScene.displayTime?.text = GameScene.timeLeft.time+"88"
        
            print(GameScene.timeLeft.time)
            //yellow
            
        }
        
        else  if (GameScene.timeLeft > 0 ){
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            GameScene.displayTime?.text = GameScene.timeLeft.time
            print(GameScene.timeLeft.time)
            //orange
            
        }
        else {
            GameScene.displayTime?.isHidden=false
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.displayTime?.text = "انتهى الوقت!"
            GameScene.displayTime?.color=SKColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0)
            //red
            
            GameScene.timer.invalidate()
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
                customers[currentCustomer].movetoCashier(customerNode: customers[currentCustomer], customerSatisfaction: "happy")
                
                //make order invisible
                self.orderContiner?.isHidden = true
                // will go left
                //move to take cake
                
            }
            
            if cashierbutton.contains(location) {
                flag = false
                
                customers[currentCustomer].moveOut(customerNode: customers[currentCustomer], customerSatisfaction: "happy") { [self] in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) { [self] in
                        
                        self.cam.position = CGPoint(x: 0, y: 0)
                        currentCustomer += 1
                        if (currentCustomer<=3){
                            buildCustomer(customerNode: customers[currentCustomer])
                            viewController?.nextOrder()
                        }
                        
                        else {
                            print("THE LEVEL IS END")
                        }
                        
                    }
                    
                    
                }
                
                
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
            cam.position = customers[currentCustomer].customer.position
        }
  
        // Called before each frame is rendered
        
       
        if (Int(GameScene.timeLeft)==1){
            print("صار الوقت واحد")
            print(GameScene.timeLeft)

        }
        if (Int(GameScene.timeLeft)==0){
            print("صار الوقت صفر")
            print(GameScene.timeLeft)

        }
        if(Int(GameScene.timeLeft)==0){
            //action1.speed = 0.0
            //0.30000000000000016
            
        
            print("صار الوقت صفر ودخلت")
            self.removeAction(forKey: "stopTimer")
            GameScene.stopCircle=true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            GameScene.circle?.path = self.circle(radius: 46, percent:-1)
            }

        }
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
