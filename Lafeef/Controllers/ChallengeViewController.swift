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

class ChallengeViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet var previewView: UIView!
    @IBOutlet weak var stopGame: UIButton!
    //MARK: - Proprites
    
    //Variables
    static var levelNum:String? = "2"
    static var currentOrder = 0
    var duration:Float?
    var orders:[Order]?
    var money:[Money]?
    var alert = AlertService()
    var report = DailyReport(levelNum: "2", ingredientsAmount: 50, salesAmount: 0, backagingAmount: 20, advertismentAmount: 0, collectedScore: 0, collectedMoney: 0, isPassed: false, isRewarded: false, reward: 0, customerSatisfaction:[])
    
    //Scores and Report Variables
    var levelScore: Float = 0.0
    var orderScore = 0
    var paymentScore = 0
    var isPassed = false
    var customersSatisfaction : [CustmerSatisfaction] = []
    
    var challengeScen:GameScene?


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
    var answerArray = [VNRecognizedObjectObservation]()
    var answerLabels = [String]()
    
    var totalBill:Float = 0.0
    var tax:Float = 0.0
    
    //self.stopGame.setBackgroundImage(stopImg, for: UIControl.State.normal)
    
    //Outlet
    @IBOutlet weak var gameScen: SKView!
    

    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        setupAVCapture()   
        setScene() 
//
//        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//            self.displayLevelGoal()
//        }
        
        fetchChallengeLevel()
        
        if ChallengeViewController.levelNum == "2" || ChallengeViewController.levelNum == "4" {
            self.performSegue(withIdentifier: Constants.Segue.showAdvReport, sender: self)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.presentAdvReport()
                
            }
        }else{
            challengeScen?.startGame()
        }
        
        
        

    }

    //MARK: -Set up UI Element
    
    //setScens
    func setScene(){
        
        self.challengeScen = gameScen.scene as! GameScene
        self.challengeScen?.viewController = self
        self.challengeScen?.scaleMode = SKSceneScaleMode.aspectFill
        
    }

    func displayLevelGoal(){
        print("display")
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let goalVC = storyboard.instantiateViewController(withIdentifier:Constants.Storyboard.LevelGoalViewController) as! LevelGoalViewController
        goalVC.scene = self.challengeScen
        self.present(goalVC, animated: true)
        
    }
    //MARK: -Set up Object Detection
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAdvReport(){
        let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
        let advVC = storyboard.instantiateViewController(withIdentifier:Constants.Storyboard.advReportViewController) as! AdvReportViewController
        advVC.scene = self.challengeScen

        self.present(advVC, animated: true) {
          //  GameScene.startGame()
        }
//        self.performSegue(withIdentifier: Constants.Segue.showAdvReport, sender: self)

    }
    
    func showAdvOnBakery(){
        if AdvReportViewController.randomNum == 1 {
            GameScene.presentAdvertisment(at: 1)

            print("inside adv")
        } else if AdvReportViewController.randomNum == 2 {
            GameScene.presentAdvertisment(at: 2)
            print("inside adv2")
        }
    }
    
    func setupAVCapture() {
        print("setup without override")
        var deviceInput: AVCaptureDeviceInput!
        
        // Select a video device, make an input
        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
            
            print("device")
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
            try  videoDevice!.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice!.unlockForConfiguration()
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
        
        guard let levelNum = ChallengeViewController.levelNum else {
            //TODO: Alert and go back
            showAlert(with: "لا يوجد طلبات لهذا اليوم")//Not working
            return
        }
        
        FirebaseRequest.getChallengeLvelData(for: levelNum, completion:feachChallengeLevelHandler(_:_:))
        
    }
    
    //setLevelInfo
    func setLevelInfo(_ level:Level) -> Void {
        self.duration = level.duration
        self.orders = level.orders
        //Show First Order
        showOrder(at: ChallengeViewController.currentOrder)
    }
    
    //showOrder
    func showOrder(at number:Int) -> Void {
        let order = orders![number]
        let base = order.base
        let toppings = order.toppings
        self.challengeScen?.setOrderContent(with: base, toppings)
        showCustomerPaid(at: number)

    }
    
    func showCustomerPaid(at number:Int) -> Void {
        let order = orders![number]
        let customerPaied = order.customerPaid
        
        let money = CustomerPaied.convertToMoney(customerPaied: customerPaied)
        print("money", money)
        self.challengeScen?.setPaymentContent(with: money)
    }
    
    func showBill() -> Void {
        let totalBillRounded = Float(round(100*getTotalBill())/100)
        let taxRounded = Float(round(100*getTotalTax())/100)
        
        let totalBillWithTaxRounded = Float(round(10*getTotalBillWithTax())/10)
        
        self.challengeScen?.setTotalBill(totalBill: totalBillRounded, tax: taxRounded)
        self.challengeScen?.setTotalBillWithTax(totalBillWithTax: totalBillWithTaxRounded)
        
    }
    
    
    //nextOrder
    func nextOrder(){
        if ChallengeViewController.currentOrder <= 3{
            ChallengeViewController.currentOrder = ChallengeViewController.currentOrder + 1
            showOrder(at: ChallengeViewController.currentOrder)
        }else{
            //TODO:End Level
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
        //        ChallengeViewController.report.ingredientsAmount += totalBill
        //        ChallengeViewController.report.salesAmount += totalBill
        let expectedChange = getCurrentOrder()!.customerPaid - getTotalBillWithTax()
        print("expectedChange", expectedChange)
        if expectedChange == chenge {
            self.paymentScore = 1
        }else{
            self.paymentScore = 0
        }
        print("Payment Scoren : ",self.paymentScore)
        
    }
    
    func scaleLevelScore() ->Float {
        //to scale score to 100
        let scaleFactor: Float = 6.25
        let scaledLevelscore = self.levelScore * scaleFactor
        
        return scaledLevelscore
    }
    

    func calculateTotalBill(for providedAnswer: Answer) {
        //reset totalBill
        self.totalBill = 0
        
        //get Order base  and toppings
        let providedBase = providedAnswer.base
        let providedToppings = providedAnswer.toppings
        
        guard providedBase != nil else {
            self.totalBill = 0
            return
        }
        
        self.totalBill = (providedBase!.getPrice())
        
        guard let toppings = providedToppings else {
            //No Toppings
            return
        }
        
        //Calculate Toppings prices
        for t in toppings {
            self.totalBill += t.getPrice()
        }
        
   
    }
    
    func calculateTotalBillWithTax(for providedAnswer: Answer){
        //reset tax
        self.tax = 0
        
        //get Order
        let providedBase = providedAnswer.base
        let providedToppings = providedAnswer.toppings
        
        guard providedBase != nil else {
            self.tax = 0
            return
        }
        
        self.tax = providedBase!.getTax()
        
        guard let toppings = providedToppings else {
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
    }
    
    //getCurrentOrder
    func getCurrentOrder() ->  Order? {
        return (self.orders?[ChallengeViewController.currentOrder])
    }
    
    //MARK: - Level Ends
    
    func levlEnd() {
        
        checkLevelPassed()
        
        let levelScore = scaleLevelScore()
        print("levelEnd", levelScore)
        //Create Report
        let report = DailyReport(levelNum: ChallengeViewController.levelNum!, ingredientsAmount: 50, salesAmount: 0, backagingAmount: 20, advertismentAmount: 0, collectedScore: levelScore, collectedMoney: 0, isPassed: self.isPassed, isRewarded: true, reward: 0, customerSatisfaction: customersSatisfaction)
        
        DispalyReport(report)
    }
    
    //check if child pass the level
    func checkLevelPassed(){
        if scaleLevelScore() > 50.0 {
            isPassed = true
        }else{
            isPassed = false
        }
    }
    
    func DispalyReport(_ report:DailyReport){
        
//                self.present(report.displayDailyReport(), animated: true)
                self.performSegue(withIdentifier: Constants.Segue.showDailyReport, sender: self)
    }
    
    
    //MARK: - Delegate handeler
    
    //showAlert
    func showAlert(with message:String) {
        //        alert.Alert(body: message)
        // need an alert
    }
    
    //feachChalengeLevelHandeler
    func feachChallengeLevelHandler(_ data:Any?,_ err:Error?) -> Void {
        
        if err != nil{
            print("Challenge View Controller",err!)
            
            if err?.localizedDescription == "Failed to get document because the client is offline."{
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
    
    func checkLevelCompletion(){

        if report.collectedScore  > 50 {
           report.isPassed = true
        }
    }
    
    //override func prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier.da
        
        if segue.identifier == Constants.Segue.menuSegue {
            let vc = segue.destination as! PauseGameViewController
            print("Segue proformed")
            if(GameScene.circle==nil){
                GameScene.circleDecrement=false
                GameScene.timeLeft = 2000//make the circle green when stop before custmer arrive
                GameScene.timer.invalidate()
                ChallengeViewController.stopCircleNil=true
                GameScene.circle?.isHidden=true
                ChallengeViewController.stopImageBool=false
                //                changeStopImage(_sender:ChallengeViewController.stopImageBool)
                //                changeStopImage()
                
            }else{
                GameScene.timeLeft = GameScene.timeLeft
                GameScene.timer.invalidate()
                GameScene.circleDecrement=false
                GameScene.circle!.isPaused=true
                ChallengeViewController.stopImageBool=false
                print(GameScene.timeLeft.time)
                //                changeStopImage(_sender:ChallengeViewController.stopImageBool)
                //                changeStopImage()
                //            vc.levelNum = "1"
            }
        }
        
    }
    
    
    
}

