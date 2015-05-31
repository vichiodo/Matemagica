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
    var resposta: Int = 0
    var posicao: Int = 0
    var conta1 = SKLabelNode()
    var conta2 = SKLabelNode()
    
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()
    
    //declaração das labels das alternativas
    var alternativa11 = SKLabelNode()
    var alternativa12 = SKLabelNode()
    var alternativa13 = SKLabelNode()
    var alternativa14 = SKLabelNode()
    var alternativa21 = SKLabelNode()
    var alternativa22 = SKLabelNode()
    var alternativa23 = SKLabelNode()
    var alternativa24 = SKLabelNode()
    
    //declaração da label da alternativa que será selecionada
    var alternativaTocada: SKNode!
    
    //declaraçao de váriaveis necessarias
    var index1: Int = -1
    var index2: Int = -1
    var scoreGamer1: Int = 0
    var scoreGamer2: Int = 0
    var vitoriasJogador1: Int = 0
    var vitoriasJogador2: Int = 0
    
    //declaração das labels dos nomes, vitórias, pontuações e resultados dos jogadores
    let lblVitoriasJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblVitoriasJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblResultadoJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    let lblResultadoJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
    let lblPontuacaoJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblPontuacaoJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblNomeJogador1 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    let lblNomeJogador2 = SKLabelNode(fontNamed: "ChalkboardSE-Light")
    
    let voltar = SKSpriteNode(imageNamed: "voltar")
    
    //animação
    let aparecer = SKAction.fadeInWithDuration(0.5)
    
    //array que armazenará as contas geradas a cada 10 partidas
    var contasArray: Array<Contas> = Array<Contas>()
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        // "botao" voltar
        voltar.position = CGPoint(x: 53.5, y: size.height - 65.6)
        voltar.size = CGSize(width: 75, height: 75)
        addChild(voltar)
        
        // notificationCenter para verificar quando voltar para a view anterior ele para o jogo
        var notification:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "pause", name: "pauseMulti", object: nil)
        
        CGPathMoveToPoint(ref, nil, 0, size.height/2)
        CGPathAddLineToPoint(ref, nil, size.width, size.height/2)
        
        //posicionamento da linha que dividirá um jogador do outro
        line.path = ref
        line.lineWidth = 4
        line.fillColor = UIColor.blackColor()
        line.strokeColor = UIColor.blackColor()
        
        self.addChild(line)
        
        //chama o método que monta a scene
        posicaoAlternativas()
        //chama o método que cria as operações
        addOperacao()
        //chama os métodos que carrega as alternativas na tela
        addContasGamer1()
        addContasGamer2()
        
        addChild(conta1)
        addChild(conta2)
        
        //busca no userDefault o nivel de cada jogador
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
        
        //pega o primeiro toque na tela
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        //descobre qual opção foi tocada
        alternativaTocada = self.nodeAtPoint(touchLocation)
        
        if voltar.containsPoint(touchLocation){
            vC.voltar()
        }
        
        //caso os dois jogadores ainda não atingiram 10 vitórias
        if scoreGamer1 < 10 && scoreGamer2 < 10 {
            //analisa se o node tocado pertence ao jogador 1
            if alternativaTocada.name == "certo1" || alternativaTocada.name == "certo2" || alternativaTocada.name == "certo3" || alternativaTocada.name == "certo4" {
                //aumenta 1 vitoria ao jogador1
                scoreGamer1++
                lblPontuacaoJogador1.text = "\(scoreGamer1)"
                
               // quando o jogador 1 chega a 10 vitorias apresenta aos jogadores quem foi o vencedor
                if scoreGamer1 == 10 {
                    lblResultadoJogador1.hidden = false
                    lblResultadoJogador2.hidden = false
                    lblResultadoJogador1.text = "VENCEU"
                    lblResultadoJogador1.fontColor = SKColor.blueColor()
                    lblResultadoJogador2.text = "PERDEU"
                    lblResultadoJogador2.fontColor = SKColor.redColor()
                    
                    //animação
                    let sequencia = SKAction.sequence([aparecer])
                    lblResultadoJogador1.runAction(sequencia)
                    lblResultadoJogador2.runAction(sequencia)
                    
                    //atualiza no CoreDate
                    vitoriasJogador1++
                    lblVitoriasJogador1.text = "\(vitoriasJogador1)"
                    players[index1].scorePlayer = String(vitoriasJogador1)
                    
                    //alerta personalizado perguntando aos jogadores se desejam continuar a jogar ou não
                    var alertview = JSSAlertView().show(vC, title: "Quer jogar de novo?", buttonText: "Sim!", cancelButtonText: "Não", color: UIColorFromHex(0x3498db, alpha: 1))
                    alertview.addAction(alertAction)
                    alertview.setTextTheme(.Light)
                }
                else {//caso ainda não tenham atingido 10 vitórias
                    //cria novas contas para o jogador 1
                    addContasGamer1()
                    println("Gamer1: \(scoreGamer1)")
                }
            }//analisa se o node tocado pertence ao jogador 1, porem esse node não é o que contem a altenativa correta
            else if alternativaTocada.name == "errado1" || alternativaTocada.name == "errado2" || alternativaTocada.name == "errado3" || alternativaTocada.name == "errado4" {
                println("jogador 1 errou")
            } //analisa se o node tocado pertence ao jogador 2
            else if alternativaTocada.name == "certo5" || alternativaTocada.name == "certo6" || alternativaTocada.name == "certo7" || alternativaTocada.name == "certo8" {
                //aumenta 1 ao score do jogador 2
                scoreGamer2++
                lblPontuacaoJogador2.text = "\(scoreGamer2)"
                
                //quando o jogador 2 chega a 10 vitorias apresenta aos jogadores quem foi o vencedor
                if scoreGamer2 == 10 {
                    lblResultadoJogador1.hidden = false
                    lblResultadoJogador2.hidden = false
                    lblResultadoJogador1.text = "PERDEU"
                    lblResultadoJogador1.fontColor = SKColor.redColor()
                    lblResultadoJogador2.text = "VENCEU"
                    lblResultadoJogador2.fontColor = SKColor.blueColor()
                    
                    //animação
                    let sequencia = SKAction.sequence([aparecer])
                    lblResultadoJogador1.runAction(sequencia)
                    lblResultadoJogador2.runAction(sequencia)
                    
                    //atualiza no CoreData
                    vitoriasJogador2++
                    lblVitoriasJogador2.text = "\(vitoriasJogador2)"
                    players[index2].scorePlayer = String(vitoriasJogador2)
                    
                    //alerta personalizado perguntando aos jogadores se desejam continuar a jogar ou não
                    var alertview = JSSAlertView().show(vC, title: "Quer jogar de novo?", buttonText: "Sim!", cancelButtonText: "Não", color: UIColorFromHex(0x3498db, alpha: 1))
                    alertview.addAction(alertAction)
                    alertview.setTextTheme(.Light)
                }
                else {//caso ainda não tenham atingido 10 vitórias
                    //cria novas contas para o jogador 2
                    addContasGamer2()
                    println("Gamer2: \(scoreGamer2)")
                }
            }//analisa se o node tocado pertence ao jogador 1, porem esse node não é o que contem a altenativa correta
            else if alternativaTocada.name == "errado5" || alternativaTocada.name == "errado6" || alternativaTocada.name == "errado7" || alternativaTocada.name == "errado8" {
                println("jogador 2 errou")
                
                for var i = 5; i < 9; i++ {
                    self.enumerateChildNodesWithName("errado\(i)") {
                        node, stop in
                        node.userInteractionEnabled = false
                    }
                }


                animateWrong(conta2)
                
                
            }
            
        }
        PlayerManager.sharedInstance.salvarPlayer()
    }
    
    //animação caso clique na alternativa errada
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
    }
    
    
    func alertAction() {
        lblResultadoJogador1.hidden = true
        lblResultadoJogador2.hidden = true
        scoreGamer1 = 0
        scoreGamer2 = 0
        lblPontuacaoJogador1.text = "\(self.scoreGamer1)"
        lblPontuacaoJogador2.text = "\(self.scoreGamer2)"
        
        addOperacao()
        addContasGamer1()
        addContasGamer2()
    }
    
    //metodo para escolha da operação
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
            
            //instanciação de um objeto do tipo Contas passando como parametro a operação
            var fazConta = Contas(operacao: op)
            //armazena no array o objeto Contas
            contasArray.append(fazConta)
        }
    }
    
    //método que posiciona a operação do jogador1
    func addContasGamer1() {
        conta1.position = CGPoint(x: size.width/2, y: size.height/2+120)
        conta1.fontColor = UIColor.blackColor()
        conta1.zRotation = CGFloat(M_1_PI*9.85)
        conta1.fontSize = 120
        conta1.name = "conta1"
        conta1.text = "\(contasArray[scoreGamer1].conta)"
        addAlternativasGame1()
    }
    
    //método que posiciona a operação do jogador2
    func addContasGamer2(){
        conta2.position = CGPoint(x: size.width/2, y: size.height/2-120)
        conta2.fontColor = UIColor.blackColor()
        conta2.fontSize = 120
        conta2.name = "conta2"
        conta2.text = "\(contasArray[scoreGamer2].conta)"
        addAlternativasGame2()
    }
    
    //método que posiciona as alternativas do jogador1
    func addAlternativasGame1(){
        posicao = random(0, 3)
        alternativa11.name = "errado1"
        alternativa12.name = "errado2"
        alternativa13.name = "errado3"
        alternativa14.name = "errado4"
        
        for var i = 1; i < 5; i++ {
            self.enumerateChildNodesWithName("certo\(i)") {
                node, stop in
                node.name = "errado\(i)"
            }
        }
        
        // inserir valores nas labels
        switch posicao {
        case 0:
            alternativa11.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa2)"
            
            self.enumerateChildNodesWithName("errado1") {
                node, stop in
                node.name = "certo1"
            }
            
        case 1:
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa3)"
            
            self.enumerateChildNodesWithName("errado2") {
                node, stop in
                node.name = "certo2"
            }
        case 2:
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa13.text = "\(contasArray[scoreGamer1].resposta)"
            alternativa14.text = "\(contasArray[scoreGamer1].alternativa3)"
            
            self.enumerateChildNodesWithName("errado3") {
                node, stop in
                node.name = "certo3"
            }
        default:
            alternativa11.text = "\(contasArray[scoreGamer1].alternativa1)"
            alternativa12.text = "\(contasArray[scoreGamer1].alternativa2)"
            alternativa13.text = "\(contasArray[scoreGamer1].alternativa3)"
            alternativa14.text = "\(contasArray[scoreGamer1].resposta)"
            
            self.enumerateChildNodesWithName("errado4") {
                node, stop in
                node.name = "certo4"
            }
        }
    }
    
    //método que posiciona as alternativas do jogador2
    func addAlternativasGame2(){
        posicao = random(0, 3)
        
        alternativa21.name = "errado5"
        alternativa22.name = "errado6"
        alternativa23.name = "errado7"
        alternativa24.name = "errado8"
        
        for var i = 5; i < 9; i++ {
            self.enumerateChildNodesWithName("certo\(i)") {
                node, stop in
                node.name = "errado\(i)"
            }
        }
        
        
        // inserir valores nas labels
        switch posicao {
        case 0:
            alternativa21.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa2)"
            
            self.enumerateChildNodesWithName("errado5") {
                node, stop in
                node.name = "certo5"
            }
        case 1:
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa3)"
            
            self.enumerateChildNodesWithName("errado6") {
                node, stop in
                node.name = "certo6"
            }
        case 2:
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa23.text = "\(contasArray[scoreGamer2].resposta)"
            alternativa24.text = "\(contasArray[scoreGamer2].alternativa3)"
            
            self.enumerateChildNodesWithName("errado7") {
                node, stop in
                node.name = "certo7"
            }
        default:
            alternativa21.text = "\(contasArray[scoreGamer2].alternativa1)"
            alternativa22.text = "\(contasArray[scoreGamer2].alternativa2)"
            alternativa23.text = "\(contasArray[scoreGamer2].alternativa3)"
            alternativa24.text = "\(contasArray[scoreGamer2].resposta)"
            
            self.enumerateChildNodesWithName("errado8") {
                node, stop in
                node.name = "certo8"
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
        
        //declaração e instanciação dos blocos das alternativas
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
            bloco.physicsBody = SKPhysicsBody(rectangleOfSize: bloco.size)
            bloco.physicsBody?.dynamic = false
            bloco.name = "errado\(i+1)"
            bloco.size = CGSize(width: 300, height: 80)
            bloco.zPosition = -100
            addChild(bloco)
        }
    }
    
    // pausa o jogo
    func pause() {
        self.view?.paused = true
    }
}
