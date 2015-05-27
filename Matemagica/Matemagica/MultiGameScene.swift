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
    var resposta: Int = 0
    var numeros:Array<Int> = [1,2,3,4,5,6,7,8,9,10]
    var operacao = random(0, 3)
    var posicao: Int = 0
    var conta = SKLabelNode()
    var conta2 = SKLabelNode()
    
    var alternativa11 = SKLabelNode()
    var alternativa12 = SKLabelNode()
    var alternativa13 = SKLabelNode()
    var alternativa14 = SKLabelNode()
    var alternativa21 = SKLabelNode()
    var alternativa22 = SKLabelNode()
    var alternativa23 = SKLabelNode()
    var alternativa24 = SKLabelNode()
    
    var alternativaTocada: SKNode!
    
    var scoreGamer1: Int = 0
    var scoreGamer2: Int = 0
    
    
    
    var contasArray: Array<Contas> = Array<Contas>()
//    var alternativas1: Array<Int>!
//    var alternativas2: Array<Int>!
//    var alternativas3: Array<Int>!
//    var alternativas4: Array<Int>!
//    var respostas: Array<Int>!
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        CGPathMoveToPoint(ref, nil, 0, size.height/2)
        CGPathAddLineToPoint(ref, nil, size.width, size.height/2)
        
        line.path = ref
        line.lineWidth = 4
        line.fillColor = UIColor.blackColor()
        line.strokeColor = UIColor.blackColor()
        
        self.addChild(line)

        posicaoAlternativas()
        addOperacao()
        addContasGamer1()
        addContasGamer2()
        
        addChild(conta)
        addChild(conta2)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        alternativaTocada = self.nodeAtPoint(touchLocation)
        
        if alternativaTocada.name == "certa1" {
            scoreGamer1++
            addOperacao()
            addContasGamer1()
            println("Gamer1: \(scoreGamer1)")
        }else if alternativaTocada.name == "certa2" {
            scoreGamer2++
            addOperacao()
            addContasGamer2()
            println("Gamer2: \(scoreGamer2)")
        }
    }

    func addOperacao(){
        var op: String!
        
        
        for i in 0...10 {
            switch operacao {
            case 0: // operação +
                op = "+"
                
            case 1: // operação -
                op = "-"
                
            case 2: // operação *
                op = "*"
                
            default: // operação /
                op = "/"
                
            }
            
            var fazConta = Contas(operacao: op)
            contasArray.append(fazConta) 
        }
    }

    func addContasGamer1() {
//        var conta = SKLabelNode()
        conta.position = CGPoint(x: size.width/2, y: size.height/2+120)
        conta.fontColor = UIColor.blackColor()
        conta.zRotation = CGFloat(M_1_PI*9.85)
        conta.fontSize = 120
        conta.name = "conta1"
        conta.text = "\(contasArray[scoreGamer1].conta)"
        addAlternativasGame1()
    }
    
    func addContasGamer2(){
//        var conta2 = SKLabelNode()
        conta2.position = CGPoint(x: size.width/2, y: size.height/2-120)
        conta2.fontColor = UIColor.blackColor()
        conta2.fontSize = 120
        conta2.name = "conta2"
        conta2.text = "\(contasArray[scoreGamer2].conta)"
        addAlternativasGame2()
    }
    
    
    func addAlternativasGame1(){
        
        posicao = random(0, 3)
        
        alternativa11.name = "errado"
        alternativa12.name = "errado"
        alternativa13.name = "errado"
        alternativa14.name = "errado"



        // inserir valores nas labels
        switch posicao {
        case 0: //nuvem1
            
            alternativa11.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa2)"
            
            alternativa11.name = "certa1"
            
        case 1: //nuvem2
          
            
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa3)"
          
            alternativa12.name = "certa1"
         

        case 2: // nuvem3
         
            
            
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa13.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa3)"
           
            alternativa13.name = "certa1"
       
            
        default:
           

            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa3)"
            alternativa14.text = "\(contasArray[scoreGamer1].resposta)"
         
            alternativa14.name = "certa1"
      
        }

    }
    
    func addAlternativasGame2(){
        
        posicao = random(0, 3)
        
        alternativa21.name = "errado"
        alternativa22.name = "errado"
        alternativa23.name = "errado"
        alternativa24.name = "errado"
        
        
        
        // inserir valores nas labels
        switch posicao {
        case 0: //nuvem1
            
            alternativa21.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa2)"
            
            alternativa21.name = "certa2"
            
        case 1: //nuvem2
            
            
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa3)"
            
            alternativa22.name = "certa2"
            
            
        case 2: // nuvem3
            
            
            
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa23.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa3)"
            
            alternativa23.name = "certa2"
            
            
        default:
            
            
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa3)"
            alternativa24.text = "\(contasArray[scoreGamer2].resposta)"
            
            alternativa24.name = "certa2"
            
        }
        
    }

    func posicaoAlternativas(){
        
        ////////////// cabeça pra baixo
        alternativa11.position = CGPoint(x: size.width/2+200, y: size.height/2+400)
        alternativa11.fontColor = UIColor.blackColor()
        alternativa11.zRotation = CGFloat(M_1_PI*9.85)
        alternativa11.fontSize = 50
        addChild(alternativa11)
        
        alternativa12.position = CGPoint(x: size.width/2-200, y: size.height/2+400)
        alternativa12.fontColor = UIColor.blackColor()
        alternativa12.zRotation = CGFloat(M_1_PI*9.85)
        alternativa12.fontSize = 50
        addChild(alternativa12)
        
        alternativa14.position = CGPoint(x: size.width/2+200, y: size.height/2+250)
        alternativa14.fontColor = UIColor.blackColor()
        alternativa14.zRotation = CGFloat(M_1_PI*9.85)
        alternativa14.fontSize = 50
        addChild(alternativa14)
        
        alternativa13.position = CGPoint(x: size.width/2-200, y: size.height/2+250)
        alternativa13.fontColor = UIColor.blackColor()
        alternativa13.zRotation = CGFloat(M_1_PI*9.85)
        alternativa13.fontSize = 50
        addChild(alternativa13)
        
        /////////////////////////////certo
        alternativa21.position = CGPoint(x: size.width/2+200, y: size.height/2-400)
        alternativa21.fontColor = UIColor.blackColor()
        alternativa21.fontSize = 50
        addChild(alternativa21)
        
        alternativa22.position = CGPoint(x: size.width/2-200, y: size.height/2-400)
        alternativa22.fontColor = UIColor.blackColor()
        alternativa22.fontSize = 50
        addChild(alternativa22)
        
        alternativa24.position = CGPoint(x: size.width/2+200, y: size.height/2-250)
        alternativa24.fontColor = UIColor.blackColor()
        alternativa24.fontSize = 50
        addChild(alternativa24)
        
        alternativa23.position = CGPoint(x: size.width/2-200, y: size.height/2-250)
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
    


}
