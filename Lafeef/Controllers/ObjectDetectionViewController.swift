//
//  ObjectDetectionViewController.swift
//  Lafeef
//
//  Created by Mihaf on 11/07/1442 AH.
//



import UIKit
import AVFoundation
import Vision
import SpriteKit
import GameplayKit


class ObjectDetectionViewController: ChallengeViewController{
    
      private var detectionOverlay: CALayer! = nil
      
      // Vision parts
      private var requests = [VNRequest]()
    var count = 0
      
    @discardableResult
      func setupVision() -> NSError? {
          // Setup Vision parts
          let error: NSError! = nil
        print("setupvision")
          
          guard let modelURL = Bundle.main.url(forResource: "LafeefModel", withExtension: "mlmodelc") else {
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
        
          detectionOverlay.sublayers = nil // remove all the old recognized objects
          for observation in results where observation is VNRecognizedObjectObservation {
              guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                  continue
              }
              // Select only the label with the highest confidence.
            
              let topLabelObservation = objectObservation.labels[0]
              let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
              
            let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds,topLabelObservation.identifier)
            print(topLabelObservation)
  //
  //            let textLayer = self.createTextSubLayerInBounds(objectBounds,
  //                                                            identifier: topLabelObservation.identifier,
  //                                                            confidence: topLabelObservation.confidence)
  //            shapeLayer.addSublayer(textLayer)
              detectionOverlay.addSublayer(shapeLayer)
          }
          self.updateLayerGeometry()
          CATransaction.commit()
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
          detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 1.0)).scaledBy(x: -scale, y: -scale))
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
            position = CGPoint(x: bounds.midX, y:  330)
        }else{
            position = CGPoint(x: bounds.midX, y:  430)
        }
        
       
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
//        shapeLayer.contentsGravity = .center
        
//
    
          shapeLayer.position = position
          shapeLayer.name = "Found Object"
          shapeLayer.contents = mappingLabelsToImage(classLabel: classLabel)
       
          return shapeLayer
      }
      
 

   
    func mappingLabelsToImage(classLabel : String)-> CGImage{
        
        var count = 0
      
    
        var image = UIImage(named: "cake")!.cgImage
        switch classLabel {
        case "Cake":
        image = UIImage(named: "cake")!.cgImage
            return image!
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
            image = UIImage(named: "cake")!.cgImage
            break
        }
      
        return image!
        
    }



}
