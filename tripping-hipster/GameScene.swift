//
//  GameScene.swift
//  tripping-hipster
//
//  Created by Bronson Oka on 1/6/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    // MARK:  - Setup constants
    // keyboard dictionary
    //let keyboard = ["¯", "\\", "_", "(", "ツ", ")","_","/","¯"]
    let keyboard1 = ["a", "b", "c", "d", "e","f", "g"]
    let emoji = ["(;¬_¬)","( ≧Д≦)", "(；￣Д￣）"]
    let myLabel = SKLabelNode(fontNamed:"Arial")
    let myLabel1 = SKLabelNode(fontNamed:"Arial")
    
    let carSize = CGSize(width:70, height:90)
    let carName = "car"
    
    let motionManager: CMMotionManager = CMMotionManager()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // setup physics body of GameScene itself
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        myLabel.text = "";
        myLabel.fontSize = 40;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        var emojiIndex = Int(arc4random_uniform(UInt32(emoji.count)))
        
        myLabel1.text = emoji[emojiIndex];
        myLabel1.fontSize = 40;
        myLabel1.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-80);
        
        self.addChild(myLabel1)
        
        
        
        for counter in 0...4 {
            // generate keyboard with two rows
            keyboardLetterGen(CGPoint(x:CGFloat(counter+1),y:CGFloat(100)), emojiIndex: emojiIndex)
            keyboardLetterGen(CGPoint(x:CGFloat(counter+1),y:CGFloat(0)), emojiIndex: emojiIndex)
        }
        setupCar()  // generate car
        
        
        motionManager.startAccelerometerUpdates()
        
        

    }
    // MARK: Touch Setup
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let touch = touches.anyObject() as UITouch
            let touchLocation = touch.locationInNode(self)
            let touchNode = self.nodeAtPoint(touchLocation)
            
            // test touch on virtual keyboard
            if touchNode.name == "keyboardNode" {
                println((touchNode as SKLabelNode).text)
                myLabel.text = myLabel.text+(touchNode as SKLabelNode).text
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        processUserMotionForUpdate(currentTime)
    }
    
    func processUserMotionForUpdate(currentTime: CFTimeInterval) {
        
        // 1
        let car = childNodeWithName(carName) as SKSpriteNode
        
        // 2
        if let data = motionManager.accelerometerData {
            
            // 3
            if (fabs(data.acceleration.x) > 0.2) {
                // move ship
                car.physicsBody!.applyForce(CGVectorMake(40.0 * CGFloat(data.acceleration.x), 0))
                
            }
        }
    }
    
    // MARK: Sprite Setup
    func keyboardLetterGen (location:CGPoint, emojiIndex:Int) {
        var emojiChar = Array(emoji[emojiIndex])
        
        let keyboardNode = SKLabelNode(fontNamed:"Courier New")
        keyboardNode.name = "keyboardNode"
        keyboardNode.text = "\(emojiChar[Int(arc4random_uniform(UInt32(emojiChar.count)))])";
        keyboardNode.fontSize = 50;
        keyboardNode.position = CGPoint(x: location.x*CGRectGetWidth(self.frame)/6, y: CGRectGetHeight(self.frame)/15+location.y);
        self.addChild(keyboardNode)
        

    }
    func setupCar() {
        
        let car = makeCar()
        
        // position and add car
        car.position = CGPoint(x:size.width / 2.0, y:CGRectGetMidY(self.frame)+100)
        addChild(car)
    }
    
    func makeCar() -> SKNode {
        // make a car sprite (box with color and size)
        let car = SKSpriteNode(color: SKColor.greenColor(), size: carSize)
        car.name = carName
        
        // set up car physics
        car.physicsBody = SKPhysicsBody(rectangleOfSize: car.frame.size)
        car.physicsBody!.dynamic = true
        car.physicsBody!.affectedByGravity = false
        car.physicsBody!.mass = 0.02
        return car
    }

}
