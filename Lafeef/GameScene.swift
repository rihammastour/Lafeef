//
//  GameScene.swift
//  Lafeef
//
//  Created by Riham Mastour on 05/06/1442 AH.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var bear = SKSpriteNode()
      private var bearWalkingFrames: [SKTexture] = []
  //  let dog = SKSpriteNode(imageNamed: "boy")
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var bakeryBackgroundNode : SKNode?
    override func didMove(to view: SKView) {
     //   dog.size = CGSize(width: 200, height: 200)
       // addChild(bear)
      // backgroundColor = .blue
        buildBear()
     //   animateBear()

     }
    
  
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        //Get real device size
        
        //1. Get the aspect ratio of the device
        let deviceWidth = UIScreen.main.bounds.width + 1370
        let deviceHeight = UIScreen.main.bounds.height + 790
        let maxAspectRatio: CGFloat = deviceWidth / deviceHeight
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Get Bakery backbround node scene and store it for use later
        self.bakeryBackgroundNode = self.childNode(withName: "bakery")
        if let bakery = self.bakeryBackgroundNode{
            bakery.setScale(maxAspectRatio)
        }
        
        // Get Camera node from scene and store it for use later
        self.camera = self.childNode(withName: "camera") as? SKCameraNode
        if self.camera != nil {
            setCameraConstraints()
        }

        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    func buildBear() {
       
        var bearAnimatedAtlas : SKTextureAtlas
        var Waitinglocation = CGPoint(x: -600.0, y: -58.0)
        if (bear.position == Waitinglocation)  {
            bearAnimatedAtlas = SKTextureAtlas(named: "WaitingWatermelon2")
            print("\\\\\\\\\\\\\\11111")
        }
        else {
            bearAnimatedAtlas = SKTextureAtlas(named: "WaitingPineappleK")
            print("\\\\\\\\\\\\\\222222")
        }
      var walkFrames: [SKTexture] = []

      let numImages = bearAnimatedAtlas.textureNames.count
       
      for i in 1...numImages {
        var bearTextureName : String
        if (bear.position == Waitinglocation)  {
            bearTextureName = "WaitingWatermelon\(i)"
            print("\\\\\\\\\\\\\\333333")
        }
        else {
            bearTextureName = "pineapple\(i)"
            print("\\\\\\\\\\\\\\444444")
        }
//
//        if (bear.position == Waitinglocation)  {
//            bearTextureName = "HappyWatermelon\(i)"
//        }
        walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
//        var rotateAction = SKAction.rotate(toAngle: .pi / 4, duration: 2)
//        bear.run(rotateAction)
       // rotateAction = SKAction.rotate(toAngle: .pi / -4, duration: 3)
        //bear.run(rotateAction)
      }
      bearWalkingFrames = walkFrames
        let firstFrameTexture = bearWalkingFrames[0]
        bear = SKSpriteNode(texture: firstFrameTexture)
        bear.position = CGPoint(x: frame.midX-600, y: frame.midY-58)
        bear.size = CGSize(width: 300, height: 220)
        addChild(bear)
        //M_PI/4.0 is 45 degrees, you can make duration different from 0 if you want to show the rotation, if it is 0 it will rotate instantly
       
//        let moveAction = SKAction.moveBy(x: (view?.frame.midX)!+300 , y: -(view?.frame.midY)!+510 , duration: 3)
//       bear.run(moveAction)
       // if (bear.position == CGPoint(x: frame.midX+300, y: frame.midY+510) ) {
       //            bearTextureName = "HappyWatermelon\(i)"
         //   animateBear()
            animateBear()
        var location = CGPoint(x: frame.midX+20, y: frame.midY-58)
               moveBear(location: location)
       // var Waitinglocation = CGPoint(x: -600.0, y: -58.0)
        if (bear.position == Waitinglocation){
        print("الحمدلله")
        }
       // if (bear.position == location){
        print("here areej/////////////////////////")
            print(bear.position)
        print("done areej/////////////////////////")
      //  }
       //        }
        
    }
    
    func buildBear2() {
       
        var bearAnimatedAtlas : SKTextureAtlas
      //  var Waitinglocation = CGPoint(x: -600.0, y: -58.0)
            bearAnimatedAtlas = SKTextureAtlas(named: "WaitingWatermelon2")
            print("\\\\\\\\\\\\\\*******")
        
      var walkFrames: [SKTexture] = []

      let numImages = bearAnimatedAtlas.textureNames.count
       
      for i in 1...numImages {
        var bearTextureName : String
            bearTextureName = "WaitingWatermelon\(i)"
        
//        if (bear.position == Waitinglocation)  {
//            bearTextureName = "HappyWatermelon\(i)"
//        }
        walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
//        var rotateAction = SKAction.rotate(toAngle: .pi / 4, duration: 2)
//        bear.run(rotateAction)
       // rotateAction = SKAction.rotate(toAngle: .pi / -4, duration: 3)
        //bear.run(rotateAction)
      }
      bearWalkingFrames = walkFrames
        let firstFrameTexture = bearWalkingFrames[0]
        bear = SKSpriteNode(texture: firstFrameTexture)
        bear.position = CGPoint(x: frame.midX, y: frame.midY)
        bear.size = CGSize(width: 300, height: 220)
        addChild(bear)
        //M_PI/4.0 is 45 degrees, you can make duration different from 0 if you want to show the rotation, if it is 0 it will rotate instantly
       
//        let moveAction = SKAction.moveBy(x: (view?.frame.midX)!+300 , y: -(view?.frame.midY)!+510 , duration: 3)
//       bear.run(moveAction)
       // if (bear.position == CGPoint(x: frame.midX+300, y: frame.midY+510) ) {
       //            bearTextureName = "HappyWatermelon\(i)"
         //   animateBear()
            animateBear()
//        var location = CGPoint(x: frame.midX+20, y: frame.midY-58)
//               moveBear(location: location)
       // var Waitinglocation = CGPoint(x: -600.0, y: -58.0)
//        if (bear.position == Waitinglocation){
//        print("الحمدلله")
//        }
       // if (bear.position == location){
        print("here areej/////////////////////////")
            print(bear.position)
        print("done areej/////////////////////////")
      //  }
       //        }
        
    }
 
    func animateBear() {
        bear.run(SKAction.repeatForever(SKAction.animate(with: bearWalkingFrames,
                                                         timePerFrame: 0.33,
                                                         resize: false,
                                                         restore: true)),
        withKey:"walkingInPlaceBear")
        
    }
//
//    func animateBear2() {
//        bear.run(SKAction.repeatForever(SKAction.animate(with: bearWaitingFrames,
//                                                         timePerFrame: 0.33,
//                                                         resize: false,
//                                                         restore: true)),
//        withKey:"walkingInPlaceBear")
//
//    }
    func bearMoveEnded() {
      bear.removeAllActions()
        buildBear2()
    }

    //touchDown
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    //touchMoved
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    //touchUp
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    //touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    //touchesMoved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            self.touchMoved(toPoint: t.location(in: self))
            
            let location = t.location(in: self)
            let previousLocation = t.previousLocation(in: self)

            self.camera?.position.x += location.x - previousLocation.x
            
        }
    }

//
//  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//      let touch = touches.first!
//      var location = touch.location(in: self)
//        location.y = frame.midY-58
//      moveBear(location: location)
//    }
    func moveBear(location: CGPoint) {
      // 1
      var multiplierForDirection: CGFloat

      // 2
      let bearSpeed = frame.size.width / 3.0

      // 3
      let moveDifference = CGPoint(x: location.x - bear.position.x, y: location.y - bear.position.y)
      let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)

      // 4
      let moveDuration = distanceToMove / bearSpeed

      // 5
      if moveDifference.x < 0 {
        multiplierForDirection = 1.0
      } else {
        multiplierForDirection = -1.0
      }
      bear.xScale = abs(bear.xScale) * multiplierForDirection

        // 1
        if bear.action(forKey: "walkingInPlaceBear") == nil {
          // if legs are not moving, start them
          animateBear()
        }

        // 2
        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))

        // 3
        let doneAction = SKAction.run({ [weak self] in
          self?.bearMoveEnded()
        })

        // 4
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        bear.run(moveActionWithDone, withKey:"bearMoving")

    }


    //override touchesCancelled
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    //override update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    //setCameraConstraints
    private func setCameraConstraints() {
        // Don't try to set up camera constraints if we don't yet have a camera.
        guard let camera = camera else { return }

        /*
            Also constrain the camera to avoid it moving to the very edges of the scene.
            First, work out the scaled size of the scene. Its scaled height will always be
            the original height of the scene, but its scaled width will vary based on
            the window's current aspect ratio.
        */
        let scaledSize = CGSize(width: size.width * camera.xScale, height: size.height * camera.yScale)

        /*
            Find the root "board" node in the scene (the container node for
            the level's background tiles).
        */
        guard let bekary = bakeryBackgroundNode else {
            return
        }
        /*
            Calculate the accumulated frame of this node.
            The accumulated frame of a node is the outer bounds of all of the node's
            child nodes, i.e. the total size of the entire contents of the node.
            This gives us the bounding rectangle for the level's environment.
        */
        let boardContentRect = bekary.calculateAccumulatedFrame()

        /*
            Work out how far within this rectangle to constrain the camera.
            We want to stop the camera when we get within 100pts of the edge of the screen,
            unless the level is so small that this inset would be outside of the level.
        */
        let xInset = min((scaledSize.width / 2) + 100, (boardContentRect.width / 2.5)  )
        let yInset = min((scaledSize.height / 2) - 100.0, boardContentRect.height / 2)

        // Use these insets to create a smaller inset rectangle within which the camera must stay.
        let insetContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)

        // Define an `SKRange` for each of the x and y axes to stay within the inset rectangle.
        let xRange = SKRange(lowerLimit: insetContentRect.minX, upperLimit: insetContentRect.maxX)
        let yRange = SKRange(lowerLimit: insetContentRect.minY, upperLimit: insetContentRect.maxY)

        // Constrain the camera within the inset rectangle.
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        levelEdgeConstraint.referenceNode = bekary

        /*
            Add both constraints to the camera. The scene edge constraint is added
            second, so that it takes precedence over following the `PlayerBot`.
            The result is that the camera will follow the player, unless this would mean
            moving too close to the edge of the level.
        */
        camera.constraints = [levelEdgeConstraint]
    }
}
