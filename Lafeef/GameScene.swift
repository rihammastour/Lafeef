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
    var toopingAnswerCounter : Int = 0
    var moneyCounter : Int = 0
    var button: SKNode! = nil
    var OrderButton: SKNode! = nil
    var PaymentButton: SKNode! = nil
    let cam = SKCameraNode()
    static var flag = false
    
    var viewController: ChallengeViewController?
    
    //MARK:  Charachters  Variables
    var customers : [CustomerNode]=[]
    var currentCustomer = 0
    
    //MARK:  Nodes Variables
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    //Bakery Background
    private var bakeryBackgroundNode : SKNode?
    private var tableNode : SKSpriteNode?
    private var wallNode : SKSpriteNode?
    
    //Progress Bar
    private var progressBarContiner : SKSpriteNode!
    private var progressBar : SKSpriteNode!
    
    
    //Money Continer
    private var moneyCountiner : SKSpriteNode!
    var diffrenceDistancePBMC : CGFloat!
    var moneyLabel : SKLabelNode!
    
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
    private var baseAnswer : SKSpriteNode?
    
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
    
    
    var viewController2: UIViewController?
    //MARK: - Lifecycle Functons
    
    override func sceneDidLoad() {
        setupSceneElements()
        setUpCharacters()
    }
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        self.camera = cam
        addChild(cam)
        setCameraConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            self.buildCustomer(customerNode: self.customers[self.currentCustomer])
        }
        
        ChallengeViewController.stopImageBool=true
        circleShouldDelay()
        ObjectDetectionViewController.detectionOverlay.isHidden = false
        
    }
    
    //MARK: - Set up Scene Eslements Functions
    
    //setupSceneElements
    func setupSceneElements(){
        
        //Set background Bakery
        self.setBackgroundBakary()
        
        // Get table node from scene and store it for use later
        self.tableNode = bakeryBackgroundNode?.childNode(withName: "tableNode") as? SKSpriteNode
        tableNode?.zPosition = 2
        
        // Get Prograss bar Continer node from scene and store it for use later
        self.progressBarContiner = self.childNode(withName: "progressbarContainer") as? SKSpriteNode
        if let progressBar = self.progressBarContiner {
            progressBar.position = CGPoint(x: cam.position.x, y: (self.wallNode?.size.height)!-264)
            createPrograssBar()
        }
        
        // Get Money bar Continer node from scene and store it for use later
        setUpMoneyContiner()
        
        OrderButton = SKSpriteNode(imageNamed: "served")
        OrderButton.position = CGPoint(x: self.frame.midX, y:(self.tableNode?.frame.minY)!+(50))
        OrderButton.zPosition = 3
        self.addChild(OrderButton)
        
        PaymentButton  = SKSpriteNode(imageNamed: "paid")
        PaymentButton.position = CGPoint(x: self.frame.midX+600, y:(self.tableNode?.frame.minY)!+(50))
        PaymentButton.zPosition = 3
        self.addChild(PaymentButton)
        
        // Get Camera node from scene and store it for use later
        self.camera = cam
        
        // Get Order Continer node from scene and store it for use later
        self.orderContiner = self.childNode(withName: "orderContiner") as? SKSpriteNode
        self.orderContiner?.isHidden = true
        
        
        // Get Payment Continer node from scene and store it for use later
        self.paymentContainer = tableNode?.childNode(withName: "paymentContainer") as? SKSpriteNode
        self.paymentContainer?.isHidden = true
        
        self.bill = tableNode?.childNode(withName: "bill") as? SKSpriteNode
        self.totalBillLabel = bill?.childNode(withName: "totalBillLabel") as? SKLabelNode
        self.totalBillWithTaxLabel = bill?.childNode(withName: "totalBillWithTaxLabel") as? SKLabelNode
        
        self.box = tableNode?.childNode(withName: "box") as? SKSpriteNode
        self.cover = box?.childNode(withName: "cover") as? SKSpriteNode
        
    }
    
    //MARK: - Set Bakary Enviroment Function
    
    //setBackgroundBakary
    func setBackgroundBakary(){
        self.bakeryBackgroundNode = self.childNode(withName: "bakery")
        // Get table node from scene and store it for use later
        self.tableNode = bakeryBackgroundNode?.childNode(withName: "tableNode") as? SKSpriteNode
        tableNode?.zPosition = 2
        
        // Get wall node from scene and store it for use later
        self.wallNode = bakeryBackgroundNode?.childNode(withName: "wallNode") as? SKSpriteNode
        
    }
    
    //MARK: - Money Continer Functions
    func setUpMoneyContiner(){
        ///Set Position
        self.moneyCountiner = self.childNode(withName: "moneyContainer") as? SKSpriteNode
        moneyCountiner?.position = CGPoint(x: self.frame.maxX-100, y: (self.wallNode?.size.height)!-208)
        
        ///Calculate the distance between progress bar and money continer to use latter
        diffrenceDistancePBMC = moneyCountiner?.position.x ?? 0 - cam.position.x
        
        //Set Content of Money Continer
        ///Money Icon
        let moneyIcon = SKSpriteNode(imageNamed:"money") as SKSpriteNode?
        moneyIcon?.size = CGSize(width: 50, height: 50)
        moneyIcon?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        moneyIcon?.position = CGPoint(x: 40, y: 5)
        self.moneyCountiner?.addChild(moneyIcon!)
        
        ///Label
        moneyLabel = SKLabelNode()
        moneyLabel.position = CGPoint(x: -13, y: -8)
        moneyLabel.fontSize = 34
        moneyLabel.fontName = "FF Hekaya"
        moneyLabel.fontColor = SKColor(named: "BlackApp")
        moneyLabel.text = "0.0"
        self.moneyCountiner?.addChild(moneyLabel!)
        
    }
    
    //updateMoneyLabel
    func updateMoneyLabel(_ earnedMoney:Float){
        
        var money = Float(moneyLabel.text!)!
        money += earnedMoney
        moneyLabel.text = String(money)
        
    }
    
    
    //MARK: - Timer Continer Functions
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
        GameScene.circle!.position = CGPoint(x: 70, y: 95)
        
        GameScene.circle!.fillColor = SKColor(hue: 0.1861, saturation: 0.36, brightness: 0.88, alpha: 1.0)
        GameScene.circle!.strokeColor = SKColor.clear
        GameScene.circle!.zRotation = CGFloat.pi / 2
        self.orderContiner!.addChild(GameScene.circle!)
        self.countdown(circle: GameScene.circle!, steps: 30, duration: 30) {
            print("circle is done ")
        }
    }
    
    
    
    //MARK: -  Charachters Functions
    
    //setup Characters
    func setUpCharacters(){
        while customers.count <= 3  {
            let randomInt = Int.random(in: 1..<7)
            var choosenCustomer = Customers(rawValue: randomInt)?.createCustomerNode()
            customers.append(choosenCustomer!)
        }
    }
    
    //MARK: - Progress bar methods
    
    //createPrograssBar
    func createPrograssBar(){
        
        self.progressBarContiner.anchorPoint = CGPoint(x: 0.5, y: -1)
        //Create Progress bar
        self.progressBar = SKSpriteNode(imageNamed: "progress-bar")
        self.progressBar.size = CGSize(width: 1, height: 20)
        progressBar.anchorPoint = CGPoint(x: 0, y: 0)
        progressBar.position = CGPoint(x: 160, y: 43)
        
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
    
    
    //MARK: - Game Start Functions
    
    //buildCustomer
    func buildCustomer(customerNode: CustomerNode) {
        customerNode.buildCustomer()
        customerNode.customer.position = CGPoint(x: frame.midX-550, y: frame.midY-20)
        
        customerNode.walkingCustomer()
        ObjectDetectionViewController.detectionOverlay.isHidden = false
        
        //move to take cake
        let moveAction = SKAction.moveBy(x: 520 , y: 0 , duration: 3)
        
        let WaitingAction = SKAction.run({ [weak self] in
            customerNode.waitingCustomer()
        })
        let moveActionWithDone = SKAction.sequence([moveAction,WaitingAction] )
        
        //        customerNode.customer.run(moveActionWithDone, withKey:"sequence\(customerNode.customerName)")
        customerNode.customer.run(moveActionWithDone) {
            
            //make order visible
            self.showOrder()
            
            
        }
        
        // for cashier
        
        //        customerNode.customer.size = CGSize(width: 300, height: 350)
        addChild(customerNode.customer)
    }
    
    func showOrder(){
        self.orderContiner?.isHidden = false
        self.generateCircle()
        self.generateTimer()
    }
    
    func hideOrder(){
        self.orderContiner?.isHidden = true
        GameScene.circle?.isHidden = true
        GameScene.circle?.alpha=0
        GameScene.timer.invalidate()
        //GameScene.timeLeft = 0
        GameScene.countStop=0
    }
    
    //MARK: - Set Order and Payment Elements
    
    //MARK: Set up Order Contents Functions
    
    //setOrderContent
    func setOrderContent(with baseType:Base,_ toppings:[Topping]?){
        
        //unwrap order continer
        guard self.orderContiner != nil else {
            print("no order continer")
            return
        }
        
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
    
    
    //MARK: Node Creation for Order
    
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
    
    //MARK:  Set up Payment Contents Functions
    func setPaymentContent(with money:[Money]?){
        self.paymentContainer?.removeAllChildren()
        
        //unwrap payment continer
        guard self.paymentContainer != nil else {
            print("no payment continer")
            return
        }
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
        
        moneyCounter = 0
        
    }
  
    //MARK: Node Creation for Payment
    func createMoney(at position:PositionMoney,as money:Money){
        moneyCounter += 1
        let node = SKSpriteNode(imageNamed: "\(money.rawValue)")
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = position.getPosition()
        node.size = money.getMoneySize()
        node.zRotation = position.getZRotation()
        paymentContainer?.addChild(node)
    }
    
    //MARK: Payment Elements
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
    
    //MARK: Node Creation for Answer
    
    func packegeOrder(for answer:Answer){
        self.box?.removeAllChildren()
        //create base node
        self.baseAnswer = createAnswerBaseNode(with: answer.base!)
        
        //create topping node if any
        if let answerToppings = answer.toppings{
            
            for t in answerToppings {
                
                switch self.toopingAnswerCounter {
                case 0:
                    createAnswerTopping(at: PositionTopping.topRight(answer.base!),as: t)
                case 1:
                    createAnswerTopping(at: PositionTopping.topLeft(answer.base!),as: t)
                case 2:
                    createAnswerTopping(at: PositionTopping.bottomLeft(answer.base!),as: t)
                case 3:
                    createAnswerTopping(at: PositionTopping.bottomRight(answer.base!),as: t)
                default:
                    print("cannot add more than 4 toppings")
                }
            }
        }
        self.box?.addChild( self.baseAnswer! )
        self.box?.addChild( self.cover! )
        self.cover?.zPosition = 2
    }
    
    //create Answer Base
    func createAnswerBaseNode(with base:Base) -> SKSpriteNode{
        
        let node = SKSpriteNode(imageNamed: base.rawValue)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = CGPoint(x: 0, y: -30)
        
        
        //get base size depens on base type
        node.size = base.getAnswerBaseSize()
        return node
    }
    
    //create Answer Topping
    func createAnswerTopping(at position:PositionTopping,as topping:Topping){
        
        toopingAnswerCounter += 1
        
        let node = SKSpriteNode(imageNamed: topping.rawValue)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.position = position.getPosition()
        node.size = CGSize(width: 60, height: 60)
        node.zRotation = position.getZRotation(for: topping)
        
        baseAnswer?.addChild(node)
        
    }
    
    //MARK: - Check Answers
    
    // OrderbuttonTapped
    func checkOrderAnswer(){
        
        // Get answers provided
        let answer = (viewController?.objectDetected?.getAnswer())!
        
        //Handling detection overlay
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hideDetectionOverlay), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(showObjectsAfterCustomerArrive), userInfo: nil, repeats: false)
        
        //make order invisible
        hideOrder()
        
        //check base if provided
        if answer.base == nil {
            customerDone()
            customers[currentCustomer].moveOutSadly(customerNode: customers[currentCustomer])
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) { [self] in
                nextCustomer()}
            return
        }
        
        //Calculate the Scores
        viewController?.calculateOrderScore(for: answer)
        let custSat = CustmerSatisfaction.getOrderCusSat(for: viewController!.orderScore)
        
        //Bill calculation
        viewController?.calculateTotalBill(for: answer)
        viewController?.calculateTotalBillWithTax(for: answer)
        viewController?.showBill()
        self.paymentContainer?.isHidden = false

        
        //Walk to cashire and react
        walkToCashir(satisfaction: custSat)
        
        //Packege the order
        packegeOrder(for: answer)

    }
    
    
    // checkPaymentAnswer
    func checkPaymentAnswer(){
        print("Payment button tapped!")
        
        ObjectDetectionViewController.detectionOverlay.isHidden = false
        
        //get Answer payment
        let answer = viewController?.objectDetected?.getAnswer()
        
        //Calculate payment score
        viewController?.calculatePaymentScore(with: answer?.change ?? 0)
        
        //Get payment score for castumer satisfaction
        let customerSatisfaction = CustmerSatisfaction.getPeymentCusSat(for: viewController!.paymentScore)
        customerLeave(satisfaction: customerSatisfaction)
  
    }
    
    
    //MARK: - Customer movments
    func walkToCashir(satisfaction: CustmerSatisfaction){
        
        GameScene.flag = true
        customers[currentCustomer].movetoCashier(customerNode: customers[currentCustomer], customerSatisfaction: satisfaction)
    }
    
    func customerLeave(satisfaction: CustmerSatisfaction){
        GameScene.flag = false
        //Add money earned
        let moneEarned = (viewController?.getTotalBillWithTax())!
        updateMoneyLabel(moneEarned)
        
        //Customer Satsfaction bar
        customerDone()
        
        //Move Customer
        customers[currentCustomer].moveOut(customerNode: customers[currentCustomer], customerSatisfaction: satisfaction) { [self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.5) { [self] in
                
                let startPoint = CGPoint(x: 0, y: 0)
                let moveing = SKAction.move(to: startPoint, duration: 1)
                cam.run(moveing){
                    //                self.progressBarContiner.position.x = cam.position.x
                    self.nextCustomer()
                }
                
            }
            
        }
    }
    
    //MARK: - Customer handling
    
    func customerDone(){
        
        let totalScores = (viewController?.calculateTotalScore())!
        print("Total Score: ",totalScores)
        
        let satisfaction = CustmerSatisfaction.getTotalCusSat(for: totalScores)
        increaseProgressBar(with: satisfaction)
        viewController?.customersSatisfaction.append(satisfaction)
        print(viewController?.customersSatisfaction)

    }
    
    func nextCustomer(){
        currentCustomer += 1
        GameScene.timeLeft = 30
        if (currentCustomer<=3){
            print("داخل الاف الصغيره")
            buildCustomer(customerNode: customers[currentCustomer])
            GameScene.timeLeft = 30
            GameScene.TimerShouldDelay = false
            viewController?.nextOrder()
            
        } else {
            //                GameScene.timeLeft = 0
            //No more Customer Level end
            print("THE LEVEL IS END ")
            GameScene.timer.invalidate()
            viewController?.levlEnd()
        }
        
    }
    
    //MARK:- Detection Overlay
    
    
    @objc func hideDetectionOverlay(){
        ObjectDetectionViewController.detectionOverlay.isHidden = true
        print("hideDetectionOverlay")
    }
    
    
    @objc func showDetectionOverlay(){
        ObjectDetectionViewController.detectionOverlay.isHidden = false
        print("showDetectionOverlay")
    }
    
    @objc func showObjectsAfterCustomerArrive(){
        showDetectionOverlay()
        
        //show customer paid
        self.paymentContainer?.isHidden = false
    }
    
    
    
    //MARK: - Timer function
    
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
                checkOrderAnswer()
                
            }
            
        }
        let wait = SKAction.wait(forDuration:timeInterval)
        let action1 = SKAction.sequence([wait, animate])
        run(SKAction.repeatForever(action1), withKey: "stopTimer")
        
        
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.49){
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
            
            
            
        }
        else  if (Int(GameScene.timeLeft) > yellowTime){
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            GameScene.displayTime?.text = GameScene.timeLeft.time
            //yellow
            
        }
        
        else  if (GameScene.timeLeft > 0 ){
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.timeLeft = GameScene.endTime?.timeIntervalSinceNow ?? 0
            GameScene.displayTime?.text = GameScene.timeLeft.time
            //orange
            
        }
        else {
            //            GameScene.displayTime?.isHidden=false
            GameScene.displayTime?.fontName =  "FF Hekaya"
            GameScene.displayTime?.text = "انتهى الوقت!"
            GameScene.displayTime?.color=SKColor(hue: 0, saturation: 0.5, brightness: 0.95, alpha: 1.0)
            
            
            //call calculateScore
            GameScene.timer.invalidate()
            
        }
    }
    //MARK:- Buttons Tapped methods
    
    func OrderbuttonTapped(){
        checkOrderAnswer()
    }
    func PaymentbuttonTapped(){
        checkPaymentAnswer()
    }
    
    //MARK: - Touch Actions Functions
    
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
            
            if OrderButton.contains(location) {
                OrderbuttonTapped()
            }
            if PaymentButton.contains(location) {
                PaymentbuttonTapped()
            }
            
        }
    }
    
    
    //override touchesCancelled
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    //MARK:- override Update Function
    //override update
    override func update(_ currentTime: TimeInterval) {
        
        if (GameScene.flag){
            
            cam.position = CGPoint(x: customers[currentCustomer].customer.position.x, y: 0)
            
        }
        
        self.progressBarContiner.position.x = cam.position.x
        moneyCountiner.position.x = cam.position.x + diffrenceDistancePBMC
        
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
    
    
    //    @objc func showDetectionOverlay(){
    //        print("inside showDetectionOverlay ")
    //  customers[currentCustomer].customer.position.x == -36.000091552734375 {
    //            print("inside if statement in showDetectionOverlay ")
    //            ObjectDetectionViewController.detectionOverlay.isHidden = false
    //            // I think its 480 x and -320 y
    ////                    ObjectDetectionViewController.detectionOverlay.position = CGPoint(x:600, y:230)
    //        }
    //    }
    
    
    //MARK:- Constrains Functos
    private func setCameraConstraints() {
        
        let scaledSize = CGSize(width: size.width * cam.xScale, height: size.height * cam.yScale)
        
        guard let bekary = bakeryBackgroundNode else {
            return
        }
        let boardContentRect = bekary.calculateAccumulatedFrame()
        let xInset = min((scaledSize.width / 2) + 100, (boardContentRect.width / 2.5)  )
        let yInset = min((scaledSize.height / 2) - 100.0, boardContentRect.height / 2)
        let insetContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)
        let xRange = SKRange(lowerLimit: 0, upperLimit: insetContentRect.maxX)
        let yRange = SKRange(lowerLimit: insetContentRect.minY, upperLimit: insetContentRect.maxY)
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        levelEdgeConstraint.referenceNode = bekary
        
        cam.constraints = [levelEdgeConstraint]
    }
    
}
