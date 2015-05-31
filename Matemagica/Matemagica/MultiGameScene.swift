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
    var vC: MultiGameViewController!
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var ref = CGPathCreateMutable()
    var line = SKShapeNode()
    var randomPosition: Int = 0
    var calculation1 = SKLabelNode()
    var calculation2 = SKLabelNode()
    
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()
    
    var alternative11 = SKLabelNode()
    var alternative12 = SKLabelNode()
    var alternative13 = SKLabelNode()
    var alternative14 = SKLabelNode()
    var alternative21 = SKLabelNode()
    var alternative22 = SKLabelNode()
    var alternative23 = SKLabelNode()
    var alternative24 = SKLabelNode()
    
    var alternativeTouched: SKNode!
    
    var index1: Int = -1
    var index2: Int = -1
    
    var scoreGamer1: Int = 0
    var scoreGamer2: Int = 0
    
    var victoriesPlayer1: Int = 0
    var victoriesPlayer2: Int = 0
    
    let lblVictoriesPlayer1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblVictoriesPlayer2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    
    let lblResultPlayer1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    let lblResultPlayer2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    
    let lblScorePlayer1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblScorePlayer2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    
    let lblNamePlayer1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblNamePlayer2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    
    let back = SKSpriteNode(imageNamed: "voltar")
    
    //animação
    let show = SKAction.fadeInWithDuration(0.5)
    
    var arrayCalculations: Array<Contas> = Array<Contas>()
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        // "botao" voltar
        back.position = CGPoint(x: 53.5, y: size.height - 65.6)
        back.size = CGSize(width: 75, height: 75)
        addChild(back)
        
        // notificationCenter para verificar quando voltar para a view anterior ele para o jogo
        var notification:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "pause", name: "pauseMulti", object: nil)
        
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
        
        addChild(calculation1)
        addChild(calculation2)
        
        index1 = userDef.objectForKey("jogador1") as! Int
        index2 = userDef.objectForKey("jogador2") as! Int
        
        // instanciação e posicionamento da label do jogador 1
        lblResultPlayer1.position = CGPoint(x: size.width/2, y: size.height * 0.825)
        lblResultPlayer1.fontSize = 150
        lblResultPlayer1.zRotation = CGFloat(M_1_PI*9.85)
        lblResultPlayer1.alpha = 0
        addChild(lblResultPlayer1)
        
        // instanciação e posicionamento da label do jogador 2
        lblResultPlayer2.position = CGPoint(x: size.width/2, y: size.height * 0.175)
        lblResultPlayer2.fontSize = 150
        lblResultPlayer2.alpha = 0
        addChild(lblResultPlayer2)
        
        // instanciação e posicionamento da label do jogador 1
        let lblTextScore1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
        lblTextScore1.position = CGPoint(x: size.width * 0.1, y: size.height * 0.55)
        lblTextScore1.fontSize = 30
        lblTextScore1.zRotation = CGFloat(M_1_PI*9.85)
        lblTextScore1.fontColor = SKColor.blackColor()
        lblTextScore1.text = "Pontuação"
        addChild(lblTextScore1)
        
        lblScorePlayer1.position = CGPoint(x: size.width * 0.1, y: size.height * 0.6)
        lblScorePlayer1.fontSize = 60
        lblScorePlayer1.zRotation = CGFloat(M_1_PI*9.85)
        lblScorePlayer1.fontColor = SKColor.blackColor()
        lblScorePlayer1.text = "\(scoreGamer1)"
        addChild(lblScorePlayer1)
        
        lblNamePlayer1.position = CGPoint(x: size.width * 0.9, y: size.height * 0.55)
        lblNamePlayer1.fontSize = 30
        lblNamePlayer1.zRotation = CGFloat(M_1_PI*9.85)
        lblNamePlayer1.fontColor = SKColor.blackColor()
        lblNamePlayer1.text = "\(players[index1].nomePlayer)"
        addChild(lblNamePlayer1)
        
        victoriesPlayer1 = (players[index1].scorePlayer).toInt()!
        lblVictoriesPlayer1.position = CGPoint(x: size.width * 0.9, y: size.height * 0.6)
        lblVictoriesPlayer1.fontSize = 60
        lblVictoriesPlayer1.zRotation = CGFloat(M_1_PI*9.85)
        lblVictoriesPlayer1.fontColor = SKColor.blackColor()
        lblVictoriesPlayer1.text = "\(victoriesPlayer1)"
        addChild(lblVictoriesPlayer1)
        
        
        // instanciação e posicionamento da label do jogador 2
        let lblTextScore2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
        lblTextScore2.position = CGPoint(x: size.width * 0.9, y: size.height * 0.45)
        lblTextScore2.fontSize = 30
        lblTextScore2.fontColor = SKColor.blackColor()
        lblTextScore2.text = "Pontuação"
        addChild(lblTextScore2)
        
        lblScorePlayer2.position = CGPoint(x: size.width * 0.9, y: size.height * 0.4)
        lblScorePlayer2.fontSize = 60
        lblScorePlayer2.fontColor = SKColor.blackColor()
        lblScorePlayer2.text = "\(scoreGamer2)"
        addChild(lblScorePlayer2)
        
        lblNamePlayer2.position = CGPoint(x: size.width * 0.1, y: size.height * 0.45)
        lblNamePlayer2.fontSize = 30
        lblNamePlayer2.fontColor = SKColor.blackColor()
        lblNamePlayer2.text = "\(players[index2].nomePlayer)"
        addChild(lblNamePlayer2)
        
        victoriesPlayer2 = (players[index2].scorePlayer).toInt()!
        lblVictoriesPlayer2.position = CGPoint(x: size.width * 0.1, y: size.height * 0.4)
        lblVictoriesPlayer2.fontSize = 60
        lblVictoriesPlayer2.fontColor = SKColor.blackColor()
        lblVictoriesPlayer2.text = "\(victoriesPlayer2)"
        addChild(lblVictoriesPlayer2)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        alternativeTouched = self.nodeAtPoint(touchLocation)
        
        if back.containsPoint(touchLocation){
            vC.voltar()
        }
        
        if scoreGamer1 < 10 && scoreGamer2 < 10 {
            if alternativeTouched.name == "certo1" || alternativeTouched.name == "certo2" || alternativeTouched.name == "certo3" || alternativeTouched.name == "certo4" {
                scoreGamer1++
                lblScorePlayer1.text = "\(scoreGamer1)"
                if scoreGamer1 == 10 {
                    lblResultPlayer1.hidden = false
                    lblResultPlayer2.hidden = false
                    lblResultPlayer1.text = "VENCEU"
                    lblResultPlayer1.fontColor = SKColor.blueColor()
                    lblResultPlayer2.text = "PERDEU"
                    lblResultPlayer2.fontColor = SKColor.redColor()
                    
                    let sequence = SKAction.sequence([show])
                    lblResultPlayer1.runAction(sequence)
                    lblResultPlayer2.runAction(sequence)
                    
                    victoriesPlayer1++
                    lblVictoriesPlayer1.text = "\(victoriesPlayer1)"
                    players[index1].scorePlayer = String(victoriesPlayer1)
                    
                    
                    var alertview = JSSAlertView().show(vC, title: "Quer jogar de novo?", buttonText: "Sim!", cancelButtonText: "Não", color: UIColorFromHex(0x3498db, alpha: 1))
                    alertview.addAction(alertAction)
                    alertview.setTextTheme(.Light)
                    
                    
                }
                else {
                    addContasGamer1()
                    println("Gamer1: \(scoreGamer1)")
                }
            }
            else if alternativeTouched.name == "errado1" || alternativeTouched.name == "errado2" || alternativeTouched.name == "errado3" || alternativeTouched.name == "errado4" {
                println("jogador 1 errou")
            }
            else if alternativeTouched.name == "certo5" || alternativeTouched.name == "certo6" || alternativeTouched.name == "certo7" || alternativeTouched.name == "certo8" {
                scoreGamer2++
                lblScorePlayer2.text = "\(scoreGamer2)"
                if scoreGamer2 == 10 {
                    lblResultPlayer1.hidden = false
                    lblResultPlayer2.hidden = false
                    lblResultPlayer1.text = "PERDEU"
                    lblResultPlayer1.fontColor = SKColor.redColor()
                    lblResultPlayer2.text = "VENCEU"
                    lblResultPlayer2.fontColor = SKColor.blueColor()
                    
                    let sequence = SKAction.sequence([show])
                    lblResultPlayer1.runAction(sequence)
                    lblResultPlayer2.runAction(sequence)
                    
                    victoriesPlayer2++
                    lblVictoriesPlayer2.text = "\(victoriesPlayer2)"
                    players[index2].scorePlayer = String(victoriesPlayer2)
                    
                    var alertview = JSSAlertView().show(vC, title: "Quer jogar de novo?", buttonText: "Sim!", cancelButtonText: "Não", color: UIColorFromHex(0x3498db, alpha: 1))
                    alertview.addAction(alertAction)
                    alertview.setTextTheme(.Light)
                }
                else {
                    addContasGamer2()
                    println("Gamer2: \(scoreGamer2)")
                }
            }
            else if alternativeTouched.name == "errado5" || alternativeTouched.name == "errado6" || alternativeTouched.name == "errado7" || alternativeTouched.name == "errado8" {
                println("jogador 2 errou")
                
                for var i = 5; i < 9; i++ {
                    self.enumerateChildNodesWithName("errado\(i)") {
                        node, stop in
                        node.userInteractionEnabled = false
                    }
                }


                animateWrong(calculation2)
                
                
            }
            
        }
        PlayerManager.sharedInstance.salvarPlayer()
    }
    
    //    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    //        let touch = (touches as NSSet).allObjects[0] as! UITouch
    //        println("habilita toque")
    //        touch.view.userInteractionEnabled = true
    //
    //    }
    
    func animateWrong(animate: SKLabelNode) {
        let amplitudeX:CGFloat = 20;
        let numberOfShakes = 2;
        var actionsArray:[SKAction] = [];
        for index in 1...Int(numberOfShakes) {
            // build a new random shake and add it to the list
            let posX1 = CGFloat(animate.position.x) + amplitudeX
            let shake1: SKAction = SKAction.moveTo(CGPoint(x: posX1, y: animate.position.y), duration: 0.05)
            shake1.timingMode = SKActionTimingMode.EaseOut
            actionsArray.append(shake1)
            actionsArray.append(shake1.reversedAction())
            
            let posX2 = CGFloat(animate.position.x) - amplitudeX
            let shake2: SKAction = SKAction.moveTo(CGPoint(x: posX2, y: animate.position.y), duration: 0.05)
            shake2.timingMode = SKActionTimingMode.EaseOut
            actionsArray.append(shake2)
            actionsArray.append(shake2.reversedAction())

        }
        
        let back: SKAction = SKAction.moveTo(CGPoint(x: animate.position.x, y: animate.position.y), duration: 0.05)
        actionsArray.append(back)
        let actionSeq = SKAction.sequence(actionsArray)
        animate.runAction(actionSeq)
        
        
        //        var shake:CABasicAnimation = CABasicAnimation(keyPath: "position.x")
        //        shake.duration = 0.1
        //        shake.repeatCount = 2
        //        shake.autoreverses = true
        //
        //        var from_point:CGPoint = CGPointMake(animate.position.x - 5, animate.position.y)
        //        var from_value:NSValue = NSValue(CGPoint: from_point)
        //
        //        var to_point:CGPoint = CGPointMake(animate.position.x + 5, animate.position.y)
        //        var to_value:NSValue = NSValue(CGPoint: to_point)
        //
        //        shake.fromValue = from_value
        //        shake.toValue = to_value
        //        animate.animationDidStart(shake)
        //        animate.
        //        animate.runAction(SKAction.animationDidStart(CABasicAnimation(keyPath: position)))
        //        iv.layer.addAnimation(shake, forKey: "position")
        //        CATransaction.commit()
        //
        //
        //
        //        let valor = 5
        //
        //        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position.x"];
        //        [shake setDuration:0.06];
        //        [shake setRepeatCount:2];
        //        [shake setAutoreverses:YES];
        //        [shake setFromValue:[NSNumber numberWithFloat:busca.center.x - valor]];
        //        [shake setToValue:[NSNumber numberWithFloat:busca.center.x + valor]];
        //
        //        [busca.layer addAnimation:shake forKey:@"shake"];
        
    }
    
    func alertAction() {
        lblResultPlayer1.hidden = true
        lblResultPlayer2.hidden = true
        scoreGamer1 = 0
        scoreGamer2 = 0
        lblScorePlayer1.text = "\(self.scoreGamer1)"
        lblScorePlayer2.text = "\(self.scoreGamer2)"
        
        addOperacao()
        addContasGamer1()
        addContasGamer2()
    }
    
    func addOperacao() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView: UIVisualEffectView = UIVisualEffectView()
        // Blur Effect
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = vC.view.bounds
        
        // Vibrancy Effect
        var vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        var vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = vC.view.bounds
        
        // Label for vibrant text
        var vibrantLabel1 = UILabel()
        vibrantLabel1.text = "Quem acertar 10 contas primeiro ganha!"
        vibrantLabel1.font = UIFont.systemFontOfSize(30.0)
        vibrantLabel1.sizeToFit()
        vibrantLabel1.center = vC.view.center
        
        var vibrantLabel2 = UILabel()
        vibrantLabel2.text = "3"
        vibrantLabel2.font = UIFont.systemFontOfSize(72.0)
        vibrantLabel2.sizeToFit()
        vibrantLabel2.center = vC.view.center
        
        var vibrantLabel3 = UILabel()
        vibrantLabel3.text = "2"
        vibrantLabel3.font = UIFont.systemFontOfSize(72.0)
        vibrantLabel3.sizeToFit()
        vibrantLabel3.center = vC.view.center
        
        var vibrantLabel4 = UILabel()
        vibrantLabel4.text = "1"
        vibrantLabel4.font = UIFont.systemFontOfSize(72.0)
        vibrantLabel4.sizeToFit()
        vibrantLabel4.center = vC.view.center
        
        var vibrantLabel5 = UILabel()
        vibrantLabel5.text = "Vai!"
        vibrantLabel5.font = UIFont.systemFontOfSize(72.0)
        vibrantLabel5.sizeToFit()
        vibrantLabel5.center = vC.view.center
        
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        vC.view.addSubview(blurEffectView)
        
        let delayTime5 = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime5, dispatch_get_main_queue()) {
            vibrancyEffectView.contentView.addSubview(vibrantLabel1)
            
            let delayTime4 = dispatch_time(DISPATCH_TIME_NOW, Int64(2.5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime4, dispatch_get_main_queue()) {
                vibrantLabel1.removeFromSuperview()
                vibrancyEffectView.contentView.addSubview(vibrantLabel2)
                let delayTime3 = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime3, dispatch_get_main_queue()) {
                    vibrantLabel2.removeFromSuperview()
                    vibrancyEffectView.contentView.addSubview(vibrantLabel3)
                    let delayTime2 = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime2, dispatch_get_main_queue()) {
                        vibrantLabel3.removeFromSuperview()
                        vibrancyEffectView.contentView.addSubview(vibrantLabel4)
                        let delayTime1 = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                        dispatch_after(delayTime1, dispatch_get_main_queue()) {
                            vibrantLabel4.removeFromSuperview()
                            vibrancyEffectView.contentView.addSubview(vibrantLabel5)
                            let delayTime0 = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                            dispatch_after(delayTime0, dispatch_get_main_queue()) {
                                vibrantLabel5.removeFromSuperview()
                                blurEffectView.removeFromSuperview()
                            }
                        }
                    }
                }
            }
        }
        var op: String!
        arrayCalculations.removeAll(keepCapacity: true)
        
        for i in 0...10 {
            var operation = random(0, 3)
            switch operation {
            case 0: // operação +
                op = "+"
            case 1: // operação -
                op = "-"
            case 2: // operação *
                op = "*"
            default: // operação /
                op = "/"
            }
            
            var doCalculation = Contas(operacao: op)
            arrayCalculations.append(doCalculation)
        }
    }
    
    func addContasGamer1() {
        calculation1.position = CGPoint(x: size.width/2, y: size.height/2+120)
        calculation1.fontColor = UIColor.blackColor()
        calculation1.zRotation = CGFloat(M_1_PI*9.85)
        calculation1.fontSize = 120
        calculation1.name = "conta1"
        calculation1.text = "\(arrayCalculations[scoreGamer1].conta)"
        addAlternativasGame1()
    }
    
    func addContasGamer2(){
        calculation2.position = CGPoint(x: size.width/2, y: size.height/2-120)
        calculation2.fontColor = UIColor.blackColor()
        calculation2.fontSize = 120
        calculation2.name = "conta2"
        calculation2.text = "\(arrayCalculations[scoreGamer2].conta)"
        addAlternativasGame2()
    }
    
    func addAlternativasGame1(){
        randomPosition = random(0, 3)
        alternative11.name = "errado1"
        alternative12.name = "errado2"
        alternative13.name = "errado3"
        alternative14.name = "errado4"
        
        for var i = 1; i < 5; i++ {
            self.enumerateChildNodesWithName("certo\(i)") {
                node, stop in
                node.name = "errado\(i)"
            }
        }
        
        // inserir valores nas labels
        switch randomPosition {
        case 0: //nuvem1
            alternative11.text = "\(arrayCalculations[scoreGamer1].resposta)"
            alternative12.text = "\(arrayCalculations[scoreGamer1].alternativa1)"
            alternative13.text = "\(arrayCalculations[scoreGamer1].alternativa2)"
            alternative14.text = "\(arrayCalculations[scoreGamer1].alternativa2)"
            
            self.enumerateChildNodesWithName("errado1") {
                node, stop in
                node.name = "certo1"
            }
            
        case 1: //nuvem2
            alternative11.text = "\(arrayCalculations[scoreGamer1].alternativa1)"
            alternative12.text = "\(arrayCalculations[scoreGamer1].resposta)"
            alternative13.text = "\(arrayCalculations[scoreGamer1].alternativa2)"
            alternative14.text = "\(arrayCalculations[scoreGamer1].alternativa3)"
            
            self.enumerateChildNodesWithName("errado2") {
                node, stop in
                node.name = "certo2"
            }
        case 2: // nuvem3
            alternative11.text = "\(arrayCalculations[scoreGamer1].alternativa1)"
            alternative12.text = "\(arrayCalculations[scoreGamer1].alternativa2)"
            alternative13.text = "\(arrayCalculations[scoreGamer1].resposta)"
            alternative14.text = "\(arrayCalculations[scoreGamer1].alternativa3)"
            
            self.enumerateChildNodesWithName("errado3") {
                node, stop in
                node.name = "certo3"
            }
        default:
            alternative11.text = "\(arrayCalculations[scoreGamer1].alternativa1)"
            alternative12.text = "\(arrayCalculations[scoreGamer1].alternativa2)"
            alternative13.text = "\(arrayCalculations[scoreGamer1].alternativa3)"
            alternative14.text = "\(arrayCalculations[scoreGamer1].resposta)"
            
            self.enumerateChildNodesWithName("errado4") {
                node, stop in
                node.name = "certo4"
            }
        }
    }
    
    func addAlternativasGame2(){
        randomPosition = random(0, 3)
        
        alternative21.name = "errado5"
        alternative22.name = "errado6"
        alternative23.name = "errado7"
        alternative24.name = "errado8"
        
        for var i = 5; i < 9; i++ {
            self.enumerateChildNodesWithName("certo\(i)") {
                node, stop in
                node.name = "errado\(i)"
            }
        }
        
        
        // inserir valores nas labels
        switch randomPosition {
        case 0: //nuvem1
            alternative21.text = "\(arrayCalculations[scoreGamer2].resposta)"
            alternative22.text = "\(arrayCalculations[scoreGamer2].alternativa1)"
            alternative23.text = "\(arrayCalculations[scoreGamer2].alternativa2)"
            alternative24.text = "\(arrayCalculations[scoreGamer2].alternativa2)"
            
            self.enumerateChildNodesWithName("errado5") {
                node, stop in
                node.name = "certo5"
            }
        case 1: //nuvem2
            alternative21.text = "\(arrayCalculations[scoreGamer2].alternativa1)"
            alternative22.text = "\(arrayCalculations[scoreGamer2].resposta)"
            alternative23.text = "\(arrayCalculations[scoreGamer2].alternativa2)"
            alternative24.text = "\(arrayCalculations[scoreGamer2].alternativa3)"
            
            self.enumerateChildNodesWithName("errado6") {
                node, stop in
                node.name = "certo6"
            }
        case 2: // nuvem3
            alternative21.text = "\(arrayCalculations[scoreGamer2].alternativa1)"
            alternative22.text = "\(arrayCalculations[scoreGamer2].alternativa2)"
            alternative23.text = "\(arrayCalculations[scoreGamer2].resposta)"
            alternative24.text = "\(arrayCalculations[scoreGamer2].alternativa3)"
            
            self.enumerateChildNodesWithName("errado7") {
                node, stop in
                node.name = "certo7"
            }
        default:
            alternative21.text = "\(arrayCalculations[scoreGamer2].alternativa1)"
            alternative22.text = "\(arrayCalculations[scoreGamer2].alternativa2)"
            alternative23.text = "\(arrayCalculations[scoreGamer2].alternativa3)"
            alternative24.text = "\(arrayCalculations[scoreGamer2].resposta)"
            
            self.enumerateChildNodesWithName("errado8") {
                node, stop in
                node.name = "certo8"
            }
        }
    }
    
    func posicaoAlternativas(){
        ////////////// cabeça pra baixo
        alternative11.position = CGPoint(x: size.width/2+200, y: size.height/2+400)
        alternative11.fontColor = UIColor.blackColor()
        alternative11.zRotation = CGFloat(M_1_PI*9.85)
        alternative11.fontSize = 50
        addChild(alternative11)
        
        alternative12.position = CGPoint(x: size.width/2-200, y: size.height/2+400)
        alternative12.fontColor = UIColor.blackColor()
        alternative12.zRotation = CGFloat(M_1_PI*9.85)
        alternative12.fontSize = 50
        addChild(alternative12)
        
        alternative14.position = CGPoint(x: size.width/2+200, y: size.height/2+250)
        alternative14.fontColor = UIColor.blackColor()
        alternative14.zRotation = CGFloat(M_1_PI*9.85)
        alternative14.fontSize = 50
        addChild(alternative14)
        
        alternative13.position = CGPoint(x: size.width/2-200, y: size.height/2+250)
        alternative13.fontColor = UIColor.blackColor()
        alternative13.zRotation = CGFloat(M_1_PI*9.85)
        alternative13.fontSize = 50
        addChild(alternative13)
        
        /////////////////////////////certo
        alternative21.position = CGPoint(x: size.width/2+200, y: size.height/2-400)
        alternative21.fontColor = UIColor.blackColor()
        alternative21.fontSize = 50
        addChild(alternative21)
        
        alternative22.position = CGPoint(x: size.width/2-200, y: size.height/2-400)
        alternative22.fontColor = UIColor.blackColor()
        alternative22.fontSize = 50
        addChild(alternative22)
        
        alternative24.position = CGPoint(x: size.width/2+200, y: size.height/2-250)
        alternative24.fontColor = UIColor.blackColor()
        alternative24.fontSize = 50
        addChild(alternative24)
        
        alternative23.position = CGPoint(x: size.width/2-200, y: size.height/2-250)
        alternative23.fontColor = UIColor.blackColor()
        alternative23.fontSize = 50
        addChild(alternative23)
        
        
        for var i = 0; i < 8; ++i {
            let block = SKSpriteNode(imageNamed: "bloco")
            
            if i == 0 {
                block.position = CGPoint(x: alternative11.position.x, y: alternative11.position.y-20)
            }
            if i == 1 {
                block.position = CGPoint(x: alternative12.position.x, y: alternative12.position.y-20)
            }
            if i == 2 {
                block.position = CGPoint(x: alternative13.position.x, y: alternative13.position.y-20)
            }
            if i == 3 {
                block.position = CGPoint(x: alternative14.position.x, y: alternative14.position.y-20)
            }
            if i == 4 {
                block.position = CGPoint(x: alternative21.position.x, y: alternative21.position.y+20)
            }
            if i == 5 {
                block.position = CGPoint(x: alternative22.position.x, y: alternative22.position.y+20)
            }
            if i == 6 {
                block.position = CGPoint(x: alternative23.position.x, y: alternative23.position.y+20)
            }
            if i == 7 {
                block.position = CGPoint(x: alternative24.position.x, y: alternative24.position.y+20)
            }
            block.physicsBody = SKPhysicsBody(rectangleOfSize: block.size)
            block.physicsBody?.dynamic = false
            block.name = "errado\(i+1)"
            block.size = CGSize(width: 300, height: 80)
            block.zPosition = -100
            addChild(block)
        }
    }
    
    // pausa o jogo
    func pause() {
        self.view?.paused = true
    }
}
