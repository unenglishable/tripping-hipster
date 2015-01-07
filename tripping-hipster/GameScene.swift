//
//  GameScene.swift
//  tripping-hipster
//
//  Created by Bronson Oka on 1/6/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // keyboard dictionary
    let keyboard = ["¯", "\\", "_", "(", "ツ", ")","_","/","¯"]
    let myLabel = SKLabelNode(fontNamed:"Arial")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        myLabel.text = "Hello, World! ";
        myLabel.fontSize = 15;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        for counter in 0...6 {
            
            keyboardLetterGen(CGPoint(x:55*CGFloat(counter),y:CGFloat(100)))
            keyboardLetterGen(CGPoint(x:55*CGFloat(counter),y:CGFloat(0)))
        }

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let touch = touches.anyObject() as UITouch
            let touchLocation = touch.locationInNode(self)
            let touchNode = self.nodeAtPoint(touchLocation)
            
            if touchNode.name == "keyboardNode" {
                println((touchNode as SKLabelNode).text)
                myLabel.text = myLabel.text+(touchNode as SKLabelNode).text
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    func keyboardLetterGen (location:CGPoint) {
        let keyboardNode = SKLabelNode(fontNamed:"Arial")
        keyboardNode.name = "keyboardNode"
        keyboardNode.text = keyboard[Int(arc4random_uniform(UInt32(keyboard.count)))];
        keyboardNode.fontSize = 50;
        keyboardNode.position = CGPoint(x: CGRectGetWidth(self.frame)/3 + location.x, y: CGRectGetHeight(self.frame)/15+location.y);
        self.addChild(keyboardNode)

    }
}
