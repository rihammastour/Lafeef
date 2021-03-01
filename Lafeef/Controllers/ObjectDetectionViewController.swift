//
//  ObjectDetectionViewController.swift
//  Lafeef
//
//  Created by Mihaf on 11/07/1442 AH.
//



import UIKit
import AVFoundation
import Foundation
import Vision
import SpriteKit
import GameplayKit
// for vibration
// we need to print the fame size then
// make diffrent ranges
// the frame size = 475
// divide it into
// if its 9 parts it will be 53 points for each of them
// range 1...3


class ObjectDetectionViewController: ChallengeViewController{
    
      private var detectionOverlay: CALayer! = nil
      
      // Vision parts
      private var requests = [VNRequest]()
    var answerArray = [VNRecognizedObjectObservation]()
    var answerLabels = [String]()
    var providedAnswer = Answer(base:  nil, change: 0 , atTime: 0, toppings: [])
    var isOrder = true
    
 
    @discardableResult
      func setupVision() -> NSError? {
          // Setup Vision parts
          let error: NSError! = nil
        print("setupvision")
          
          guard let modelURL = Bundle.main.url(forResource: "LafeefModelDifferentSurfaces", withExtension: "mlmodelc") else {
              return NSError(domain: "VisionObjectRecognitionViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
          }
          do {
              let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
              let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                  DispatchQueue.main.async(execute: {
                      // perform all the UI updates on the main queue
                      if let results = request.results {
                          self.drawVisionRequestResults(results)
              
                      }
                  })
              })
              self.requests = [objectRecognition]
          } catch let error as NSError {
              print("Model loading went wrong: \(error)")
          }
          
          return error
      }
      
      func drawVisionRequestResults(_ results: [Any]) {
          CATransaction.begin()
          CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//

          detectionOverlay.sublayers = nil // remove all the old recognized objects
          for observation in results where observation is VNRecognizedObjectObservation {
              guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                  continue
                
              }
              // Select only the label with the highest confidence.
     
//            if  objectObservation.confidence > 0.9 {
//                let topLabelObservation = objectObservation.labels[0]
//                let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
//              let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds,topLabelObservation.identifier)
//              print(topLabelObservation)
//                detectionOverlay.addSublayer(shapeLayer)
//            }
         


  //
  //            let textLayer = self.createTextSubLayerInBounds(objectBounds,
  //                                                            identifier: topLabelObservation.identifier,
  //                                                            confidence: topLabelObservation.confidence)
  //            shapeLayer.addSublayer(textLayer)
     
          }
        answer(results: results as! [VNRecognizedObjectObservation])

        
//        print("AnswerLabels", answerLabels)
//          self.updateLayerGeometry()
          CATransaction.commit()
      }
    
    func answer(results: [VNRecognizedObjectObservation]){

        answerArray = results
        print(answerArray,"---------------------------------")
        detectionOverlay.sublayers = nil
        for observation in answerArray {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                continue
              
            }
            answerLabels.append(objectObservation.labels[0].identifier)
            
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
            let shapeLayer =
            self.createRoundedRectLayerWithBounds(objectBounds,objectObservation.labels[0].identifier)
            detectionOverlay.addSublayer(shapeLayer)
            // need to make it global variable and pass it to move to cahier function to hide it then if in location == 600 same as the detection trigger
        // wee need to fix the postion inside the box
             // I think its 480 x and -320 y 

        }
        print("AnswerLabels insideloop", answerLabels)
                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                    self.stopSession()
        
                }
        
        answerArray = []
        answerLabels = []

        
    }
      
      override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
          guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
              return
          }
          
          let exifOrientation = exifOrientationFromDeviceOrientation()
          
          let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
          do {
              try imageRequestHandler.perform(self.requests)
          } catch {
              print(error)
          }
        
      }
      
      override func setupAVCapture() {
          super.setupAVCapture()
          
          // setup Vision parts
          setupLayers()
          updateLayerGeometry()
          setupVision()
          
          // start the capture
          startCaptureSession()
      }
      
      func setupLayers() {
          detectionOverlay = CALayer() // container layer that has all the renderings of the observations
          detectionOverlay.name = "DetectionOverlay"
          detectionOverlay.bounds = CGRect(x: 0.0,
                                           y: 0.0,
                                           width: bufferSize.width,
                                           height: bufferSize.height)
          detectionOverlay.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
          rootLayer.addSublayer(detectionOverlay)
      }
      
      func updateLayerGeometry() {
          let bounds = rootLayer.bounds
          var scale: CGFloat

          let xScale: CGFloat = bounds.size.width / bufferSize.height
          let yScale: CGFloat = bounds.size.height / bufferSize.width
          
          scale = fmax(xScale, yScale)
          if scale.isInfinite {
              scale = 1.0
          }
          CATransaction.begin()

          CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)

          // rotate the layer into screen orientation and scale and mirror
          detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 1.0)).scaledBy(x: scale, y: -scale))
          // center the layer
          detectionOverlay.position = CGPoint(x: bounds.midX, y: bounds.midY)

          CATransaction.commit()
          
      }
      
  //    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
  //        let textLayer = CATextLayer()
  //        textLayer.name = "Object Label"
  //        let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfidence:  %.2f", confidence))
  //        let largeFont = UIFont(name: "Helvetica", size: 24.0)!
  //        formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
  //        textLayer.string = formattedString
  //        textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height - 10, height: bounds.size.width - 10)
  //        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
  //        textLayer.shadowOpacity = 0.7
  //        textLayer.shadowOffset = CGSize(width: 2, height: 2)
  //        textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])
  //        textLayer.contentsScale = 2.0 // retina rendering
  //        // rotate the layer into screen orientation and scale and mirror
  //        textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
  //        return textLayer
  //    }
      
    func createRoundedRectLayerWithBounds(_ bounds: CGRect,_ classLabel :String) -> CALayer {
        
        var position = CGPoint()
        if classLabel == "ChocolateBrown"{
            position = CGPoint(x: ceil(bounds.midX), y:  330)
        }else{
            position = CGPoint(x: ceil(bounds.midX), y:  430)
        }
        
        
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
        //        shapeLayer.contentsGravity = .center
        
        //
        
        shapeLayer.position = position
        shapeLayer.name = "Found Object"
        shapeLayer.contents = mappingLabelsToImage(classLabel:classLabel)
        
        layer = shapeLayer
        return shapeLayer
      }
      
 

   
    func mappingLabelsToImage(classLabel : String)-> CGImage{
    
        var answer = Answer(base:  nil, change: 0 , atTime: 0, toppings: [])
        var image = UIImage(named: "placeholder")!.cgImage
        switch classLabel {
        case "CompleteCake":
        image = UIImage(named: "cake")!.cgImage
            break
        case "QuarterCake":
        image = UIImage(named: "quarter-cake")!.cgImage
            break
        case "HalfCake":
        image = UIImage(named: "half-cake")!.cgImage
            break
        case "3QuartersCake":
        image = UIImage(named: "threequarter-cake")!.cgImage
            
            break
        case "WhiteCupcake":
        image = UIImage(named: "cupcake-van")!.cgImage
            break
        case "BrownCupcake":
        image = UIImage(named: "cupcake-ch")!.cgImage
            break
        case "ChocolateBrown":
            image = UIImage(named: "dark-chocolate")!.cgImage
            break
        case "ChocolateWhite":
            image = UIImage(named: "white-chocolate")!.cgImage
            break
        case "Kiwi":
            image = UIImage(named: "oval-kiwi")!.cgImage
            break
        case "Strawberry":
            image = UIImage(named: "strawberry")!.cgImage
            break
        case "Pineapple":
            image = UIImage(named: "pineapple")!.cgImage
            break
        case "OneRiyal":
            image = UIImage(named: "1")!.cgImage
            break
        case "FiftyRiyal":
            image = UIImage(named: "50")!.cgImage
            break
        case "TenRiyal":
            image = UIImage(named: "10")!.cgImage
            break
        case "RiyalHalf":
            image = UIImage(named: "0.5")!.cgImage
            break
        case "RiyalQuarter":
            image = UIImage(named: "0.25")!.cgImage
            break
        case "FiveRiyal":
            image = UIImage(named: "5")!.cgImage
            break
        default:
          print("default")
            break
        }

//        print(answer,"Switch statement2")

        return image!
        
    }

    override func stopSession() {
        if session.isRunning {
            DispatchQueue.global().async {
                self.session.stopRunning()
            }
            setAnswer(answerLabels: answerLabels)

            if isOrder{
                calculateOrderScore(for: providedAnswer)
                
                // we need th check the value of the score
                //if it is 1 or 0 call sad
                // if it is 2 still normal walking frame **
                // if it is 3 call happy
                
            } else {
                calculatePaymentScore(with: providedAnswer.change)
                isOrder = true
                // as the same
            }
          
            print("calccc")

        }
        
    }
    
    func setAnswer(answerLabels: [String]){
        for label in answerLabels{
            switch label {
            case "CompleteCake":
                providedAnswer.base = Base.cake
                break
            case "QuarterCake":
                self.providedAnswer.base = Base(rawValue: "quarter-cake")!
                break
            case "HalfCake":
                providedAnswer.base = Base(rawValue: "half-cake")
                break
            case "3QuartersCake":
                providedAnswer.base = Base(rawValue: "threequarter-cake")
                break
            case "WhiteCupcake":
                providedAnswer.base = Base(rawValue: "cupcake-van")
                break
            case "BrownCupcake":
                providedAnswer.base = Base(rawValue: "cupcake-ch")
                break
            case "ChocolateBrown":
                providedAnswer.toppings?.append(Topping(rawValue: "dark-chocolate")!)
                break
            case "ChocolateWhite":
                providedAnswer.toppings?.append(Topping(rawValue: "white-chocolate")!)
                break
            case "Kiwi":
                providedAnswer.toppings?.append(Topping(rawValue:  "oval-kiwi")!)
                break
            case "Strawberry":
                providedAnswer.toppings?.append(Topping(rawValue:  "strawberry")!)
                break
            case "Pineapple":
                providedAnswer.toppings?.append(Topping.pineapple)
                break
            case "OneRiyal":
                providedAnswer.change += Money.riyal.rawValue
                break
            case "FiftyRiyal":
                providedAnswer.change += Money.fiftyRiyal.rawValue
                break
            case "TenRiyal":
                providedAnswer.change += Money.tenRiyal.rawValue
                break
            case "RiyalHalf":
                providedAnswer.change += Money.riyalHalf.rawValue
                break
            case "RiyalQuarter":
                providedAnswer.change += Money.riyalQuarter.rawValue
                break
            case "FiveRiyal":
                providedAnswer.change += Money.fiveRiyal.rawValue
                break
            default:
              print("default")
                break
            }
        }
        print(providedAnswer,"setAnswer")
    }
}
