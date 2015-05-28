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
    var vC: MiddleViewController!
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()

    var ref = CGPathCreateMutable()
    var line = SKShapeNode()
    var resposta: Int = 0
    var posicao: Int = 0
    var conta1 = SKLabelNode()
    var conta2 = SKLabelNode()
    
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()
    
    var alternativa11 = SKLabelNode()
    var alternativa12 = SKLabelNode()
    var alternativa13 = SKLabelNode()
    var alternativa14 = SKLabelNode()
    var alternativa21 = SKLabelNode()
    var alternativa22 = SKLabelNode()
    var alternativa23 = SKLabelNode()
    var alternativa24 = SKLabelNode()
    
    var alternativaTocada: SKNode!
    
    var index1: Int = -1
    var index2: Int = -1
    
    var scoreGamer1: Int = 0
    var scoreGamer2: Int = 0
    
    var vitoriasJogador1: Int = 0
    var vitoriasJogador2: Int = 0
    
    let lblVitoriasJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblVitoriasJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    
    let lblResultadoJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    let lblResultadoJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    
    let lblPontuacaoJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblPontuacaoJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    
    let lblNomeJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblNomeJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")

    
    //animação
    let aparecer = SKAction.fadeInWithDuration(0.5)
    
    var contasArray: Array<Contas> = Array<Contas>()
    
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
        
        addChild(conta1)
        addChild(conta2)
        
        index1 = userDef.objectForKey("jogador1") as! Int
        index2 = userDef.objectForKey("jogador2") as! Int
        
        // instanciação e posicionamento da label do jogador 1
        lblResultadoJogador1.position = CGPoint(x: size.width/2, y: size.height * 0.825)
        lblResultadoJogador1.fontSize = 150
        lblResultadoJogador1.zRotation = CGFloat(M_1_PI*9.85)
        lblResultadoJogador1.alpha = 0
        addChild(lblResultadoJogador1)
        
        // instanciação e posicionamento da label do jogador 2
        lblResultadoJogador2.position = CGPoint(x: size.width/2, y: size.height * 0.175)
        lblResultadoJogador2.fontSize = 150
        lblResultadoJogador2.alpha = 0
        addChild(lblResultadoJogador2)
        
        
        // instanciação e posicionamento da label do jogador 1
        let lblTextPontuacao1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
        lblTextPontuacao1.position = CGPoint(x: size.width * 0.1, y: size.height * 0.55)
        lblTextPontuacao1.fontSize = 30
        lblTextPontuacao1.zRotation = CGFloat(M_1_PI*9.85)
        lblTextPontuacao1.fontColor = SKColor.blackColor()
        lblTextPontuacao1.text = "Pontuação"
        addChild(lblTextPontuacao1)

        lblPontuacaoJogador1.position = CGPoint(x: size.width * 0.1, y: size.height * 0.6)
        lblPontuacaoJogador1.fontSize = 60
        lblPontuacaoJogador1.zRotation = CGFloat(M_1_PI*9.85)
        lblPontuacaoJogador1.fontColor = SKColor.blackColor()
        lblPontuacaoJogador1.text = "\(scoreGamer1)"
        addChild(lblPontuacaoJogador1)
        
        lblNomeJogador1.position = CGPoint(x: size.width * 0.9, y: size.height * 0.55)
        lblNomeJogador1.fontSize = 30
        lblNomeJogador1.zRotation = CGFloat(M_1_PI*9.85)
        lblNomeJogador1.fontColor = SKColor.blackColor()
        lblNomeJogador1.text = "\(players[index1].nomePlayer)"
        addChild(lblNomeJogador1)

        vitoriasJogador1 = (players[index1].scorePlayer).toInt()!
        lblVitoriasJogador1.position = CGPoint(x: size.width * 0.9, y: size.height * 0.6)
        lblVitoriasJogador1.fontSize = 60
        lblVitoriasJogador1.zRotation = CGFloat(M_1_PI*9.85)
        lblVitoriasJogador1.fontColor = SKColor.blackColor()
        lblVitoriasJogador1.text = "\(vitoriasJogador1)"
        addChild(lblVitoriasJogador1)

        
        // instanciação e posicionamento da label do jogador 2
        let lblTextPontuacao2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
        lblTextPontuacao2.position = CGPoint(x: size.width * 0.9, y: size.height * 0.45)
        lblTextPontuacao2.fontSize = 30
        lblTextPontuacao2.fontColor = SKColor.blackColor()
        lblTextPontuacao2.text = "Pontuação"
        addChild(lblTextPontuacao2)

        lblPontuacaoJogador2.position = CGPoint(x: size.width * 0.9, y: size.height * 0.4)
        lblPontuacaoJogador2.fontSize = 60
        lblPontuacaoJogador2.fontColor = SKColor.blackColor()
        lblPontuacaoJogador2.text = "\(scoreGamer2)"
        addChild(lblPontuacaoJogador2)
        
        lblNomeJogador2.position = CGPoint(x: size.width * 0.1, y: size.height * 0.45)
        lblNomeJogador2.fontSize = 30
        lblNomeJogador2.fontColor = SKColor.blackColor()
        lblNomeJogador2.text = "\(players[index2].nomePlayer)"
        addChild(lblNomeJogador2)

        vitoriasJogador2 = (players[index2].scorePlayer).toInt()!
        lblVitoriasJogador2.position = CGPoint(x: size.width * 0.1, y: size.height * 0.4)
        lblVitoriasJogador2.fontSize = 60
        lblVitoriasJogador2.fontColor = SKColor.blackColor()
        lblVitoriasJogador2.text = "\(vitoriasJogador2)"
        addChild(lblVitoriasJogador2)


    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        alternativaTocada = self.nodeAtPoint(touchLocation)
        
        ////////// TROCAR PARA 10 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        if scoreGamer1 < 2 && scoreGamer2 < 2 {
            if alternativaTocada.name == "certa1" {
                println("tocou na certa 1")
                scoreGamer1++
                lblPontuacaoJogador1.text = "\(scoreGamer1)"
                if scoreGamer1 == 2 {
                    lblResultadoJogador1.hidden = false
                    lblResultadoJogador2.hidden = false
                    lblResultadoJogador1.text = "VENCEU"
                    lblResultadoJogador1.fontColor = SKColor.blueColor()
                    lblResultadoJogador2.text = "PERDEU"
                    lblResultadoJogador2.fontColor = SKColor.redColor()
                    
                    let sequencia = SKAction.sequence([aparecer])
                    lblResultadoJogador1.runAction(sequencia)
                    lblResultadoJogador2.runAction(sequencia)
                    
                    vitoriasJogador1++
                    lblVitoriasJogador1.text = "\(vitoriasJogador1)"
                    players[index1].scorePlayer = String(vitoriasJogador1)
                    
                    let alerta: UIAlertController = UIAlertController(title: "", message: "Deseja jogar novamente?", preferredStyle:.Alert)
                    let al1: UIAlertAction = UIAlertAction(title: "NÃO", style: .Default, handler: nil)
                    // adiciona a ação no alertController
                    [alerta.addAction(al1)]
                    
                    let al2: UIAlertAction = UIAlertAction(title: "SIM", style: .Default, handler: { (ACTION) -> Void in
                        self.lblResultadoJogador1.hidden = true
                        self.lblResultadoJogador2.hidden = true
                        self.scoreGamer1 = 0
                        self.scoreGamer2 = 0
                        self.lblPontuacaoJogador1.text = "\(self.scoreGamer1)"
                        self.lblPontuacaoJogador2.text = "\(self.scoreGamer2)"
                        self.addOperacao()
                        self.addContasGamer1()
                        self.addContasGamer2()
                    })
                    [alerta.addAction(al2)]
                    vC.presentViewController(alerta, animated: true, completion: nil)

                }
                else {
                    addContasGamer1()
                    println("Gamer1: \(scoreGamer1)")
                }
            }
//            else if alternativaTocada.name == "errado1" {
//                println("errooooouuuu primeiro")
//            }
            else if alternativaTocada.name == "certa2" {
                println("tocou na certa 2")
                scoreGamer2++
                lblPontuacaoJogador2.text = "\(scoreGamer2)"
                if scoreGamer2 == 2 {
                    lblResultadoJogador1.hidden = false
                    lblResultadoJogador2.hidden = false
                    lblResultadoJogador1.text = "PERDEU"
                    lblResultadoJogador1.fontColor = SKColor.redColor()
                    lblResultadoJogador2.text = "VENCEU"
                    lblResultadoJogador2.fontColor = SKColor.blueColor()
                    
                    let sequencia = SKAction.sequence([aparecer])
                    lblResultadoJogador1.runAction(sequencia)
                    lblResultadoJogador2.runAction(sequencia)
                    
                    vitoriasJogador2++
                    lblVitoriasJogador2.text = "\(vitoriasJogador2)"
                    players[index2].scorePlayer = String(vitoriasJogador2)
                    
                    let alerta: UIAlertController = UIAlertController(title: "", message: "Deseja jogar novamente?", preferredStyle:.Alert)
                    let al1: UIAlertAction = UIAlertAction(title: "NÃO", style: .Default, handler: nil)
                    // adiciona a ação no alertController
                    [alerta.addAction(al1)]
                    
                    let al2: UIAlertAction = UIAlertAction(title: "SIM", style: .Default, handler: { (ACTION) -> Void in
                        self.lblResultadoJogador1.hidden = true
                        self.lblResultadoJogador2.hidden = true
                        self.scoreGamer1 = 0
                        self.scoreGamer2 = 0
                        self.lblPontuacaoJogador1.text = "\(self.scoreGamer1)"
                        self.lblPontuacaoJogador2.text = "\(self.scoreGamer2)"

                        self.addOperacao()
                        self.addContasGamer1()
                        self.addContasGamer2()
                    })
                    [alerta.addAction(al2)]
                    vC.presentViewController(alerta, animated: true, completion: nil)

                }
                else {
                    addContasGamer2()
                    println("Gamer2: \(scoreGamer2)")
                }
            }
        }
        
        //SALVAR NO COREDATA(SINGLE TAMBEM)
        //MOSTRAR O NOME E FOTO DO JOGADOR
        PlayerManager.sharedInstance.salvarPlayer()
        
    }
    
    func addOperacao(){
        var op: String!
        contasArray.removeAll(keepCapacity: true)
        
        for i in 0...10 {
            var operacao = random(0, 3)
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
        conta1.position = CGPoint(x: size.width/2, y: size.height/2+120)
        conta1.fontColor = UIColor.blackColor()
        conta1.zRotation = CGFloat(M_1_PI*9.85)
        conta1.fontSize = 120
        conta1.name = "conta1"
        conta1.text = "\(contasArray[scoreGamer1].conta)"
        addAlternativasGame1()
    }
    
    func addContasGamer2(){
        conta2.position = CGPoint(x: size.width/2, y: size.height/2-120)
        conta2.fontColor = UIColor.blackColor()
        conta2.fontSize = 120
        conta2.name = "conta2"
        conta2.text = "\(contasArray[scoreGamer2].conta)"
        addAlternativasGame2()
    }
    
    
    func addAlternativasGame1(){
        posicao = random(0, 3)
        alternativa11.name = "errado1"
        alternativa12.name = "errado1"
        alternativa13.name = "errado1"
        alternativa14.name = "errado1"
        
        // inserir valores nas labels
        switch posicao {
        case 0: //nuvem1
            alternativa11.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa2)"
            
            alternativa11.name = "certa1"
            self.enumerateChildNodesWithName("bloco1") {
                node, stop in
                node.name = "certa1"
            }
            
        case 1: //nuvem2
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa3)"
            
            alternativa12.name = "certa1"
            self.enumerateChildNodesWithName("bloco2") {
                node, stop in
                node.name = "certa1"
            }
        case 2: // nuvem3
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa13.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa3)"
            
            alternativa13.name = "certa1"
            self.enumerateChildNodesWithName("bloco3") {
                node, stop in
                node.name = "certa1"
            }
        default:
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa3)"
            alternativa14.text = "\(contasArray[scoreGamer1].resposta)"
            
            alternativa14.name = "certa1"
            self.enumerateChildNodesWithName("bloco4") {
                node, stop in
                node.name = "certa1"
            }
        }
        
    }
    
    func addAlternativasGame2(){
        posicao = random(0, 3)
        
        alternativa21.name = "errado2"
        alternativa22.name = "errado2"
        alternativa23.name = "errado2"
        alternativa24.name = "errado2"
        
        // inserir valores nas labels
        switch posicao {
        case 0: //nuvem1
            alternativa21.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa2)"
            
            alternativa21.name = "certa2"
            self.enumerateChildNodesWithName("bloco5") {
                node, stop in
                node.name = "certa2"
            }
        case 1: //nuvem2
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa3)"
            
            alternativa22.name = "certa2"
            self.enumerateChildNodesWithName("bloco6") {
                node, stop in
                node.name = "certa2"
            }
        case 2: // nuvem3
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa23.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa3)"
            
            alternativa23.name = "certa2"
            self.enumerateChildNodesWithName("bloco7") {
                node, stop in
                node.name = "certa2"
            }
        default:
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa3)"
            alternativa24.text = "\(contasArray[scoreGamer2].resposta)"
            
            alternativa24.name = "certa2"
            self.enumerateChildNodesWithName("bloco8") {
                node, stop in
                node.name = "certa2"
            }
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
        
        
        for var i = 0; i < 8; ++i {
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
