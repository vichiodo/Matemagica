//
//  SingleGameScene.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 22/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import AVFoundation
import SpriteKit

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    if url == nil {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil {
        println("Coult not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let SuperDente   : UInt32 = 0b10       // 2
    static let Dinheiro     : UInt32 = 0b11    //3
    static let DentePodre   : UInt32 = 0b110   //4
    static let Moeda        : UInt32 = 0b1      // 1
}

func random(lo: Int, hi : Int) -> Int {
    return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
}


class SingleGameScene: SKScene {
    
    //respostas
    var num1: Int = 0
    var num2: Int = 0
    var num3: Int = 0
    
    //declaração dos SpriteKit
    var nuvem1: SKSpriteNode!
    var nuvem2: SKSpriteNode!
    var nuvem3: SKSpriteNode!
    
    //declaração das labels resposta, pergunta e nível
    var labelResposta1: SKLabelNode!
    var labelResposta2: SKLabelNode!
    var labelResposta3: SKLabelNode!
    var labelPergunta: SKLabelNode!
    var labelNivel: SKLabelNode!
    
    //declaração do background
    var background: SKSpriteNode!
    
    //declaração de outros nodes necessario
    var represa: SKSpriteNode!
    var nuvemTocada: SKNode!
    var solSaindo: SKSpriteNode!
    var bloco: SKSpriteNode!
    
    //declaração de outras variáveis necessárias
    var posicao: Int = 0
    var numeros: Array<Int> = [1,2,3,4,5,6,7,8,9,10]
    var nivel: Int = 1
    
    override func didMoveToView(view: SKView) {
        
        //chama método para montar a scene
        montarScene()
        
        //chama o método para criar uma nova scene
        novoJogo()
        
        var notification:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "pause", name: "pauseView", object: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        //desabilita as labels
        nuvem1.userInteractionEnabled = true
        nuvem2.userInteractionEnabled = true
        nuvem3.userInteractionEnabled = true
        labelResposta1.userInteractionEnabled = true
        labelResposta2.userInteractionEnabled = true
        labelResposta3.userInteractionEnabled = true
        
        //pegar primeiro toque na tela
        let touch = touches.first as! UITouch
        let toucheLocation = touch.locationInNode(self)
        
        //descobre qual opção foi tocado
        nuvemTocada = self.nodeAtPoint(toucheLocation)
        
        //cria e posiciona label que aparece o texto (feedback ao usuário)
        var labelWin = SKLabelNode(fontNamed: "Macker Felt Wide")
        labelWin.position = CGPoint(x: 400, y: 300)
        labelWin.fontSize = 120
        labelWin.fontColor = SKColor(red: 238/255, green: 130/25, blue: 238/255, alpha: 1)
        
        //tirar os textos da página
        labelPergunta.text = " "
        bloco.hidden = true
        
        //adicionar na label o texto que será mostrado
        if nuvemTocada.name == "certa" {
            fazerChover()
            labelWin.text = "PARABÉNS!!"
            nivel++
        }else {
            sairSol()
            labelWin.text = "Você errou!"
        }
        
        //animação do sol aparecendo
        let aparecer = SKAction.fadeInWithDuration(0.5)
        let esperar = SKAction.waitForDuration(1.5)
        let desaparecer = SKAction.fadeOutWithDuration(1.5)
        
        //ação da label
        let sequencia = SKAction.sequence([aparecer, esperar, desaparecer])
        
        //adicionar a label na tela
        labelWin.alpha = 0
        addChild(labelWin)
        
        labelWin.runAction(sequencia, completion: { () -> Void in
            //chama novo nível
            self.novoJogo()
        })
    }
    
    //obtem as operações de acordo com a String passada e retorna o resultado da operação
    func obterOperacoes(operador: String) -> Int {
        var n1: Int = 0
        var n2: Int = 0
        
        //randons de acordo com os níveis
        if (nivel >= 1 && nivel <= 2) {
            n1 = random(0, 10)
            n2 = random(0, 10)
        }else if(nivel > 2 && nivel <= 5) {
            n1 = random(0, 20)
            n2 = random(0, 20)
        }else if(nivel > 5 && nivel <= 10) {
            n1 = random(0, 30)
            n2 = random(0, 30)
        }else if(nivel > 10 && nivel <= 25) {
            n1 = random(0, 50)
            n2 = random(0, 50)
        }else {
            n1 = random(0, 100)
            n2 = random(0, 100)
        }
        
        var operacao: String = ""
        
        //imprime na tela as operações
        if(operador == "+"){
            operacao = " \(n1) + \(n2)"
            
        }else if operador == "-"{
            if n1 > n2{
                operacao = " \(n1) - \(n2)"
            }else {
                operacao = " \(n2) - \(n1)"
            }
            
        }else if operador == "*" {
            n1 = random(1, 20)
            n2 = random(1, 20)
            operacao = " \(n1) × \(n2)"
            
        }else if operador == "/" {
            
            var array = random(0, 9)
            n2 = numeros[array]
            
            do{
                n1 = random(n2, 20)
            }while n1 % n2 != 0
            
            operacao = "\(n1) ÷ \(n2)"
        }
        
        self.labelPergunta.text = operacao
        return resolveOperacao(n1, n2: n2, op: operador)
    }
    
    //resolve as operações
    func resolveOperacao(n1: Int, n2: Int, op: String) -> Int{
        var resultado: Int = 0
        if op == "+" {
            resultado = n1 + n2
        }else if op == "-" {
            if n1 > n2 {
                resultado = n1 - n2
            }else{
                resultado = n2 - n1
            }
        }else if op == "*" {
            resultado = n1 * n2
        }else if op == "/" {
            resultado = n1 / n2
        }
        return resultado
    }
    
    //monta a scene
    func montarScene() {
        
        //instanciação dos SKSpriteNode
        nuvem1 = SKSpriteNode(imageNamed: "nuvem")
        nuvem2 = SKSpriteNode(imageNamed: "nuvem")
        nuvem3 = SKSpriteNode(imageNamed: "nuvem")
        
        //faz o node ficar no primeiro plano
        nuvem1.zPosition = 1
        nuvem2.zPosition = 1
        nuvem3.zPosition = 1
        
        //instanciação das labels resposta e pergunta
        labelResposta1 = SKLabelNode(fontNamed:"Macker Felt Wide")
        labelResposta2 = SKLabelNode(fontNamed:"Macker Felt Wide")
        labelResposta3 = SKLabelNode(fontNamed:"Macker Felt Wide")
        labelPergunta = SKLabelNode(fontNamed:"Macker Felt Wide")
        
        //faz a label ficar no primeiro plano
        labelResposta1.zPosition = 1
        labelResposta2.zPosition = 1
        labelResposta3.zPosition = 1
        labelPergunta.zPosition = 1
        
        //instanciação e posicionamento do background
        background = SKSpriteNode(imageNamed: "backgroundSingleGame")
        background.name = "background"
        background.size = scene!.size
        background.position = CGPointMake(scene!.size.width/2, scene!.size.height/2)
        scene!.addChild(background)
        
        //musica do app
        playBackgroundMusic("")
        
        //posiciona os sprite na scene
        nuvem1.position = CGPoint(x: size.width * 0.75, y: size.width * 1.1)
        nuvem2.position = CGPoint(x: size.width * 0.5, y: size.width * 0.8)
        nuvem3.position = CGPoint(x: size.width * 0.25, y: size.width * 1.1)
        
        //adiciona os sprites na scene
        addChild(nuvem1)
        addChild(nuvem2)
        addChild(nuvem3)
        
        //posiciona as labels
        labelResposta1.position = nuvem1.position
        labelResposta1.fontColor = SKColor.blackColor()
        labelResposta1.fontSize = 80
        
        labelResposta2.position = nuvem2.position
        labelResposta2.fontColor = SKColor.blackColor()
        labelResposta2.fontSize = 80
        
        labelResposta3.position = nuvem3.position
        labelResposta3.fontColor = SKColor.blackColor()
        labelResposta3.fontSize = 80
        
        labelPergunta.position = CGPoint(x: nuvem2.size.width * 1.2, y: nuvem3.size.width * 1)
        labelPergunta.fontColor = SKColor.blackColor()
        labelPergunta.fontSize = 80
        
        //adiciona as labels na scene
        addChild(labelResposta1)
        addChild(labelResposta2)
        addChild(labelResposta3)
        addChild(labelPergunta)
        
        //instanciação e posicionamento da sprite represa
        represa = SKSpriteNode(imageNamed: "represa")
        represa.position = CGPointMake(384, 320)
        represa.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        addChild(represa)
        
        //instanciação e posicionamento do retangulo da label pergunta
        bloco = SKSpriteNode(imageNamed: "bloco")
        bloco.size = CGSize(width: 300, height: 100)
        bloco.position = CGPoint(x: nuvem2.size.width * 1.2, y: nuvem3.size.width * 1.09)
        bloco.zPosition = 0
        addChild(bloco)
        
    }
    
    //metodo que cria um novo jogo
    func novoJogo() {
        
        bloco.hidden = false
        
        //caso exista solSaindo
        if solSaindo != nil {
            if solSaindo.name == "saiu1" {
                nuvem1.position = solSaindo.position
                solSaindo.removeFromParent()
                solSaindo = nil
                nuvem1.zPosition = 0
                addChild(nuvem1)
            }else if solSaindo.name == "saiu2" {
                nuvem2.position = solSaindo.position
                solSaindo.removeFromParent()
                solSaindo = nil
                nuvem2.zPosition = 0
                addChild(nuvem2)
            }else if solSaindo.name == "saiu3" {
                nuvem3.position = solSaindo.position
                solSaindo.removeFromParent()
                solSaindo = nil
                nuvem3.zPosition = 0
                addChild(nuvem3)
            }
        }
        // instanciação e posicionamento da label nivel
        labelNivel = SKLabelNode(fontNamed: "Marker Felt Wide")
        labelNivel.position = CGPoint(x: 400, y: 390)
        labelNivel.fontSize = 140
        labelNivel.fontColor = SKColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1)
        labelNivel.text = "NIVEL \(nivel)"
        
        //animação para mudança de nível
        let aparecer = SKAction.fadeInWithDuration(0.5)
        let esperar = SKAction.waitForDuration(1.5)
        let desaparecer = SKAction.fadeOutWithDuration(0.5)
        let sequencia = SKAction.sequence([aparecer, esperar, desaparecer])
        
        //adiciona a label nivel na tela
        labelNivel.alpha = 0
        addChild(labelNivel)
        
        //inicia a animação
        labelNivel.runAction(sequencia)
        
        //random para escolha da nuvem
        posicao = random(0, 2)
        var num1 = 0
        var num2 = 0
        var num3 = 0
        var resposta: Int = 0
        
        labelResposta1.text = "\(num1)"
        labelResposta2.text = "\(num2)"
        labelResposta3.text = "\(num3)"
        
        //nomeia os nodes nuvem e labelResposta para "errado"
        nuvem1.name = "errado"
        nuvem2.name = "errado"
        nuvem3.name = "errado"
        labelResposta1.name = "errado"
        labelResposta2.name = "errado"
        labelResposta3.name = "errado"
        
        //verifica o nível e filtra as operações para cada bloco de níveis
        if (nivel >= 0 && nivel <= 10){ //niveis de 0 a 10 operações de + e -
            var operacao = random(0, 1)
            
            switch operacao {
            case 0: //operacao +
                resposta = obterOperacoes("+")
            default: //operacao -
                resposta = obterOperacoes("-")
            }
        }else if (nivel > 10 && nivel <= 20){ //níveis de 11 a 20 operações de +, - e *
            var operacao = random(0, 2)
            
            switch operacao {
            case 0: // operação +
                resposta = obterOperacoes("+")
            case 1: // operação -
                resposta = obterOperacoes("-")
            default: // operação *
                resposta = obterOperacoes("*")
            }
        }else if nivel > 20 { // niveis a partir do 21 operações de +, -, *, /
            var operacao = random(0, 3)
            
            switch operacao {
            case 0: // operação +
                resposta = obterOperacoes("+")
            case 1: // operação -
                resposta = obterOperacoes("-")
            case 2: // operação *
                resposta = obterOperacoes("*")
            default: // operação /
                resposta = obterOperacoes("/")
            }
        }
        
        // inserir valores nas labels
        switch posicao {
        case 0: //nuvem1
            num2 = random(resposta - 20, resposta - 1)
            if num2 < 0 {
                num2 = (num2) * (-1) + 2
            }
            num3 = random(resposta + 1, resposta + 20)
            
            if num2 == resposta || num2 == num3 {
                num2++
            }
            if num3 == resposta || num3 == num2 {
                num3++
            }
            
            labelResposta1.text = "\(resposta)"
            labelResposta2.text = "\(num2)"
            labelResposta3.text = "\(num3)"
            nuvem1.name = "certa"
            labelResposta1.name = "certa"
        case 1: //nuvem2
            num1 = random(resposta - 20, resposta)
            if num1 < 0 {
                num1 = (num1 + num1) * (-1) + 2
            }
            
            num3 = random(resposta, resposta + 20)
            
            if num1 == resposta || num1 == num3 {
                num1++
            }
            if num3 == resposta || num1 == num3{
                num3++
            }
            
            labelResposta1.text = "\(num1)"
            labelResposta2.text = "\(resposta)"
            labelResposta3.text = "\(num3)"
            nuvem2.name = "certa"
            labelResposta2.name = "certa"
        default: // nuvem3
            num1 = random(resposta - 20, resposta)
            if num1 < 0 {
                num1 = (num1 - num1) * (-1) + 2
            }
            
            num2 = random(resposta, resposta + 20)
            
            if num1 == resposta || num1 == num2{
                num1++
            }
            if num2 == resposta || num1 == num2 {
                num2++
            }
            
            labelResposta1.text = "\(num1)"
            labelResposta2.text = "\(num2)"
            labelResposta3.text = "\(resposta)"
            nuvem3.name = "certa"
            labelResposta3.name = "certa"
        }
        println("\(resposta) e \(num1) e \(num2) e \(posicao)")
        
        //habilita as labels
        nuvem1.userInteractionEnabled = false
        nuvem2.userInteractionEnabled = false
        nuvem3.userInteractionEnabled = false
        labelResposta1.userInteractionEnabled = false
        labelResposta2.userInteractionEnabled = false
        labelResposta3.userInteractionEnabled = false
    }
    
    //faz chover quando acerta a resposta
    func fazerChover() {
        let nuvemChovendo: SKSpriteNode!
        
        switch posicao {
        case 0:
            nuvemChovendo = nuvem1
        case 1:
            nuvemChovendo = nuvem2
        default:
            nuvemChovendo = nuvem3
        }
        
        //instanciação do node chuva
        let chuva: SKNode = SKNode()
        
        //conjunto de gotas forma uma chuva
        for var i = 0; i < random(10, 20); i++ {
            let gota: SKSpriteNode = SKSpriteNode(imageNamed: "gota")
            let posicaoX = random(Int(nuvemChovendo.position.x - nuvemChovendo.size.width / 3), Int(nuvemChovendo.position.x + nuvemChovendo.size.width / 3))
            let posicaoY = random(Int(nuvemChovendo.position.y - 80), Int((nuvemChovendo.position.y + nuvemChovendo.size.height / 2) - 20))
            gota.position = CGPointMake(CGFloat(posicaoX), CGFloat(posicaoY))
            gota.xScale = 0.75
            gota.yScale = 0.75
            chuva.addChild(gota)
        }
        
        //adiciona a chuva na scene
        addChild(chuva)
        
        //animação de fazer chover
        let chover: SKAction = SKAction.moveTo(CGPointMake(chuva.position.x, UIScreen.mainScreen().bounds.height * -1), duration: 2.0)
        chuva.runAction(chover, completion: { () -> Void in
            chuva.removeFromParent()
            //fazer a represa subir
            if self.represa.position.y != 500 {
                self.represa.position.y = self.represa.position.y + 10
            }else {
                self.represa.position.y = 320
            }
            
        })
        
    }
    
    //caso erre a operação
    func sairSol() {
        solSaindo = SKSpriteNode(imageNamed: "sol")
        
        switch posicao {
        case 0:
            solSaindo.position = nuvem1.position
            solSaindo.name = "saiu1"
            nuvem1.removeFromParent()
        case 1:
            solSaindo.position = nuvem2.position
            solSaindo.name = "saiu2"
            nuvem2.removeFromParent()
        default:
            solSaindo.position = nuvem3.position
            solSaindo.name = "saiu3"
            nuvem3.removeFromParent()
        }
        
        //animação para o sol aparecer
        let aparecer = SKAction.fadeInWithDuration(0.5)
        solSaindo.runAction(aparecer)
        solSaindo.alpha = 0
        addChild(solSaindo)
        
        //diminui a represa
        if represa.position.y != 320 {
            represa.position.y = 320
        }
        
        //zera o nível
        nivel = 1
    }
    
    // pausa o jogo
    func pause() {
        self.view?.paused = true
    }
}