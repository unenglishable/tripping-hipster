//
//  GameScene.swift
//  tripping-hipster
//
//  Created by Bronson Oka on 1/6/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

import SpriteKit
import CoreMotion

// operator overloading for CGPoint
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

// add a shuffle function to arrays
extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

class GameScene: SKScene {
    
    // MARK:  - Setup constants
    // keyboard dictionary
    let keyboardNumberOfChars = 9
    let emoji = ["(;¬_¬)","( ≧Д≦)", "(；￣Д￣）","((╬ಠิ﹏ಠิ))","ಠ_ರೃ","(ノ#-_-)ノ"]
    let usersEmoji = SKLabelNode(fontNamed:"Arial")
    let emojiDisplay = SKLabelNode(fontNamed:"Arial")
    let scoreBoard = SKLabelNode(fontNamed: "Arial")
    
    let carSize = CGSize(width:60, height:70)
    let carName = "car"
    
    let motionManager: CMMotionManager = CMMotionManager()
    
    var scoreCount = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // setup physics body of GameScene itself
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
         var emojiIndex = Int(arc4random_uniform(UInt32(emoji.count)))
        
        // create area for user to type
        makeUserTextField()
        // create display emoji
        makeEmojiDisplay(emojiIndex)
        // create scoreboard
        makeScoreBoard()
        
        // create keyboard
        keyboardLetterGen(emojiIndex)
        
        setupCar()  // generate car
        
        // begin collecting data from Accelerometer
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
            if touchNode.name == "keyboardBox" {
                println(touchNode.accessibilityLabel)
                usersEmoji.text = usersEmoji.text+touchNode.accessibilityLabel
            }
            
            // test when user completes emoji correctly
            if usersEmoji.text == emojiDisplay.text {
                usersEmoji.text = ""
                var randIndex = Int(arc4random_uniform(UInt32(emoji.count)))
                emojiDisplay.text = emoji[randIndex];
                
                // delete and create new keyboard
                for child in self.children as [SKNode] {
                    if (child.name == "keyboardNode" || child.name == "keyboardBox") {
                        self.removeChildrenInArray([child])
                    }
                }
                keyboardLetterGen(randIndex)
                scoreCount++
                scoreBoard.text = "\(scoreCount)"
                if scoreCount > 2 {
                    let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                    let gameOverScene = GameOverScene(size: self.size, won: true)
                    self.view?.presentScene(gameOverScene, transition: reveal)
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        processUserMotionForUpdate(currentTime)
    }
    
    func processUserMotionForUpdate(currentTime: CFTimeInterval) {
        
        // apply force when acceleration detected in x direction
        let car = childNodeWithName(carName) as SKSpriteNode
        if let data = motionManager.accelerometerData {
            if (fabs(data.acceleration.x) > 0.2) {
                // move ship
                car.physicsBody!.applyForce(CGVectorMake(40.0 * CGFloat(data.acceleration.x), 0))
            }
        }
    }
    
    // MARK: Sprite Setup
    func keyboardLetterGen (emojiIndex:Int) {
        var emojiChar = Array(emoji[emojiIndex])  // put characters of emoji into an array
        var keyboardPosition = [Int: String]()  // shuffle characters into an unordered dict
        for i in 0..<emojiChar.count {
            keyboardPosition[i] = "\(emojiChar[i])"
        }
        for i in emojiChar.count...keyboardNumberOfChars {  // fill rest of dict with repeat chars
            keyboardPosition[i] = "\(emojiChar[Int(arc4random_uniform(UInt32(emojiChar.count)))])"
        }
        
        var randomOrder = Array(0...9)
        randomOrder.shuffle()
        
        for i in 0...keyboardNumberOfChars {
            
            let keyboardNode = SKLabelNode(fontNamed:"Courier New")
            keyboardNode.name = "keyboardNode"
            keyboardNode.fontSize = 40;
            keyboardNode.text = "\(keyboardPosition[randomOrder[i]]!)"  // give node a char from the dict
            keyboardNode.position = CGPoint(x: CGFloat(i%5+1)*CGRectGetWidth(self.frame)/6, y: CGRectGetHeight(self.frame)/15 + (i<5 ? 0:70));
            self.addChild(keyboardNode)

            
            // create box around each character
            let keyboardBox = SKShapeNode(rectOfSize: CGSize(width:50, height:50))
            keyboardBox.name = "keyboardBox"
            keyboardBox.accessibilityLabel = keyboardNode.text
            keyboardBox.position = keyboardNode.position + CGPoint(x:0.0, y:12.0)
            self.addChild(keyboardBox)
        }

    }
    func setupCar() {
        
        let car = makeCar()
        
        // position and add car
        car.position = CGPoint(x:size.width / 2.0, y:CGRectGetMidY(self.frame)+100)
        addChild(car)
    }
    func makeUserTextField() {
        usersEmoji.text = "";
        usersEmoji.fontSize = 40;
        usersEmoji.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(usersEmoji)

    }
    func makeScoreBoard() {
        scoreBoard.text = "0";
        scoreBoard.fontSize = 30;
        scoreBoard.fontColor = SKColor.redColor()
        scoreBoard.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-140);
        
        self.addChild(scoreBoard)
        
    }
    func makeEmojiDisplay(emojiIndex:Int) {
        emojiDisplay.text = emoji[emojiIndex];
        emojiDisplay.fontSize = 40;
        emojiDisplay.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-80);
        
        self.addChild(emojiDisplay)
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
