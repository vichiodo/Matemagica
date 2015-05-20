
//
//  Tutorial.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 19/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import SpriteKit

class Tutorial: SKScene {
    
    var tag:Int!
    var vC: TutorialDetailViewController!
    var lblTitulo: SKLabelNode = SKLabelNode()
    
    
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        lblTitulo.fontName = "Noteworthy-Bold"
        lblTitulo.fontSize = 100
        lblTitulo.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
        lblTitulo.fontColor = SKColor.blackColor()
        addChild(lblTitulo)
        
        switch tag {
        case 1:
            vC.navigationItem.title = "SOMA"
            lblTitulo.text = "4 + 5"
            
            var numero1Img: SKSpriteNode = SKSpriteNode(imageNamed: "4")
            numero1Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.65)
            numero1Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
            addChild(numero1Img)

            
            var numero2Img: SKSpriteNode = SKSpriteNode(imageNamed: "5")
            numero2Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.45)
            numero2Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
            addChild(numero2Img)
            
            var ref = CGPathCreateMutable()
            var linha = SKShapeNode()
            
            CGPathMoveToPoint(ref, nil, size.width * 0.05, size.height * 0.325)
            CGPathAddLineToPoint(ref, nil, size.width * 0.37, size.height * 0.325)
            linha.path = ref
            linha.lineWidth = 8
            linha.fillColor = UIColor.blackColor()
            linha.strokeColor = UIColor.blackColor()
            addChild(linha)

            
            var numero3Img: SKSpriteNode = SKSpriteNode(imageNamed: "9")
            numero3Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.20)
            numero3Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
            addChild(numero3Img)

            
            
            
            for var i = 0; i < 4; i++ {
                let exemplo1Img = SKSpriteNode(imageNamed: "4")
                
                exemplo1Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo1Img.frame.size)
                exemplo1Img.physicsBody!.dynamic = false
                
                var xPos1 = (CGFloat(self.size.width * 2) * CGFloat(Double(i) / 20) + CGFloat(self.size.width))
                println(xPos1)
                
                exemplo1Img.position = CGPointMake(xPos1, numero1Img.position.y)
                exemplo1Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
                self.addChild(exemplo1Img)
                
                
                let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 3.0)
                exemplo1Img.runAction(SKAction.sequence([actionMove]))
                
                
            }
            
            
            for var i = 0; i < 5; i++ {
                let exemplo2Img = SKSpriteNode(imageNamed: "5")
                
                exemplo2Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo2Img.frame.size)
                exemplo2Img.physicsBody!.dynamic = false
                
                var xPos2 = (CGFloat(self.size.width * 2) * CGFloat(Double(i) / 20) + CGFloat(self.size.width))
                println(xPos2)
                
                exemplo2Img.position = CGPointMake(xPos2, numero2Img.position.y)
                exemplo2Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
                self.addChild(exemplo2Img)
                
                
                let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 3.0)
                exemplo2Img.runAction(SKAction.sequence([actionMove]))
                
                
            }
            
            
//            var dist = 0.1
//            for var i = 0; i < 4; i++ {
//                
//                var exemplo1Img: UIImage = UIImage(named: "4")!
//                let imageViewEx1 = UIImageView(image: exemplo1Img)
//                imageViewEx1.frame = CGRectMake(self.view!.frame.size.width * CGFloat(0.3 + dist), self.view!.frame.size.height * 0.35, self.view!.frame.size.width * 0.1, self.view!.frame.size.height * 0.15)
//                imageViewEx1.alpha = 0.0
////                self.view!.addSubview(imageViewEx1)
//                
//                UIView.animateWithDuration(2, animations: { () -> Void in
//                    
//                    imageViewEx1.alpha = 1.0
//                })
//                
//                dist += 0.1
//            }
            
            
        case 2:
            vC.navigationItem.title = "SUBTRAÇÃO"
            lblTitulo.text = "8 - 3"
        case 3:
            vC.navigationItem.title = "MULTIPLICAÇÃO"
            lblTitulo.text = "2 × 3"
        case 4:
            vC.navigationItem.title = "DIVISÃO"
            lblTitulo.text = "10 ÷ 5"
        default:
            break
        }
    }
    
}