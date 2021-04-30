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
import AVFoundation
import Vision
import ARKit
import Speech

class ChallengeViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate,SFSpeechRecognizerDelegate {
    
    //MARK: - Proprites
    
    //IBOutlet
    @IBOutlet var previewView: UIView!
    @IBOutlet weak var stopGame: UIButton!
    
    //Variables
    var levelNum:String!
    var currentOrder = 0
    var duration:Float?
    var orders:[Order] = []
    var money:[Money]?
    var alert = AlertService()
    var voice = Voice2ViewController()
    var sound = SoundManager()
    
    
    
    //Scores and Report Variables
    var levelScore: Float = 0.0
    var orderScore = 0
    var paymentScore = 0
    var isPassed = false
    var customersSatisfaction : [CustmerSatisfaction] = []
    
    var challengeScen:GameScene?
    var delegate:ManageViewController!
    
    
    static var stopCircleNil=false//when stop the nil circle
    static var stopImageBool = true
    var stopImage = UIImage(named: "stopGame")
    var  pauseImage = UIImage(named: "Pause")
    
    var layer: CALayer! = nil
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer! = nil
    let videoDataOutput = AVCaptureVideoDataOutput()
    
    let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    var objectDetected: ObjectDetectionViewController?
    var isPaymentModelUsed: Bool = false

    var answerArray = [VNRecognizedObjectObservation]()
    var answerLabels = [String]()
    
    var totalBill:Float = 0.0
    var tax:Float = 0.0
    //Report
    var report:DailyReport = DailyReport(levelNum: "", ingredientsAmount: 20, salesAmount: 0, backagingAmount: 20, advertismentAmount: 0, collectedScore: 0, collectedMoney: 0, isPassed: false, isRewarded: false, reward: 0, customerSatisfaction: [])
    //Advertisment
    var randomAdv:Int!
    
    //Outlet
    @IBOutlet weak var gameScen: SKView!
    
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        setupAVCapture()
        setScene()
        reflectAdv()
        fetchChallengeLevel()
        
        challengeScen?.startGame()
    }
    
    //MARK: - Unpleaced method propirty
    
    func displayAdvReport(){
        let levelTwoCount = UserDefaults.standard.integer(forKey: "levelTwoCount")
        let levelFourCount = UserDefaults.standard.integer(forKey: "levelFourCount")
        
        
        if report.levelNum == "2" && levelTwoCount < 1  || report.levelNum == "4"  && levelFourCount < 1{
            self.performSegue(withIdentifier: Constants.Segue.showAdvReport, sender: self)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                // self.presentAdvReport()
                
            }
        }else{
            challengeScen?.startGame()
        }
        
    }
    
    //MARK: -Set up UI Element
    
    //setScens
    func setScene(){
        
        challengeScen = gameScen.scene as! GameScene
        challengeScen?.viewController = self
        challengeScen?.scaleMode = SKSceneScaleMode.aspectFill
        
        
    }
    
    func reflectAdv(){
        if(report.advertismentAmount>0){
            self.challengeScen?.showAdvInbakery(at: randomAdv)
        }
    }
    
    
    //MARK: -Set up Object Detection
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAVCapture() {
        var deviceInput: AVCaptureDeviceInput!
        
        // Select a video device, make an input
        guard  let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else{
            dismiss(animated: true)
            return
        }
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
        } catch {
            print("Could not create video device input: \(error)")
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .vga640x480 // Model image size is smaller.
        
        // Add a video input
        guard session.canAddInput(deviceInput) else {
            print("Could not add video device input to the session")
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            print("device22")
            // Add a video data output
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            print("Could not add video data output to the session")
            session.commitConfiguration()
            return
        }
        let captureConnection = videoDataOutput.connection(with: .video)
        // Always process the frames
        captureConnection?.isEnabled = true
        print("before do ")
        do {
            try  videoDevice.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice.activeFormat.formatDescription))
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice.unlockForConfiguration()
            print("inside do ")
        } catch {
            print(error)
        }
        session.commitConfiguration()
        print("111")
        let spriteScene = SKScene(fileNamed: "GameScene")
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //flip camera upside down
        //            previewLayer.connection?.videoOrientation = .portraitUpsideDown
        rootLayer = previewView.layer
        
        if let skView = gameScen {
            skView.presentScene(spriteScene)
        }
        
        
        rootLayer.addSublayer(previewLayer)
        
    }
    
    func startCaptureSession() {
        print("startcapture")
        session.startRunning()
    }
    
    func stopSession(){
        print("Override stopSession ")
    }
    
    // Clean up capture setup
    func teardownAVCapture() {
        previewLayer.removeFromSuperlayer()
        previewLayer = nil
        print("tearDownAVCapture-----------------------")
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // print("frame dropped")
    }
    
    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
            exifOrientation = .upMirrored
        default:
            exifOrientation = .upMirrored
        }
        return exifOrientation
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // to be implemented in the subclass
    }
    
    
    //MARK: - Orders Functions
    
    //fethChallengeLevel
    func fetchChallengeLevel(){
        
        guard let levelNum = self.levelNum else {
            //TODO: Alert and go back
            showAlert(with: "لا يوجد طلبات لهذا اليوم", isSuccess: false)//Not working
            return
        }
        
        FirebaseRequest.getChallengeLvelData(for: levelNum, completion:feachChallengeLevelHandler(_:_:))
        
    }
    
    //setLevelInfo
    func setLevelInfo(_ level:Level) -> Void {
        self.duration = level.duration
        for order in level.orders{
            self.setOrder(order: order)
        }
        //Show First Order
        showOrder(at: currentOrder)
    }
    
    func setOrder(order: Order){
        self.orders.append(order)
    }
    
    //showOrder
    func showOrder(at number:Int) -> Void {
        let order = orders[number]
        let base = order.base
        let toppings = order.toppings
        challengeScen?.setOrderContent(with: base, toppings)
        showCustomerPaid(at: number)
        calculateTotalBillWithTax(at: number)
        calculateTotalBill(at: number)
        
    }
    
    func showCustomerPaid(at number:Int) -> Void {
        let order = orders[number]
        let customerPaied = order.customerPaid
        
        let money = CustomerPaied.convertToMoney(customerPaied: customerPaied)
        challengeScen?.setPaymentContent(with: money)
    }
    
    func showBill() -> Void {
    
        let totalBillRounded = Float(round(100*getTotalBill())/100)
        let taxRounded = Float(round(100*getTotalTax())/100)
        
        let totalBillWithTaxRounded = Float(round(10*getTotalBillWithTax())/10) 
        
        challengeScen?.setTotalBill(totalBill: totalBillRounded, tax: taxRounded)
        challengeScen?.setTotalBillWithTax(totalBillWithTax: totalBillWithTaxRounded)
        report.salesAmount += totalBillWithTaxRounded
    }
    
    
    //nextOrder
    func nextOrder(){
        if currentOrder <= 3{
            currentOrder = currentOrder + 1
            showOrder(at: currentOrder)
        }else{
            levelEnd()
            print("Called by Challenge")
        }
    }
    
    //MARK: - Calculate Score
    
    //calculateScore
    func calculateTotalScore() -> Int {
        
        //Sum customer scors
        let orderScore = self.paymentScore + self.orderScore
        //Add it to level Score
        self.levelScore += Float(orderScore)
        //Reset to zero
        self.paymentScore = 0
        self.orderScore = 0
        
        return orderScore
    }
    
    
    func calculatePaymentScore(with chenge:Float){
     
        let totalBillWithTax = Float(round(10*getTotalBillWithTax())/10)
        let expectedChange = getCurrentOrder()!.customerPaid - totalBillWithTax
        print("expectedChange", expectedChange)
        if expectedChange == chenge {
            self.paymentScore = 1
        }else{
            self.paymentScore = 0
        }
        print("Payment Scoren : ",self.paymentScore)
        isPaymentModelUsed = false
        objectDetected?.setupVision()
        
    }
    
    func scaleLevelScore() ->Float {
        //to scale score to 100
        let scaleFactor: Float = 6.25
        let scaledLevelscore = self.levelScore * scaleFactor
        
        return scaledLevelscore
    }
    
    
    func calculateTotalBill(at number: Int) {
        //reset totalBill
        self.totalBill = 0
        
        let order = orders[number]
        //get Order base  and toppings
        let base = order.base
        let orderToppings = order.toppings
        
        guard base != nil else {
            self.totalBill = 0
            return
        }
        
        self.totalBill = (base.getPrice())
        
        guard let toppings = orderToppings else {
            //No Toppings
            return
        }
        
        //Calculate Toppings prices
        for t in toppings {
            self.totalBill += t.getPrice()
        }
        
        
    }
    
    func calculateTotalBillWithTax(at number: Int){
        //reset tax
        self.tax = 0
        
        let order = orders[number]
        //get Order base  and toppings
        let base = order.base
        let orderToppings = order.toppings
        
        guard base != nil else {
            self.tax = 0
            return
        }
        
        self.tax = base.getTax()
        
        guard let toppings = orderToppings else {
            //No Toppings
            return
        }
        
        for t in toppings {
            tax += t.getTax()
        }
        
    }
    
    func getTotalBill() -> Float{
        return self.totalBill
    }
    
    func getTotalTax() -> Float{
        return self.tax
    }
    
    func getTotalBillWithTax() -> Float{
        return self.totalBill + self.tax
    }
    
    //calculateOrderScore
    func calculateOrderScore(for answer:Answer) {
        var totalSocre = 0
        
        //Declaration variabels
        let currentOrder = getCurrentOrder()!
        let currentToppings = currentOrder.toppings
        
        let providedToppings = answer.toppings
        
        //Check Base
        
        //check base type
        if answer.base == currentOrder.base{
            totalSocre += 1
        }else if currentToppings == nil {
            //Order doesn't contain toppings and wrong base
            totalSocre += 0
            return
        }
        
        //Checking Topping
        //check if there're toppings - nil means correct type and number
        if providedToppings == nil && currentToppings == nil{
            
            totalSocre += 2
        }else if var toppings = providedToppings {
            
            //check toppings number
            if providedToppings?.count == currentToppings?.count {
                totalSocre += 1 }
            
            //check toppings type
            var i = 0
            for t in toppings{
                if ((currentToppings?.contains(t)) == true) {
                    toppings.remove(at: i)
                }else{
                    i += 1}
            }
            
            if (toppings.isEmpty){
                totalSocre += 1
            }
            
        }
        
        self.orderScore = totalSocre
        print("Order Score :  ",self.orderScore)
        isPaymentModelUsed = true
        objectDetected?.setupVision()
    }
    
    //getCurrentOrder
    func getCurrentOrder() ->  Order? {
        return (self.orders[currentOrder])
    }
    
    //MARK:- Actions
    
    @IBAction func stopGameTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.puaseGameViewController) as? PauseGameViewController{
            self.sound.player?.stop()

            vc.challengeScen = self.challengeScen
            vc.delegate = self.delegate
            vc.sound = sound
            
            if(challengeScen?.timer==nil){
                challengeScen?.timeLeft = 0//make the circle green when stop before custmer arrive

                ChallengeViewController.stopCircleNil=true
                GameScene.circle?.isHidden=true
                ChallengeViewController.stopImageBool=false
                
            }else{
                challengeScen?.timeLeft = challengeScen!.timeLeft
                DispatchQueue.main.async {
                    self.challengeScen?.timer.invalidate()
                }
                
            }
            //Boolean variables
            GameScene.circleDecrement=false
            GameScene.circle?.isPaused=true
            challengeScen?.isPaused=true
            ChallengeViewController.stopImageBool=false
            present(vc, animated: true,completion:nil)
            
        }
}
    
    
    
    
    
    
    //MARK: - Level Ends
    
    func levelEnd() {
        ObjectDetectionViewController.detectionOverlay.isHidden = true
        let scaledScore = scaleLevelScore()
        report.collectedScore = scaledScore
        report.collectedScore = 49

        report.isPassed = checkLevelPassed()
        
        //Set report attribute
        ///Customer Satisfaction and level number
        report.customerSatisfaction = customersSatisfaction
        report.levelNum = self.levelNum
        
        self.dismiss(animated: true, completion: {
            self.delegate.displayDailyReport(self.report)
        })
        
    }
    
    //check if child pass the level
    func checkLevelPassed()->Bool{
        print("report.collectedScore in Challenge ",report.collectedScore)
        if report.collectedScore >= 50.0 {
            return true
        }else{
            return false
        }
    }
    
    
    func checkLevelCompletion(){
        
        if report.collectedScore  > 20 {
            report.isPassed = true
        }
    }
    //MARK: - Delegate handeler
    
    //showAlert
    func showAlert(with message:String, isSuccess: Bool) {
        ObjectDetectionViewController.detectionOverlay.isHidden = true
        self.present(alert.Alert(body: message, isSuccess: isSuccess), animated: true)
        
    }
    
    //feachChalengeLevelHandeler
    func feachChallengeLevelHandler(_ data:Any?,_ err:Error?) -> Void {
        
        if err != nil{
            print("Challenge View Controller",err!)
            
            if err?.localizedDescription == "Failed to get document because the client is offline."{
                self.present(alert.Alert(body: "لطفًا، تأكد من اتصالك بالإنترنت", isSuccess: false), animated: true)
                print("تأكد من اتصال الانترنيت")
                //TODO: Alert and update button and go back
            }
            print("No  Orders  ")
            
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
