//
//  TrainingBoardViewController.swift
//  Lafeef
//
//  Created by Raghad alfuhaid on 20/08/1442 AH.
//

import Foundation
import UIKit
import CodableFirebase
import AVFoundation
import Vision
import Lottie



class TrainingBoardViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate{
    @IBOutlet weak var nextlOutlet: UIButton!
    @IBOutlet weak var skiplOutlet: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var strawberry: UIImageView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var bubleView: UIImageView!
    @IBOutlet weak var animationContainer: UIView!
    private var animationView: AnimationView?
    
    var section:String = TrainingSectionViewController.sectionType
    var questionDetailes: [TrainingQuestions]?
    var questionId: Int = 0 // update it in next button or skip
    var answer: [String] = []
    var infoView:UIView!
    let sound = SoundManager()
    var isCorrect = false
    var layer: CALayer! = nil
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer! = nil
    let videoDataOutput = AVCaptureVideoDataOutput()
    
    let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    var objectDetected: ObjectDetectionTrainingViewController?
    var answerArray = [VNRecognizedObjectObservation]()
    var answerLabels = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "blank-bakery")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        nextlOutlet.layer.cornerRadius =  nextlOutlet.frame.size.height/2
        
        skiplOutlet?.layer.cornerRadius =  skiplOutlet.frame.size.height/2
        
        // make multiline
        QuestionLabel.numberOfLines = 0
        QuestionLabel.lineBreakMode = .byWordWrapping
        QuestionLabel.frame.size.width = 300
        QuestionLabel.sizeToFit()
        
        getTrainingQuestion()
        setInfoView()
        //        infoLabel?.isHidden = true
        
        setupAVCapture()
    }
    
    func setInfoView(){
        self.strawberry.layer.zPosition = 1
        self.animationView = AnimationView()
        hideAnswerIndication()
    }
    
    
    func getTrainingQuestion(){
        FirebaseRequest.getTrainingQuestionsData(for: section, completion: feachTrainingQuestionHandler(_ :_:))
    }
    
    //feachTrainingQuestionHandler
    func feachTrainingQuestionHandler(_ data:Any?,_ err:Error?) -> Void {
        
        if err != nil{
            print("Training board View Controller",err!)
            
            if err?.localizedDescription == "Failed to get document because the client is offline."{
                print("تأكد من اتصال الانترنيت")
                //TODO: Alert and update button and go back
                
            }
            print("No  questions")
            
        }else{
            
            do{
                //Convert data to type Question
                let question = try FirebaseDecoder().decode(Questions.self, from: data!)
                self.setTrainingQuestionInfo(question: question)
            }catch{
                print("error while decoding ",error.localizedDescription)
                
            }
            
        }
    }
    
    func setTrainingQuestionInfo(question:Questions){
        self.questionDetailes = question.qeustionDetailes
        QuestionLabel.text = question.questionText
        showQuestion(at: questionId)
    }
    
    func showQuestion(at index:Int){
        
        //check if questionDetailes not null
        guard let detailes = self.questionDetailes else {
            print("there is no detailes") //replace it with alert
            return
        }
        
        switch section {
        case "shapes":
            if detailes[index].type == "circle"{
                image.image = UIImage(named: "Training-yellowCircle")
                self.answer = detailes[index].answer
                sound.playSound(sound: Constants.Sounds.trainingCircle)
                
            } else  if detailes[index].type == "square" {
                image.image = UIImage(named: "Training-pinkSquare")
                self.answer = detailes[index].answer
                sound.playSound(sound: Constants.Sounds.trainingTraingle)
            }
            break
            
        case "colors":
            if detailes[index].type == "brown"{
                image.image = UIImage(named: "Training-brownColor")
                self.answer = detailes[index].answer
                sound.playSound(sound: Constants.Sounds.trainingBrown)
                
            } else  if detailes[index].type == "white" {
                image.image = UIImage(named: "Training-redColor")
                self.answer = detailes[index].answer
                sound.playSound(sound: Constants.Sounds.trainingRed)
            }
            break
            
        case "calculations":
            if detailes[index].type == "addition"{
                image.image = UIImage(named: "Training-addition")
                self.answer = detailes[index].answer
                sound.playSound(sound: Constants.Sounds.trainingAddition)
                
            } else  if detailes[index].type == "subtraction" {
                image.image = UIImage(named: "Training-subtraction")
                self.answer = detailes[index].answer
                sound.playSound(sound: Constants.Sounds.trainingSubtraction)
                
            } else  if detailes[index].type == "multiplication" {
                image.image = UIImage(named: "Training-multiplication")
                self.answer = detailes[index].answer
                sound.playSound(sound: Constants.Sounds.trainingMultiplication)
            }
            break
            
        default:
            print("there is no section")
        }
    }
    
    func nextQuestion() {
        
        // handling index out of range
        if (questionDetailes!.count-1) == self.questionId  {
            self.questionId = 0
        } else {
            //next Question
            self.questionId += 1
        }
        
        showQuestion(at: questionId)
    }
    
    func answerIndication(for attempt: String){
        
        if attempt == "success-attempt"{
            nextlOutlet.isEnabled = false
            animationView?.animation = Animation.named(attempt)
            sound.playSound(sound: Constants.Sounds.excellent)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                self.nextQuestion()
                self.hideAnswerIndication()
            })
        } else {
            animationView?.animation = Animation.named(attempt)
            sound.playSound(sound: Constants.Sounds.tryAgain)
        }
        
        self.bubleView.isHidden = false
        self.animationContainer.isHidden = false
        self.animationView!.isHidden = false
    
        self.animationView!.frame = self.animationContainer.bounds
        self.animationView!.contentMode = .scaleAspectFit
        self.animationView!.loopMode = .loop
        self.animationView!.animationSpeed = 0.5
        self.animationContainer.addSubview(self.animationView!)
        self.animationView!.play()
          
    }
    
    func hideAnswerIndication(){
        self.bubleView.isHidden = true
        self.animationContainer.isHidden = true
        self.animationView?.isHidden = true
        nextlOutlet.isEnabled = true
    }
    
    @IBAction func answerButton(_ sender: Any) {
        hideAnswerIndication()
        
        // Get answers provided
        let answer = (objectDetected?.getAnswer())!
        print(answer)
        print("the section is:")
        print(section)
        
        guard let detailes = self.questionDetailes else {
            print("there is no detailes") //replace it with alert
            return
        }
        
        switch section {
        case "shapes":
            
            if detailes[questionId].type == "circle"{
                
                if (answer.base?.rawValue == "cake"){
                    print("correct answer")
                    isCorrect=true
                }
                if (answer.change == 0.5 || answer.change == 0.25 ){
                    print("correct answer")
                    isCorrect=true
                }
                
                let providedAnswer = answer.toppings
                
                if providedAnswer == nil {
                    print("child no provide toppings")
                }else if let toppings = providedAnswer {
                    
                    for t in toppings{
                        if (t.rawValue=="oval-kiwi"){
                            print("crrect answer")
                            isCorrect=true

                        }
                    }//end for loop
                }
                
                if(isCorrect){
                    answerIndication(for: "success-attempt")
                    isCorrect=false
                }else{
                    answerIndication(for: "failed-attempt")
                }
                
            }// end if check type
            else  if detailes[questionId].type == "square" {
                print(answer.base?.rawValue)
                if (answer.base?.rawValue == "dark-chocolate"){
                    print("correct answer")
                    isCorrect=true

                }
                let providedAnswer = answer.toppings
                
                if providedAnswer == nil {
                    print("child no provide toppings")
                }else if let toppings = providedAnswer {
                    
                    for t in toppings{
                        if (t.rawValue=="pineapple"){
                            print("crrect answer")
                            isCorrect=true

                        }
                        
                    }//end for loop
                }
                if(isCorrect){
                    answerIndication(for: "success-attempt")
                    isCorrect=false
                }else{
                    answerIndication(for: "failed-attempt")
                }
            }
            break
            
        case "colors":
            print("the question is:")
            print(detailes[questionId].type)
            
            
            if detailes[questionId].type == "brown"{
                if (answer.base?.rawValue == "cupcake-ch"){
                    print("correct answer")
isCorrect=true
                }
                let providedAnswer = answer.toppings
                print("the topping is is:")
                if providedAnswer == nil {
                    print("child no provide toppings")
                } else if let toppings = providedAnswer {
                    for t in toppings{
                        print(t.rawValue)
                        if (t.rawValue=="dark-chocolate"){
                            print("correct answer")
                            isCorrect=true
                        }
                    } //end for loop
                }
                if(isCorrect){
                    answerIndication(for: "success-attempt")
                    isCorrect=false
                }else{
                    answerIndication(for: "failed-attempt")
                }
            } //end if brown color
            
            else  if detailes[questionId].type == "white" {
                
//                if (answer.change == 50 ){
//                    print("correct answer")
//                    isCorrect=true
//                }
//
                let providedAnswer = answer.toppings
                
                if providedAnswer == nil {
                    print("child no provide toppings")
                }else if let toppings = providedAnswer {
                    
                    for t in toppings{
                        print(t.rawValue)
                        if (t.rawValue=="whiteChcolate"){
                            print("crrect answer")
isCorrect=true
                        }
                    }//end for loop
                }
                
                if(isCorrect){
                    answerIndication(for: "success-attempt")
                    isCorrect=false
                }else{
                    answerIndication(for: "failed-attempt")
                }
            }//end id red color
            break
            
        case "calculations":
            if detailes[questionId].type == "addition"{
                
                let providedAnswer = answer.toppings
                var kiwiNo = 0
                if providedAnswer == nil {
                    answerIndication(for: "failed-attempt")
                    print("child no provide toppings")
                }else if let toppings = providedAnswer {
                    
                    for t in toppings{
                        if (t.rawValue=="oval-kiwi"){
                            kiwiNo+=1
                            
                        }
                    }//end for loop
                }
                print("number of kiwi is")
                print(kiwiNo)
                if (kiwiNo==2){
                    isCorrect=true
                    print("crrect answer")
                }
                if(isCorrect){
                    answerIndication(for: "success-attempt")
                    isCorrect=false
                }else{
                    answerIndication(for: "failed-attempt")
                }
                
            }// end if addtion
            else  if detailes[questionId].type == "subtraction" {
                let providedAnswer = answer.toppings
                var ChocolateBrownNo = 0
                if providedAnswer == nil {
                    answerIndication(for: "failed-attempt")
                    print("child no provide toppings")
                }else if let toppings = providedAnswer {
                    
                    for t in toppings{
                        print(t.rawValue)
                        if (t.rawValue=="dark-chocolate"){
                            ChocolateBrownNo+=1
                            
                        }
                    }//end for loop
                }
                print("number of ChocolateBrown is")
                print(ChocolateBrownNo)
                if (ChocolateBrownNo==1){
                    answerIndication(for: "success-attempt")
                    isCorrect=true
                    print("crrect answer")
                }
                if(isCorrect){
                    answerIndication(for: "success-attempt")
                    isCorrect=false
                }else{
                    answerIndication(for: "failed-attempt")
                }
            } else  if detailes[questionId].type == "multiplication" {
                let providedAnswer = answer.toppings
                var PineappleNo = 0
                if providedAnswer == nil {
                    answerIndication(for: "failed-attempt")
                    print("child no provide toppings")
                }else if let toppings = providedAnswer {
                    
                    for t in toppings{
                        if (t.rawValue=="pineapple"){
                            PineappleNo+=1
                            
                        }
                    }//end for loop
                }
                print("number of Pineapple is")
                print(PineappleNo)
                if (PineappleNo==4){
                    isCorrect=true
                    print("crrect answer")
                }
                if(isCorrect){
                    answerIndication(for: "success-attempt")
                    isCorrect=false
                }else{
                    answerIndication(for: "failed-attempt")
                }
            }
            break
            
        default:
            print("there is no section selection")
        }
        
        
        if answer.base == nil {
            print ("The base is nill")
//            answerIndication(for: "failed-attempt")
            return
        }
        
        
        
    }
    @IBAction func skipButton(_ sender: Any) {
        hideAnswerIndication()
        nextQuestion()
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    //MARK: -Set up Object Detection
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //flip camera upside down
        //            previewLayer.connection?.videoOrientation = .portraitUpsideDown
        //        rootLayer = answerView.layer
        //                previewLayer.frame = rootLayer.bounds
        //                rootLayer.addSublayer(previewLayer)
        //
        rootLayer = answerView.layer
        
        //                if let ansView = answerView {
        ////                    self.present(ansView)
        //                    self.show(answer, sender: <#T##Any?#>)
        //                }
        
        
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
    
    
    
}
