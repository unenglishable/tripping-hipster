//
//  GameOverScene.swift
//  tripping-hipster
//
//  Created by Corey Chang on 1/10/15.
//  Copyright (c) 2015 AM. All rights reserved.
//

//
//  GameOverScene.swift
//  SpriteTest
//
//  Created by Corey Chang on 1/1/15.
//  Copyright (c) 2015 FastlaneFire. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won:Bool) {
        
        super.init(size: size)
        
        // 1
        backgroundColor = SKColor.blackColor()
        
        // 2
        var message = won ? "You Won!" : "You Suck!"
        
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        // 4
        runAction(SKAction.sequence([
            SKAction.waitForDuration(3.0),
            SKAction.runBlock() {
                // 5
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
