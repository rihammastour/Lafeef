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
    //MARK: - Proprites
    //Variables
    var levelNum:String? = "4"
    var currentOrder = 1
    var duration:Float?
    var orders:[Order]?
    var money:[Money]?
    var alert = AlertService()
    var challengeScen:GameScene?
    
    var layer: CALayer! = nil
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
    private let videoDataOutput = AVCaptureVideoDataOutput()
       
    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)

    
    //Outlet
    @IBOutlet weak var gameScen: SKView!
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAVCapture()
       
        
        // Additional setup after loading the view.
        setScene()
        fetchChallengeLevel()
      }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func setupAVCapture() {
            print("setup without override")
            var deviceInput: AVCaptureDeviceInput!
            
            // Select a video device, make an input
            let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first
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
            previewLayer.connection?.videoOrientation = .portraitUpsideDown
            rootLayer = previewView.layer
        
            if let skView = gameScen {
                      skView.presentScene(spriteScene)
                  }
             
  
            rootLayer.addSublayer(previewLayer)
//
        }
        
        func startCaptureSession() {
            print("startcapture")
            session.startRunning()
        }
        
        // Clean up capture setup
        func teardownAVCapture() {
            previewLayer.removeFromSuperlayer()
            previewLayer = nil
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
        
    
    //MARK: -Set up UI Element
    
    //setScens
    func setScene(){
        
        self.challengeScen = gameScen.scene as! GameScene
        
    }
    
    //MARK: - Functions
    
    //fethChallengeLevel
    func fetchChallengeLevel(){
        
        guard let levelNum = levelNum else {
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
        showOrder(at: currentOrder) // must be Moved to be called by character
        showCustomerPaid(at: currentOrder)
        showBill(at: currentOrder) 
        print(calculatePaymentScore(with: 0)) //must be Moved to be called after user provid the answer
    }
    
    //showOrder
    func showOrder(at number:Int) -> Void {
        let order = orders![number]
        let base = order.base
        let toppings = order.toppings
        self.challengeScen?.setOrderContent(with: base, toppings)
    }
    
    func showCustomerPaid(at number:Int) -> Void {
        let order = orders![number]
        let customerPaied = order.customerPaid
        
        let money = CustomerPaied.convertToMoney(customerPaied: customerPaied)
        self.challengeScen?.setPaymentContent(with: money)
    }
    
    func showBill(at number:Int) -> Void {
        let totalBillWithoutTax = calculateTotalBill()
        let withoutTaxRounded = Float(round(100*totalBillWithoutTax)/100)
        let tax = calculateTotalBillWithTax()
        let taxRounded = Float(round(100*tax)/100)
        let totalBillWithTax = totalBillWithoutTax + tax
        let totalBillWithTaxRounded = Float(round(10*totalBillWithTax)/10)

        self.challengeScen?.setTotalBill(totalBill: withoutTaxRounded, tax: taxRounded)
        self.challengeScen?.setTotalBillWithTax(totalBillWithTax: totalBillWithTaxRounded)
    }
    
    func pickingUpOrder(){
        self.challengeScen?.pickUpOrder(layer:layer)
    }
    
    //nextOrder
    func nextOrder(){
        if currentOrder <= 3{
            currentOrder = currentOrder + 1
            showOrder(at: currentOrder)
        }else{
            //TODO:End Level
        }
    }
    
    //MARK: - Calculate Score

    //calculateScore
    func calculateScore(for answer:Answer?) -> Int{
         
         //Unwrap current order
         guard getCurrentOrder() != nil else {
             //Fail umwrapping
             return 0
         }
         
         guard let answer = answer else {
             //No answer provided!
             return 0
         }
         
         //check time
         if (answer.atTime == 0){ //May changed
             return 0
         }
         
         //get order score
         let orderScore = calculateOrderScore(for: answer)
         //get payment score
         let paymentScore = calculatePaymentScore(with: answer.cahnge)
         
         //Sum scors
         let totalScore = paymentScore + orderScore
         print("Total order score :", orderScore,"\t Total order score :", paymentScore)
         print("Total score :", totalScore)
         return totalScore
     }
     

    func calculatePaymentScore(with chenge:Float) -> Int{
           
           let totalBill = getTotalBill()
        let expectedChange = getCurrentOrder()!.customerPaid - totalBill

           if expectedChange == chenge {
               return 1
           }else{
               return 0
           }
           
       }
    
    func calculateTotalBill()->Float{
        
        //get Order
        let currentOrder = orders?[self.currentOrder]
        let currentToppings = currentOrder?.toppings
        
        
        guard currentOrder != nil else {
            return 0
        }
        
        var total:Float = (currentOrder?.base.getPrice())!
        
        guard let toppings = currentToppings else {
            return total
        }
        
        for t in toppings {
            total += t.getPrice()
        }


        return total
        
    }
    
    func calculateTotalBillWithTax()->Float{
        
        //get Order
        let currentOrder = orders?[self.currentOrder]
        let currentToppings = currentOrder?.toppings
        
        
        guard currentOrder != nil else {
            return 0
        }
        
        var tax:Float = (currentOrder?.base.getTax())!
        
        guard let toppings = currentToppings else {
            return tax
        }
        
        for t in toppings {
            tax += t.getTax()
        }
        return tax
        
    }

    
    //calculateOrderScore
    func calculateOrderScore(for answer:Answer) -> Int {
        
        var totalSocre = 0
        
        //Declaration variabels
        let currentOrder = getCurrentOrder()!
        let currentToppings = currentOrder.toppings
        
        let providedToppings = answer.toppings
        //Check Base
        
        //check base if exist
        if answer.base == nil {
            return totalSocre
        }
        
        //check base type
        if answer.base == currentOrder.base{
            totalSocre += 1
        }else if currentToppings == nil {
            //Order doesn't contain toppings and wrong base
            return totalSocre
        }
        
        //Start checking the toppings
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
        
        return totalSocre
        
    }
    func getCurrentOrder() ->  Order? {
         return (self.orders?[self.currentOrder])
     }
     
     //getTotalBill
     func getTotalBill()->Float{
         
         //get Order base  and toppings
         let currentOrder = getCurrentOrder()!
         let currentToppings = currentOrder.toppings
         
        var total:Float = (currentOrder.base.getPrice())
         
         guard let toppings = currentToppings else {
             //No Toppings
             return total
         }
         
         //Calculate Toppings prices
         for t in toppings {
             total += t.getPrice()
         }
         
         return total
         
     }
    //MARK: - Delegate handeler
    
    //showAlert
    func showAlert(with message:String) {
        alert.Alert(body: message)
    }
    
    //feachChalengeLevelHandeler
    func feachChallengeLevelHandler(_ data:Any?,_ err:Error?) -> Void {
        
        if err != nil{
            print("Challenge View Controller",err!)
            
            if err?.localizedDescription == "Failed to get document because the client is offline."{
                print("تأكد من اتصال الانترنيت")
                //TODO: Alert and update button and go back
            }
            
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
