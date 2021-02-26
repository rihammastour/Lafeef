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
    var moneyCounter : Int = 0
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
    private var tableNode : SKSpriteNode?
    private var progressBarContiner : SKSpriteNode!
    private var progressBar : SKSpriteNode!
    private var button : SKSpriteNode!
    private var buttonTwo : SKSpriteNode!
    private var buttonThree : SKSpriteNode!
    
    //Order Conent node variables
    private var orderContiner : SKSpriteNode?
    private var base : SKSpriteNode?
    
    //Payment node variables
    private var bill : SKSpriteNode?
    private var paymentContainer : SKSpriteNode?
    private var totalBillLabel : SKLabelNode?
    private var totalBillWithTaxLabel : SKLabelNode?

    //pickup order node variables
    private var cover : SKSpriteNode?
    private var box : SKSpriteNode?
    
    //Timer variables
    static var timeLeft: TimeInterval = 30//change
    let timeLeft1=30//change
    static var timer = Timer()
    static var displayTime : SKLabelNode?
    static var endTime: Date?
    static var circleDecrement=true
    static var stopCircle=false
    static var circle : SKShapeNode?
    static var TimerShouldDelay = false
    static var countStop = 0

    //MARK: - Lifecycle Functons


    override func sceneDidLoad() {
        setupSceneElements()
        setUpCatcter()

        //Buttons TO BE REMOVED LATER
        button = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 44))
        // Put it in the center of the scene
        button.position = CGPoint(x:self.frame.midX, y:self.frame.midY+100);
        self.addChild(button)
        
        buttonTwo = SKSpriteNode(color: .yellow, size: CGSize(width: 100, height: 44))
        // Put it in the center of the scene
        buttonTwo.position = CGPoint(x:self.frame.midX, y:self.frame.midY+50);
        self.addChild(buttonTwo)
        
        buttonThree = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 44))
        // Put it in the center of the scene
        buttonThree.position = CGPoint(x:self.frame.midX, y:self.frame.midY-50);
        self.addChild(buttonThree)
    
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

        ChallengeViewController.stopImageBool=true
        circleShouldDelay()


    }//end did move


    //MARK: - Functions

    func generateTimer(){
        GameScene.displayTime = self.childNode(withName: "displayTimeLabel") as? SKLabelNode
        if GameScene.displayTime != nil {

            GameScene.endTime = Date().addingTimeInterval(GameScene.timeLeft)
            GameScene.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            GameScene.displayTime?.text=GameScene.timeLeft.time
            GameScene.displayTime?.run(SKAction.fadeIn(withDuration: 2.0))
            GameScene.displayTime?.isHidden=true
                                            }
    }


    func generateCircle(){
        GameScene.circle = SKShapeNode(circleOfRadius: 36)
        GameScene.circle!.position = CGPoint(x: 90, y: 95)

        GameScene.circle!.fillColor = SKColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0)
        GameScene.circle!.strokeColor = SKColor.clear
        GameScene.circle!.zRotation = CGFloat.pi / 2
        self.orderContiner!.addChild(GameScene.circle!)
        print(TimeInterval(Int(GameScene.timeLeft)))
        self.countdown(circle: GameScene.circle!, steps: 30, duration: 30) {
                 print("circle is done ")
             }
    }


    func circleShouldDelay(){
        if((!(GameScene.circle == nil))&&GameScene.TimerShouldDelay){

            switch GameScene.countStop {
            case 0:
                print(" in case 0  \(GameScene.countStop)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    GameScene.circleDecrement=true
                }
                break

            case 1:
                print(" in case 1  \(GameScene.countStop)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6){
                GameScene.circle?.isPaused=false
                    GameScene.circleDecrement=true
                }
                break

            case 2:
                print(" in case 2  \(GameScene.countStop)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.50){
            GameScene.circle?.isPaused=false
                    GameScene.circleDecrement=true
                }
                break

            case 3:
                print(" in case 3  \(GameScene.countStop)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.31){
            GameScene.circle?.isPaused=false
                    GameScene.circleDecrement=true
                }
                break

            case 4:
                print(" in case 4  \(GameScene.countStop)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.44){
            GameScene.circle?.isPaused=false
                    GameScene.circleDecrement=true
                }
                break
            case 5:
                print(" in case 5  \(GameScene.countStop)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.45){
            GameScene.circle?.isPaused=false
                    GameScene.circleDecrement=true
                }
                break

            case 6:
                print(" in case 6  \(GameScene.countStop)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.50){
            GameScene.circle?.isPaused=false
                    GameScene.circleDecrement=true
                }
                break
            default:
                GameScene.circle?.isPaused=false
                        GameScene.circleDecrement=true
            }

            GameScene.TimerShouldDelay=false
        }

    }


    //MARK: -  Charachters Functions
    func setUpCatcter(){
        while customers.count <= 3  {
            let randomInt = Int.random(in: 1..<6)
            var choosenCustomer = Customers(rawValue: 6)?.createCustomerNode()
            customers.append(choosenCustomer!)

        }
    }
    func buildCustomer(customerNode: CustomerNode) {
        customerNode.buildCustomer()
        customerNode.customer.position = CGPoint(x: frame.midX-550, y: frame.midY-20)
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
            self.generateCircle()
            self.generateTimer()

        }
        print (customerNode.customer.position)

        // for cashier
        
//        customerNode.customer.size = CGSize(width: 300, height: 350)
        addChild(customerNode.customer)
    }



    //MARK: - Set up Scene Eslements Functions

    //setupSceneElements
    func setupSceneElements(){

        //Set background Bakery
        self.setBackgroundBakary()
        
        // Get table node from scene and store it for use later
        self.tableNode = bakeryBackgroundNode?.childNode(withName: "tableNode") as? SKSpriteNode
        tableNode?.zPosition = 2
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

        // Get Prograss bar Continer node from scene and store it for use later
        self.progessBarContiner = self.childNode(withName: "progressbarContainer") as? SKSpriteNode
        
        // Get Payment Continer node from scene and store it for use later
        self.paymentContainer = tableNode?.childNode(withName: "paymentContainer") as? SKSpriteNode
        //................................. Don't forget to hide it when it totally done!
        self.paymentContainer?.isHidden = false
        
        self.bill = tableNode?.childNode(withName: "bill") as? SKSpriteNode
        self.totalBillLabel = bill?.childNode(withName: "totalBillLabel") as? SKLabelNode
        self.totalBillWithTaxLabel = bill?.childNode(withName: "totalBillWithTaxLabel") as? SKLabelNode
        
        self.box = tableNode?.childNode(withName: "box") as? SKSpriteNode
        self.cover = box?.childNode(withName: "cover") as? SKSpriteNode
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
    
    //MARK: - Progress bar methods
    
    //createPrograssBar
    func createPrograssBar(){
        
        // Get Prograss bar Continer node from scene and store it for use later
        self.progressBarContiner = self.childNode(withName: "progressbarContainer") as? SKSpriteNode
        self.progressBarContiner.anchorPoint   =   CGPoint(x: 0.5, y: -1)
        //Create Progress bar
        self.progressBar = SKSpriteNode(imageNamed: "progress-bar")
        self.progressBar.size = CGSize(width: 1, height: 20)
        progressBar.anchorPoint = CGPoint(x: 0, y: 0)
        progressBar.position = CGPoint(x: 98, y: 43)
        
        //Add progress bar to continer
        progressBarContiner?.addChild(progressBar)
    }
    
    //IncreaseProgressBar
    func increaseProgressBar(with custSat:CustmerSatisfaction) {
        
        let newWidth = (progressBar.size.width-custSat.barIncreasedByNum())
                
        // Scale up progress bar
        let scaleUpAction = SKAction.resize(toWidth: newWidth, duration: 1)
        //Run Action
        progressBar.run(scaleUpAction) {
            self.addFaceToProgressBar(on: newWidth,as: custSat)
        }
    }
    
    //addFaceToProgressBar
    func addFaceToProgressBar(on positionX:CGFloat,as satisfaction:CustmerSatisfaction){
        
        let face = SKSpriteNode(imageNamed: satisfaction.rawValue)
        face.anchorPoint = CGPoint(x:0.5, y: 0.5)
        face.size = CGSize(width: 22, height: 23)
        face.position = CGPoint(x: positionX+5, y: progressBar.size.height/2)
        face.zPosition = 3

        self.progressBar.addChild(face)
        let rotateToLeft = SKAction.rotate(byAngle: 1, duration: 0.5)
        let rotateToRight = SKAction.rotate(byAngle: -1, duration: 0.5)
        let sequence = SKAction.sequence([rotateToLeft,rotateToRight])
        
        //Run Action
        face.run(sequence)
        
    }
    
    //TO BE DELETED
    func buttonTapped(){
        print("tapped!")
        let score = viewController.calculateScore(for: Answer(base: Base.cake, cahnge: 0, atTime: 1, toppings: nil))
        let cusSat = CustmerSatisfaction.getCusSat(for: score)
        increaseProgressBar(with: cusSat)

    }
    
    func buttonTappedTwo(){
        print("tapped!")
        let score = viewController.calculateScore(for: Answer(base: nil, cahnge: 0, atTime: 1, toppings: nil))
        let cusSat = CustmerSatisfaction.getCusSat(for: score)
        increaseProgressBar(with: cusSat)
    }
    
    func buttonTappedThree(){
        print("tapped!")
        let score = viewController.calculateScore(for: Answer(base: Base.cake, cahnge: 0, atTime: 0, toppings: nil))
        let cusSat = CustmerSatisfaction.getCusSat(for: score)
        increaseProgressBar(with: cusSat)
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
    
    //MARK: -Pickup order functions
    func pickUpOrder(layer:CALayer){
        guard self.box != nil else {
            print("no box continer")
            return
        }
        
        //make payment visible
        self.box?.isHidden = false
        
        //positionate payment
        self.box?.position = CGPoint(x: 600, y: 230)
        
        layer.zPosition = 2
        layer.position = CGPoint(x: 600, y: 230)
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
        var timeInterval = duration/TimeInterval(steps)
        let incr = 1 / CGFloat(steps)
        var percent = CGFloat(1.0)

        let animate = SKAction.run { [self] in

            if(GameScene.circleDecrement )
            {percent -= incr}


            if(GameScene.timeLeft==0){
                percent = 1
                circle.path = nil

            }
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
            
            if( Int(GameScene.timeLeft)==0){
             print("اريج")
                circle.fillColor = SKColor(hue: 0, saturation: 0.5, brightness: 0.0, alpha: 0.0)
                self.removeAction(forKey: "stopTimer")
             }

        }
        let wait = SKAction.wait(forDuration:timeInterval)
        let action1 = SKAction.sequence([wait, animate])
        run(SKAction.repeatForever(action1), withKey: "stopTimer")


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
            print(GameScene.timeLeft.time)



        }
        else  if (Int(GameScene.timeLeft) > yellowTime){
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            GameScene.displayTime?.text = GameScene.timeLeft.time
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
//            GameScene.displayTime?.isHidden=false
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.displayTime?.text = "انتهى الوقت!"
            GameScene.displayTime?.color=SKColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0)

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
                GameScene.circle!.isHidden = true
                GameScene.circle?.alpha=0
                GameScene.timeLeft = 0
//                GameScene.circle = SKShapeNode(circleOfRadius: 0 )
//                self.removeAction(forKey: "stopTimer")
//                GameScene.circle!.removeFromParent()
                GameScene.countStop=0
//                GameScene.circle?.path = self.circle(radius: 0, percent: 0)
//                GameScene.circle=nil
                GameScene.timer.invalidate()
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
                            GameScene.timeLeft = 30
                            GameScene.TimerShouldDelay = false
                            viewController?.nextOrder()
                            

                        }

                        else {
                            print("THE LEVEL IS END")
                        }

                    }


                }


            }

            
  
        // Check Satisfcation bar
            if button.contains(location) {
                buttonTapped()
            }
            
            if buttonTwo.contains(location) {
                buttonTappedTwo()
            }
            
            if buttonThree.contains(location) {
                buttonTappedThree()
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

//        if(Int(GameScene.timeLeft)<=0){
//            print("Time left is zero ")
//            self.removeAction(forKey: "stopTimer")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                GameScene.circle?.path = self.circle(radius: 46, percent: 0)
//            }
//            GameScene.stopCircle=true
//
//        }
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







