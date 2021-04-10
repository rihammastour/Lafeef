//
//  VoiceViewController.swift
//  Lafeef
//
//  Created by Mihaf on 20/08/1442 AH.
//

import UIKit
import Speech

class VoiceViewController: UIViewController,SFSpeechRecognizerDelegate {
    var audioEngine = AVAudioEngine()
    let speechRecognizer =  SFSpeechRecognizer(locale: Locale(identifier: "ar_SA"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func startButtonTapped() {
      
            if isRecording == true {
                cancelRecording()
                isRecording = false
            
            } else {
                self.recordAndRecognizeSpeech()
                isRecording = true
              
            }
        }
        
        func cancelRecording() {
            recognitionTask?.finish()
            recognitionTask = nil
            
            // stop audio
            request.endAudio()
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        
    //MARK: - Recognize Speech
        func recordAndRecognizeSpeech() {
          
            let node = audioEngine.inputNode
            let recordingFormat = node.outputFormat(forBus: 0)
            
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.request.append(buffer)
            }
            audioEngine.prepare()
            do {
                try audioEngine.start()
            } catch {
                self.sendAlert(title: "Speech Recognizer Error", message: "There has been an audio engine error.")
                return print(error)
            }
            guard let myRecognizer = SFSpeechRecognizer() else {
                self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not supported for your current locale.")
                return
            }
            if !myRecognizer.isAvailable {
                self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not currently available. Check back at a later time.")
                // Recognizer is not available right now
                return
            }
            recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
                if let result = result {
                    
                    let bestString = result.bestTranscription.formattedString
                    var lastString: String = ""
                    for segment in result.bestTranscription.segments {
                        let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                        lastString = String(bestString[indexTo...])
                    }
                  ChallengeViewController.callButton(string: lastString)
//                  /
                } else if let error = error {
                    self.sendAlert(title: "Speech Recognizer Error", message: "There has been a speech recognition error.")
                    print(error)
                }
            })
        }
        
    //MARK: - Check Authorization Status
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized: break
//                    self.startButton.isEnabled = true
                case .denied: break
//                    self.startButton.isEnabled = false
//                    self.detectedTextLabel.text = "User denied access to speech recognition"
                case .restricted: break
//                    self.startButton.isEnabled = false
//                    self.detectedTextLabel.text = "Speech recognition restricted on this device"
                case .notDetermined: break
//                    self.startButton.isEnabled = false
//                    self.detectedTextLabel.text = "Speech recognition not yet authorized"
                @unknown default:
                    return
                }
            }
        }
    }
        
    //MARK: - UI / Set view color.
//        func checkForColorsSaid(resultString: String) {
//            guard let color = Color(rawValue: resultString) else { return }
//            colorView.backgroundColor = color.create
//            self.detectedTextLabel.text = resultString
//        }
//
    //MARK: - Alert
        func sendAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
