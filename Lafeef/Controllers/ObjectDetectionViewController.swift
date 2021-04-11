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
    
      static var detectionOverlay = CALayer()
      
      // Vision parts
      private var requests = [VNRequest]()

    static var shapeLayer = CALayer()
// var voice = VoiceViewController()

    
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
        ObjectDetectionViewController.detectionOverlay.zPosition = 4
          CATransaction.begin()
          CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)

        ObjectDetectionViewController.detectionOverlay.sublayers = nil // remove all the old recognized objects
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
        answerLabels = []

        answerArray = results
//        ObjectDetectionViewController.detectionOverlay.sublayers = nil
        for observation in answerArray {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                continue
              
            }
            answerLabels.append(objectObservation.labels[0].identifier)
            
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
            ObjectDetectionViewController.shapeLayer =
            self.createRoundedRectLayerWithBounds(objectBounds,objectObservation.labels[0].identifier)
            ObjectDetectionViewController.detectionOverlay.addSublayer(ObjectDetectionViewController.shapeLayer)
        // need to make it global variable and pass it to move to cahier function to hide it then if in location == 600 same as the detection trigger
        // we need to fix the postion inside the box
             // I think its 480 x and -320 y 

        }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
//                    self.stopSession()
//                }


        answerArray = []

        
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
        
        objectDetected = self

      }
      
      func setupLayers() {
        ObjectDetectionViewController.detectionOverlay = CALayer() // container layer that has all the renderings of the observations
        ObjectDetectionViewController.detectionOverlay.name = "DetectionOverlay"
        ObjectDetectionViewController.detectionOverlay.bounds = CGRect(x: 0.0,
                                           y: 0.0,
                                           width: bufferSize.width,
                                           height: bufferSize.height)
        ObjectDetectionViewController.detectionOverlay.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
        rootLayer.addSublayer(ObjectDetectionViewController.detectionOverlay)
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
        ObjectDetectionViewController.detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 1.0)).scaledBy(x: scale, y: -scale))
          // center the layer
        ObjectDetectionViewController.detectionOverlay.position = CGPoint(x: bounds.midX, y: bounds.midY)

          CATransaction.commit()
          
      }
      

      
    func createRoundedRectLayerWithBounds(_ bounds: CGRect,_ classLabel :String) -> CALayer {
        // self.view.frame.size.width -> 834
        
        var position = CGPoint()
            position = CGPoint(x: ceil(bounds.midX), y:  430)
        

        
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
        //        shapeLayer.contentsGravity = .center
        
        //
        
        shapeLayer.position = position
        shapeLayer.name = "Found Object"
        switch classLabel {
        case "CompleteCake":
            shapeLayer.contents = UIImage(named: "cake")!.cgImage
            break
        case "QuarterCake":
            shapeLayer.contents = UIImage(named: "quarter-cake")!.cgImage
            break
        case "HalfCake":
            shapeLayer.contents = UIImage(named: "half-cake")!.cgImage
            break
        case "3QuartersCake":
            shapeLayer.contents = UIImage(named: "threequarter-cake")!.cgImage
            
            break
        case "WhiteCupcake":
            shapeLayer.contents = UIImage(named: "cupcake-van")!.cgImage
            break
        case "BrownCupcake":
            shapeLayer.contents = UIImage(named: "cupcake-ch")!.cgImage
            break
        case "ChocolateBrown":
            shapeLayer.contents = UIImage(named: "dark-chocolate")!.cgImage
            break
        case "ChocolateWhite":
            shapeLayer.contents = UIImage(named: "white-chocolate")!.cgImage
            break
        case "Kiwi":
            shapeLayer.contents = UIImage(named: "oval-kiwi")!.cgImage
            break
        case "Strawberry":
            shapeLayer.contents = UIImage(named: "strawberry")!.cgImage
            break
        case "Pineapple":
            shapeLayer.contents = UIImage(named: "pineapple")!.cgImage
            break
        case "OneRiyal":
            shapeLayer.contents = UIImage(named: "1Flipped")!.cgImage
            break
        case "FiftyRiyal":
            shapeLayer.contents = UIImage(named: "50Flipped")!.cgImage
            break
        case "TenRiyal":
            shapeLayer.contents = UIImage(named: "10Flipped")!.cgImage
            break
        case "RiyalHalf":
            shapeLayer.contents = UIImage(named: "0.5Flipped")!.cgImage
            break
        case "RiyalQuarter":
            shapeLayer.contents = UIImage(named: "0.25Flipped")!.cgImage
            break
        case "FiveRiyal":
            shapeLayer.contents = UIImage(named: "5Flipped")!.cgImage
            break
        default:
            break
        }
        
        layer = shapeLayer
        return shapeLayer
      }
   
    override func stopSession() {
        if session.isRunning {
            DispatchQueue.global().async {
                self.session.stopRunning()
            }
           
            print("calccc")

        }
        
    }
  
    
    func getAnswer() -> Answer {

        // self.view.frame.size.width -> 834
        // 6 -> 139
        
        var base : Base? = nil
        var toppings : [Topping]? = []
        var change : Float = 0
        
        for label in answerLabels {
            switch label {
            case "CompleteCake":
                base = Base.cake
                break
            case "QuarterCake":
                base = Base.quarterCake
                break
            case "HalfCake":
                base = Base.halfCake
                break
            case "3QuartersCake":
                base = Base.threequarterCake
                break
            case "WhiteCupcake":
                base = Base.vanilaCupcake
                break
            case "BrownCupcake":
                base = Base.chocolateCupcake
                break
            case "ChocolateBrown":
                toppings?.append(Topping.darkChocolate)
                break
            case "ChocolateWhite":
                toppings?.append(Topping.whiteChocolate)
                break
            case "Kiwi":
                toppings?.append(Topping.kiwi)
                break
            case "Strawberry":
                toppings?.append(Topping.strawberry)
                break
            case "Pineapple":
                toppings?.append(Topping.pineapple)
                break
            case "OneRiyal":
                change += 1
                break
            case "FiftyRiyal":
                change += 50
                break
            case "TenRiyal":
                change += 10
                break
            case "RiyalHalf":
                change += 0.5
                break
            case "RiyalQuarter":
                change += 0.25
                break
            case "FiveRiyal":
                change += 5
                break
            default:
              print("No label match")
                break
            }
        }
        
        
        
        
        let answer = Answer(base: base, change: change, atTime: 0, toppings: toppings)
        print("Answer provided by child",answer)
        
        return answer
    }
}
