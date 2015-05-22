//
//  MultiGameScene.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 22/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import Foundation
import SpriteKit

class MultiGameScene: SKScene {
    var ref = CGPathCreateMutable()
    var line = SKShapeNode()
    
    var alternativa11 = SKLabelNode()
    var alternativa12 = SKLabelNode()
    var alternativa13 = SKLabelNode()
    var alternativa14 = SKLabelNode()
    var alternativa21 = SKLabelNode()
    var alternativa22 = SKLabelNode()
    var alternativa23 = SKLabelNode()
    var alternativa24 = SKLabelNode()
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        CGPathMoveToPoint(ref, nil, 0, size.height/2)
        CGPathAddLineToPoint(ref, nil, size.width, size.height/2)
        
        line.path = ref
        line.lineWidth = 4
        line.fillColor = UIColor.blackColor()
        line.strokeColor = UIColor.blackColor()
        
        self.addChild(line)
        
        
        addConta()
        addAlternativas()
        
    }
    
    func addConta(){
        
        for var i = 0; i < 2; ++i{
            var conta = SKLabelNode()
            if i == 0{
                conta.position = CGPoint(x: size.width/2, y: size.height/2+120)
                conta.text = "1 + 1"
                conta.fontColor = UIColor.blackColor()
                conta.zRotation = CGFloat(M_1_PI*9.85)
                conta.fontSize = 120
                conta.name = "conta\(i+1)"
            }
            else{
                conta.position = CGPoint(x: size.width/2, y: size.height/2-120)
                conta.text = "1 + 1"
                conta.fontColor = UIColor.blackColor()
                conta.fontSize = 120
                conta.name = "conta\(i+1)"
            }
            
            self.addChild(conta)
        }
    }
    
    func addAlternativas(){
        
        //////////////////////////////de cabeça para baixo
        alternativa11.position = CGPoint(x: size.width/2+200, y: size.height/2+400)
        alternativa11.text = "alternativa1"
        alternativa11.fontColor = UIColor.blackColor()
        alternativa11.zRotation = CGFloat(M_1_PI*9.85)
        alternativa11.fontSize = 50
        addChild(alternativa11)
        
        alternativa12.position = CGPoint(x: size.width/2-200, y: size.height/2+400)
        alternativa12.text = "alternativa2"
        alternativa12.fontColor = UIColor.blackColor()
        alternativa12.zRotation = CGFloat(M_1_PI*9.85)
        alternativa12.fontSize = 50
        addChild(alternativa12)
        
        alternativa14.position = CGPoint(x: size.width/2+200, y: size.height/2+250)
        alternativa14.text = "alternativa3"
        alternativa14.fontColor = UIColor.blackColor()
        alternativa14.zRotation = CGFloat(M_1_PI*9.85)
        alternativa14.fontSize = 50
        addChild(alternativa14)
        
        alternativa13.position = CGPoint(x: size.width/2-200, y: size.height/2+250)
        alternativa13.text = "alternativa4"
        alternativa13.fontColor = UIColor.blackColor()
        alternativa13.zRotation = CGFloat(M_1_PI*9.85)
        alternativa13.fontSize = 50
        addChild(alternativa13)
        
        /////////////////////////////certo
        alternativa21.position = CGPoint(x: size.width/2+200, y: size.height/2-400)
        alternativa21.text = "alternativa1"
        alternativa21.fontColor = UIColor.blackColor()
        alternativa21.fontSize = 50
        addChild(alternativa21)
        
        alternativa22.position = CGPoint(x: size.width/2-200, y: size.height/2-400)
        alternativa22.text = "alternativa2"
        alternativa22.fontColor = UIColor.blackColor()
        alternativa22.fontSize = 50
        addChild(alternativa22)
        
        alternativa24.position = CGPoint(x: size.width/2+200, y: size.height/2-250)
        alternativa24.text = "alternativa3"
        alternativa24.fontColor = UIColor.blackColor()
        alternativa24.fontSize = 50
        addChild(alternativa24)
        
        alternativa23.position = CGPoint(x: size.width/2-200, y: size.height/2-250)
        alternativa23.text = "alternativa4"
        alternativa23.fontColor = UIColor.blackColor()
        alternativa23.fontSize = 50
        addChild(alternativa23)
        
        
        for var i = 0; i<8; ++i {
            let bloco = SKSpriteNode(imageNamed: "bloco")

            if i == 0 {
                bloco.position = CGPoint(x: alternativa11.position.x, y: alternativa11.position.y-20)
            }
            if i == 1 {
                bloco.position = CGPoint(x: alternativa12.position.x, y: alternativa12.position.y-20)
            }
            if i == 2 {
                bloco.position = CGPoint(x: alternativa13.position.x, y: alternativa13.position.y-20)
            }
            if i == 3 {
                bloco.position = CGPoint(x: alternativa14.position.x, y: alternativa14.position.y-20)
            }
            if i == 4 {
                bloco.position = CGPoint(x: alternativa21.position.x, y: alternativa21.position.y+20)
            }
            if i == 5 {
                bloco.position = CGPoint(x: alternativa22.position.x, y: alternativa22.position.y+20)
            }
            if i == 6 {
                bloco.position = CGPoint(x: alternativa23.position.x, y: alternativa23.position.y+20)
            }
            if i == 7 {
                bloco.position = CGPoint(x: alternativa24.position.x, y: alternativa24.position.y+20)
            }
            
            bloco.name = "bloco\(i+1)"
            bloco.size = CGSize(width: 300, height: 80)
            bloco.zPosition = -100
            addChild(bloco)
        }

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)

        
    }

}
