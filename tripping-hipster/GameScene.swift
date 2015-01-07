//
//  GameScene.swift
//  tripping-hipster
//
//  Created by Bronson Oka on 1/6/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Courier New")
        myLabel.text = "Game Over";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetHeight(self.frame)*3/4);
        
        self.addChild(myLabel)
        
        let gameOver = SKLabelNode(fontNamed:"Courier New")
        gameOver.text = "You Lose!"+"\(CGRectGetHeight(self.frame)) "+"\(CGRectGetWidth(self.frame))";
        gameOver.fontSize = 15;
        gameOver.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetHeight(self.frame)/2);
        
        self.addChild(gameOver)
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
}
