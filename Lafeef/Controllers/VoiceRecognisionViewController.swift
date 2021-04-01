////
////  VoiceRecognisionViewController.swift
////  Lafeef
////
////  Created by Mihaf on 19/08/1442 AH.
////
//
//import UIKit
//import Speech
//
//class VoiceRecognisionViewController: UIViewController, SFSpeechRecognizerDelegate {
//
////
////    @IBOutlet weak var detectedTextLabel: UILabel!
////
////    @IBOutlet weak var colorView: UIView!
////    @IBOutlet weak var startButton: UIButton!
////
//
//
//
//    let audioEngine = AVAudioEngine()
//    let speechRecognizer =  SFSpeechRecognizer(locale: Locale(identifier: "ar_SA"))
//    let request = SFSpeechAudioBufferRecognitionRequest()
//    var recognitionTask: SFSpeechRecognitionTask?
//    var isRecording = false
//    var authorized  = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.requestSpeechAuthorization()
//
//    }
//
//
//
////MARK: IBActions and Cancel
//    @IBAction func startButtonTapped(_ sender: UIButton) {
//        if isRecording == true {
//            cancelRecording()
//            isRecording = false
//
//        } else {
//            self.recordAndRecognizeSpeech()
//            isRecording = true
//
//        }
//    }
//
//    func cancelRecording() {
//        recognitionTask?.finish()
//        recognitionTask = nil
//
//        // stop audio
//        request.endAudio()
//        audioEngine.stop()
//        audioEngine.inputNode.removeTap(onBus: 0)
//    }
//
////MARK: - Recognize Speech
//    func recordAndRecognizeSpeech()-> String {
//        var text = ""
//        let node = audioEngine.inputNode
//        let recordingFormat = node.outputFormat(forBus: 0)
//        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
//            self.request.append(buffer)
//        }
//        audioEngine.prepare()
//        do {
//            try audioEngine.start()
//        } catch {
//            self.sendAlert(title: "Speech Recognizer Error", message: "There has been an audio engine error.")
//            print(error)
//            return error.localizedDescription
//
//        }
//        guard let myRecognizer = SFSpeechRecognizer() else {
//            self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not supported for your current locale.")
//            return error.localizedDescription
//        }
//        if !myRecognizer.isAvailable {
//            self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not currently available. Check back at a later time.")
//            // Recognizer is not available right now
//            return errro.localizedDescription
//        }
//        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
//            if let result = result {
//
//                let bestString = result.bestTranscription.formattedString
//                var lastString: String = ""
//                for segment in result.bestTranscription.segments {
//                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
//                    lastString = String(bestString[indexTo...])
//                }
//               text = lastString
//
//                self.callButton(resultString: lastString)
//            } else if let error = error {
//                self.sendAlert(title: "Speech Recognizer Error", message: "There has been a speech recognition error.")
//                print(error)
//                text = " error"
//
//            }
//        })
//        return text
//    }
//
////MARK: - Check Authorization Status
//func requestSpeechAuthorization() {
//    SFSpeechRecognizer.requestAuthorization { authStatus in
//        OperationQueue.main.addOperation { [self] in
//            switch authStatus {
//            case .authorized:
//               authorized = true
//            case .denied:
//                authorized = false
//
//            case .restricted:
//               authorized = false
//
//            case .notDetermined:
//             authorized = false
//
//            @unknown default:
//                return
//            }
//        }
//    }
//}
//
////MARK: - UI / Set view color.
//
//    func callButton(resultString: String){
//        switch resultString{
//        case Button.orderButton.rawValue:
//
//            break
//
//        }
//
//    }
////    func checkForColorsSaid(resultString: String) {
//
////
////        guard let color = Color(rawValue: resultString) else { return }
////        colorView.backgroundColor = color.create
////        self.detectedTextLabel.text = resultString
////    }
//
////MARK: - Alert
//    func sendAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//}
