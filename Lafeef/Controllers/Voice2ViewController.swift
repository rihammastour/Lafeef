/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The root view controller that provides a button to start and stop recording, and which displays the speech recognition results.
*/

import UIKit
import Speech

public class Voice2ViewController: UIViewController, SFSpeechRecognizerDelegate {
    // MARK: Properties
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    

     static var flag = true
    var result : SFSpeechRecognitionResult?
    
    var word = ""
    // MARK: View Controller Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable the record buttons until authorization has been granted.
      
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Configure the SFSpeechRecognizer object already
        // stored in a local member variable.
        speechRecognizer.delegate = self
        
        // Asynchronously make the authorization request.
        SFSpeechRecognizer.requestAuthorization { authStatus in

            // Divert to the app's main thread so that the UI
            // can be updated.
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                  print("auth")
                    
                case .denied:
                    print("err")
                    
                case .restricted:
                    print("err")
                case .notDetermined:
                    print("err")
                default:
                  print("err")
                }
            }
        }
    }
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
      
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let RecognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest!.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest!.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!) { [self] result, error in
            var isFinal = false
            
        
            if let result = result {
                
                // Update the text view with the results.
             
                var finaltext = result.bestTranscription.formattedString
            
                if Voice2ViewController.flag{
         
            
            
                    recognitionRequest = nil
                    self.call(string:finaltext)
              
                  
             
                }
                isFinal = result.isFinal
              
//                print("Text", finaltext)
//
//                self.call(string: finaltext)
                
                
                
                
            }
         
          
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

             
            }
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        // Let the user know to start talking.
      
    }
    
    // MARK: SFSpeechRecognizerDelegate
    
   
    
    // MARK: Interface Builder actions
    
func recordButtonTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
          
        } else {
            do {
                try startRecording()
              
            } catch {
               print("eror")
            }
        }
    }
    func stoprecordButtonTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
    
         
        }}
    func call(string:String){
//        if string.suffix(4) == "تفضل"{
        print(string.suffix(4))
//        if( audioEngine.isRunning){
//        do {
//            try startRecording()
//
//        } catch {
//           print("eror")
//        }
    
       
        
//            Voice2ViewController.flag = false
//            ChallengeViewController.challengeScen?.OrderbuttonTapped(button: "xx")
    }
        }
     
    
// var x = String(string.suffix(4))
//        if x == "تفضل"{
//        print(x) }
//
  
//}

