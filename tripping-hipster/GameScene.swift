//
//  GameScene.swift
//  tripping-hipster
//
//  Created by Bronson Oka on 1/6/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let keyboard = ["a", "b", "c", "d", "e"]
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Arial")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
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
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    func keyboardLetterGen (location:CGPoint) {
        let keyboardNode = SKLabelNode(fontNamed:"Arial")
        keyboardNode.text = keyboard[Int(arc4random_uniform(5))];
        keyboardNode.fontSize = 50;
        keyboardNode.position = CGPoint(x: CGRectGetWidth(self.frame)/3 + location.x, y: CGRectGetHeight(self.frame)/15+location.y);
        self.addChild(keyboardNode)

    }
}
