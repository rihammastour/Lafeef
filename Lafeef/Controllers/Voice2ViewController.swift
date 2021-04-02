//
//  Voice2ViewController.swift
//  Lafeef
//
//  Created by Mihaf on 20/08/1442 AH.
//

import UIKit
import Speech

public class Voice2ViewController: UIViewController, SFSpeechRecognizerDelegate {
    // MARK: Properties
    
     let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA"))!
    
     var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
     var recognitionTask: SFSpeechRecognitionTask?
    
      let audioEngine = AVAudioEngine()
    var text = ""
  

    
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
                 
                 print("denied")
                    
                case .restricted:
                    print("rees")
//                    self.recordButton.isEnabled = false
//                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    print("rest")
                    
                default:
                    print("def")
                }
            }
        }
    }
    
     func startRecording() throws {
        
    
        
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
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { [self] result, error in
            if let result = result {
//            print("beta",result.bestTranscription.formattedString)
                var lastString = ""
                let bestString = result.bestTranscription.formattedString
             
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = String(bestString[indexTo...])
//
                   
//
                }
                print(lastString)
                stopAudioRecording()
                self.callForButton(button: lastString)
//                ChallengeViewController.callButton(string: lastString)
            
//                    self.detectedTextLabel.text = lastString
//                  /
            } else if let error = error {
                print("error")
//                self.sendAlert(title: "Speech Recognizer Error", message: "There has been a speech recognition error.")
                print(error)
            }
        })
        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        // Let the user know to start talking.
       text = "(Go ahead, I'm listening)"
    }
    
    // MARK: SFSpeechRecognizerDelegate
    
//    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
//        if available {
//       print("av")
////            recordButton.setTitle("Start Recording", for: [])
//        } else {
//            print("not")
////            recordButton.isEnabled = false
////            recordButton.setTitle("Recognition Not Available", for: .disabled)
//        }
//    }
    
    // MARK: Interface Builder actions
    
func recordButtonTapped() {
    if audioEngine.isRunning {
        audioEngine.stop()
            recognitionRequest?.endAudio()
//            recordButton.isEnabled = false
//            recordButton.setTitle("Stopping", for: .disabled)
        } else {
            do {
                try startRecording()
//                recordButton.setTitle("Stop Recording", for: [])
            } catch {
                print("cc")
//                recordButton.setTitle("Recording Not Available", for: [])
            }
        }
    }
    func stopAudioRecording(){
        print("stopRuning")
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            
           
    }
    }
    func callForButton(button:String){
   
//        ChallengeViewController.test()
   
        if button == "تفضل"{
            print("insdie voice")
        ChallengeViewController.test()
//            startRecording()
        }
        }
//    func stop (){
//
//    }
}
