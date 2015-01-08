//
//  GameScene.swift
//  tripping-hipster
//
//  Created by Bronson Oka on 1/6/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK:  - Setup constants
    // keyboard dictionary
    //let keyboard = ["¯", "\\", "_", "(", "ツ", ")","_","/","¯"]
    let keyboard = ["a", "b", "c", "d", "e","f", "g"]
    let myLabel = SKLabelNode(fontNamed:"Arial")
    
    let carSize = CGSize(width:200, height:100)
    let carName = "car"
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        myLabel.text = "Hello, World! ";
        myLabel.fontSize = 20;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        for counter in 0...6 {
            // generate keyboard with two rows
            keyboardLetterGen(CGPoint(x:55*CGFloat(counter),y:CGFloat(100)))
            keyboardLetterGen(CGPoint(x:55*CGFloat(counter),y:CGFloat(0)))
        }
        setupCar()  // generate car

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
    }
    
    // MARK: Sprite Setup
    func keyboardLetterGen (location:CGPoint) {
        let keyboardNode = SKLabelNode(fontNamed:"Arial")
        keyboardNode.name = "keyboardNode"
        keyboardNode.text = keyboard[Int(arc4random_uniform(UInt32(keyboard.count)))];
        keyboardNode.fontSize = 50;
        keyboardNode.position = CGPoint(x: CGRectGetWidth(self.frame)/3 + location.x, y: CGRectGetHeight(self.frame)/15+location.y);
        self.addChild(keyboardNode)

    }
    func setupCar() {
        
        let car = makeCar()
        
        // position and add car
        car.position = CGPoint(x:size.width / 2.0, y:size.height - 250.0)
        addChild(car)
    }
    
    func makeCar() -> SKNode {
        // make a car sprite (box with color and size)
        let car = SKSpriteNode(color: SKColor.greenColor(), size: carSize)
        car.name = carName
        return car
    }

}
