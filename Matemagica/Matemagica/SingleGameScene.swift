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

func random(lo: Int, hi : Int) -> Int {
    return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
}


class SingleGameScene: SKScene {
    var vC: SingleGameViewController!
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()

    //respostas
    var number1: Int = 0
    var number2: Int = 0
    var number3: Int = 0
    
    //declaração dos SpriteKit
    var cloud1: SKSpriteNode!
    var cloud2: SKSpriteNode!
    var cloud3: SKSpriteNode!
    
    //declaração das labels resposta, pergunta e nível
    var labelAnswer1: SKLabelNode!
    var labelAnswer2: SKLabelNode!
    var labelAnswer3: SKLabelNode!
    var labelQuestion: SKLabelNode!
    var labelNivel: SKLabelNode!
    
    //declaração do background
    var background: SKSpriteNode!
    
    //declaração de outros nodes necessario
    var river: SKSpriteNode!
    var cloudPlayed: SKNode!
    var sunPlayed: SKSpriteNode!
    var block: SKSpriteNode!
    
    //declaração de outras variáveis necessárias
    var positionn: Int = 0
    var numbers: Array<Int> = [1,2,3,4,5,6,7,8,9,10]
    var level: Int = 1
    var index: Int = -1
    
    let back = SKSpriteNode(imageNamed: "voltar")
    
    override func didMoveToView(view: SKView) {
        index = userDef.objectForKey("index") as! Int
        level = players[index].nivelPlayer.toInt()!
        
        // "botao" back
        back.position = CGPoint(x: 53.5, y: size.height - 65.6)
        back.size = CGSize(width: 75, height: 75)
        back.zPosition = 100
        addChild(back)

        //chama método para montar a scene
        mountScene()
        
        //chama o método para criar uma nova scene
        newGame()
        
        //notificação para retornar a pagina inicial de Jogos
        var notification:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "pause", name: "pauseSingle", object: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //pegar primeiro toque na tela
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)

        if back.containsPoint(touchLocation){
            PlayerManager.sharedInstance.salvarPlayer()
            vC.voltar()
        }
        
        //descobre qual opção foi tocado
        cloudPlayed = self.nodeAtPoint(touchLocation)

        //desabilita as labels
        cloud1.userInteractionEnabled = true
        cloud2.userInteractionEnabled = true
        cloud3.userInteractionEnabled = true
        labelAnswer1.userInteractionEnabled = true
        labelAnswer2.userInteractionEnabled = true
        labelAnswer3.userInteractionEnabled = true
        
        //cria e posiciona label que aparece o texto (feedback ao usuário)
        var labelWin = SKLabelNode(fontNamed: "Macker Felt Wide")
        labelWin.position = CGPoint(x: 400, y: 300)
        labelWin.fontSize = 120
        labelWin.fontColor = SKColor(red: 238/255, green: 130/25, blue: 238/255, alpha: 1)
        
        //tirar os textos da página
        labelQuestion.text = " "
        block.hidden = true
        
        //adicionar na label o texto que será mostrado
        if cloudPlayed.name == "certa" {
            rain()
            labelWin.text = "PARABÉNS!!"
            level++
            players[index].nivelPlayer = String(level)
        }else if cloudPlayed.name == "errado" {
            sun()
            labelWin.text = "Você errou!"
        }
        
        
        //animação do sol aparecendo
        let appear = SKAction.fadeInWithDuration(0.5)
        let wait = SKAction.waitForDuration(1.5)
        let desappear = SKAction.fadeOutWithDuration(1.5)
        
        //ação da label
        let sequence = SKAction.sequence([appear, wait, desappear])
        
        //adicionar a label na tela
        labelWin.alpha = 0
        addChild(labelWin)
        
        labelWin.runAction(sequence, completion: { () -> Void in
            //chama novo nível
            self.newGame()
        })
        PlayerManager.sharedInstance.salvarPlayer()
    }
    
    //obtem as operações de acordo com a String passada e retorna o resultado da operação
    func getOperations(operador: String) -> Int {
        var n1: Int = 0
        var n2: Int = 0
        
        //randons de acordo com os níveis
        if (level >= 1 && level <= 2) {
            n1 = random(0, 10)
            n2 = random(0, 10)
        }else if(level > 2 && level <= 5) {
            n1 = random(0, 20)
            n2 = random(0, 20)
        }else if(level > 5 && level <= 10) {
            n1 = random(0, 30)
            n2 = random(0, 30)
        }else if(level > 10 && level <= 25) {
            n1 = random(0, 50)
            n2 = random(0, 50)
        }else {
            n1 = random(0, 100)
            n2 = random(0, 100)
        }
        
        var operation: String = ""
        
        //imprime na tela as operações
        if(operador == "+"){
            operation = " \(n1) + \(n2)"
            
        }else if operador == "-"{
            if n1 > n2{
                operation = " \(n1) - \(n2)"
            }else {
                operation = " \(n2) - \(n1)"
            }
            
        }else if operador == "*" {
            n1 = random(1, 10)
            n2 = random(1, 10)
            operation = " \(n1) × \(n2)"
            
        }else if operador == "/" {
            
            var array = random(0, 9)
            n2 = numbers[array]
            
            do{
                n1 = random(n2, 20)
            }while n1 % n2 != 0
            
            operation = "\(n1) ÷ \(n2)"
        }
        
        self.labelQuestion.text = operation
        return solveOperation(n1, n2: n2, op: operador)
    }
    
    //resolve as operações
    func solveOperation(n1: Int, n2: Int, op: String) -> Int{
        var result: Int = 0
        if op == "+" {
            result = n1 + n2
        }else if op == "-" {
            if n1 > n2 {
                result = n1 - n2
            }else{
                result = n2 - n1
            }
        }else if op == "*" {
            result = n1 * n2
        }else if op == "/" {
            result = n1 / n2
        }
        return result
    }
    
    //monta a scene
    func mountScene() {
        //instanciação dos SKSpriteNode
        cloud1 = SKSpriteNode(imageNamed: "nuvem")
        cloud2 = SKSpriteNode(imageNamed: "nuvem")
        cloud3 = SKSpriteNode(imageNamed: "nuvem")
        
        //faz o node ficar no primeiro plano
        cloud1.zPosition = 1
        cloud2.zPosition = 1
        cloud3.zPosition = 1
        
        //instanciação das labels resposta e pergunta
        labelAnswer1 = SKLabelNode(fontNamed:"Macker Felt Wide")
        labelAnswer2 = SKLabelNode(fontNamed:"Macker Felt Wide")
        labelAnswer3 = SKLabelNode(fontNamed:"Macker Felt Wide")
        labelQuestion = SKLabelNode(fontNamed:"Macker Felt Wide")
        
        //faz a label ficar no primeiro plano
        labelAnswer1.zPosition = 1
        labelAnswer2.zPosition = 1
        labelAnswer3.zPosition = 1
        labelQuestion.zPosition = 1
        
        //instanciação e posicionamento do background
        background = SKSpriteNode(imageNamed: "backgroundSingleGame")
        background.name = "background"
        background.size = scene!.size
        background.position = CGPointMake(scene!.size.width/2, scene!.size.height/2)
        scene!.addChild(background)
        
        //musica do app
        playBackgroundMusic("")
        
        //posiciona os sprite na scene
        cloud1.position = CGPoint(x: size.width * 0.75, y: size.width * 1.1)
        cloud2.position = CGPoint(x: size.width * 0.5, y: size.width * 0.8)
        cloud3.position = CGPoint(x: size.width * 0.25, y: size.width * 1.1)
        
        //adiciona os sprites na scene
        addChild(cloud1)
        addChild(cloud2)
        addChild(cloud3)
        
        //posiciona as labels
        labelAnswer1.position = cloud1.position
        labelAnswer1.fontColor = SKColor.blackColor()
        labelAnswer1.fontSize = 80
        
        labelAnswer2.position = cloud2.position
        labelAnswer2.fontColor = SKColor.blackColor()
        labelAnswer2.fontSize = 80
        
        labelAnswer3.position = cloud3.position
        labelAnswer3.fontColor = SKColor.blackColor()
        labelAnswer3.fontSize = 80
        
        labelQuestion.position = CGPoint(x: cloud2.size.width * 1.2, y: cloud3.size.width * 1)
        labelQuestion.fontColor = SKColor.blackColor()
        labelQuestion.fontSize = 80
        
        //adiciona as labels na scene
        addChild(labelAnswer1)
        addChild(labelAnswer2)
        addChild(labelAnswer3)
        addChild(labelQuestion)
        
        //instanciação e posicionamento da sprite river
        river = SKSpriteNode(imageNamed: "represa")
        river.position = CGPointMake(384, 320)
        river.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        addChild(river)
        
        //instanciação e posicionamento do retangulo da label pergunta
        block = SKSpriteNode(imageNamed: "bloco")
        block.size = CGSize(width: 300, height: 100)
        block.position = CGPoint(x: cloud2.size.width * 1.2, y: cloud3.size.width * 1.09)
        block.zPosition = 0
        addChild(block)
    }
    
    //metodo que cria um novo jogo
    func newGame() {
        
        block.hidden = false
        
        //caso exista sunPlayed
        if sunPlayed != nil {
            if sunPlayed.name == "saiu1" {
                cloud1.position = sunPlayed.position
                sunPlayed.removeFromParent()
                sunPlayed = nil
                cloud1.zPosition = 0
                addChild(cloud1)
            }else if sunPlayed.name == "saiu2" {
                cloud2.position = sunPlayed.position
                sunPlayed.removeFromParent()
                sunPlayed = nil
                cloud2.zPosition = 0
                addChild(cloud2)
            }else if sunPlayed.name == "saiu3" {
                cloud3.position = sunPlayed.position
                sunPlayed.removeFromParent()
                sunPlayed = nil
                cloud3.zPosition = 0
                addChild(cloud3)
            }
        }
        
        // instanciação e posicionamento da label level
        labelNivel = SKLabelNode(fontNamed: "Marker Felt Wide")
        labelNivel.position = CGPoint(x: 400, y: 390)
        labelNivel.fontSize = 140
        labelNivel.fontColor = SKColor(red: 238/255, green: 130/255, blue: 238/255, alpha: 1)
        labelNivel.text = "NIVEL \(level)"
        
        //animação para mudança de nível
        let appear = SKAction.fadeInWithDuration(0.5)
        let wait = SKAction.waitForDuration(1.5)
        let desappear = SKAction.fadeOutWithDuration(0.5)
        let sequence = SKAction.sequence([appear, wait, desappear])
        
        //adiciona a label level na tela
        labelNivel.alpha = 0
        addChild(labelNivel)
        
        //inicia a animação
        labelNivel.runAction(sequence)
        
        //random para escolha da nuvem
        positionn = random(0, 2)
        var number1 = 0
        var number2 = 0
        var number3 = 0
        var resposta: Int = 0
        
        labelAnswer1.text = "\(number1)"
        labelAnswer2.text = "\(number2)"
        labelAnswer3.text = "\(number3)"
        
        //nomeia os nodes nuvem e labelResposta para "errado"
        cloud1.name = "errado"
        cloud2.name = "errado"
        cloud3.name = "errado"
        labelAnswer1.name = "errado"
        labelAnswer2.name = "errado"
        labelAnswer3.name = "errado"
        
        //verifica o nível e filtra as operações para cada block de níveis
        if (level >= 0 && level <= 10){ //niveis de 0 a 10 operações de + e -
            var operation = random(0, 1)
            
            switch operation {
            case 0: //operacao +
                resposta = getOperations("+")
            default: //operacao -
                resposta = getOperations("-")
            }
        }else if (level > 10 && level <= 20){ //níveis de 11 a 20 operações de +, - e *
            var operation = random(0, 2)
            
            switch operation {
            case 0: // operação +
                resposta = getOperations("+")
            case 1: // operação -
                resposta = getOperations("-")
            default: // operação *
                resposta = getOperations("*")
            }
        }else if level > 20 { // niveis a partir do 21 operações de +, -, *, /
            var operation = random(0, 3)
            
            switch operation {
            case 0: // operação +
                resposta = getOperations("+")
            case 1: // operação -
                resposta = getOperations("-")
            case 2: // operação *
                resposta = getOperations("*")
            default: // operação /
                resposta = getOperations("/")
            }
        }
        
        // inserir valores nas labels
        switch positionn {
        case 0: //cloud1
            number2 = random(resposta - 20, resposta - 1)
            if number2 < 0 {
                number2 = (number2) * (-1) + 2
            }
            number3 = random(resposta + 1, resposta + 20)
            
            if number2 == resposta || number2 == number3 {
                number2++
            }
            if number3 == resposta || number3 == number2 {
                number3++
            }
            
            labelAnswer1.text = "\(resposta)"
            labelAnswer2.text = "\(number2)"
            labelAnswer3.text = "\(number3)"
            cloud1.name = "certa"
            labelAnswer1.name = "certa"
        case 1: //cloud2
            number1 = random(resposta - 20, resposta)
            if number1 < 0 {
                number1 = (number1 + number1) * (-1) + 2
            }
            
            number3 = random(resposta, resposta + 20)
            
            if number1 == resposta || number1 == number3 {
                number1++
            }
            if number3 == resposta || number1 == number3{
                number3++
            }
            
            labelAnswer1.text = "\(number1)"
            labelAnswer2.text = "\(resposta)"
            labelAnswer3.text = "\(number3)"
            cloud2.name = "certa"
            labelAnswer2.name = "certa"
        default: // cloud3
            number1 = random(resposta - 20, resposta)
            if number1 < 0 {
                number1 = (number1 - number1) * (-1) + 2
            }
            
            number2 = random(resposta, resposta + 20)
            
            if number1 == resposta || number1 == number2{
                number1++
            }
            if number2 == resposta || number1 == number2 {
                number2++
            }
            
            labelAnswer1.text = "\(number1)"
            labelAnswer2.text = "\(number2)"
            labelAnswer3.text = "\(resposta)"
            cloud3.name = "certa"
            labelAnswer3.name = "certa"
        }
        println("\(resposta) e \(number1) e \(number2) e \(positionn)")
        
        //habilita as labels
        cloud1.userInteractionEnabled = false
        cloud2.userInteractionEnabled = false
        cloud3.userInteractionEnabled = false
        labelAnswer1.userInteractionEnabled = false
        labelAnswer2.userInteractionEnabled = false
        labelAnswer3.userInteractionEnabled = false
    }
    
    //faz chover quando acerta a resposta
    func rain() {
        let raining: SKSpriteNode!
        
        switch positionn {
        case 0:
            raining = cloud1
        case 1:
            raining = cloud2
        default:
            raining = cloud3
        }
        
        //instanciação do node chuva
        let rain: SKNode = SKNode()
        
        //conjunto de gotas forma uma chuva
        for var i = 0; i < random(10, 20); i++ {
            let drop: SKSpriteNode = SKSpriteNode(imageNamed: "gota")
            let posicaoX = random(Int(raining.position.x - raining.size.width / 3), Int(raining.position.x + raining.size.width / 3))
            let posicaoY = random(Int(raining.position.y - 80), Int((raining.position.y + raining.size.height / 2) - 20))
            drop.position = CGPointMake(CGFloat(posicaoX), CGFloat(posicaoY))
            drop.xScale = 0.75
            drop.yScale = 0.75
            rain.addChild(drop)
        }
        
        //adiciona a chuva na scene
        addChild(rain)
        
        //animação de fazer chover
        let animatesRain: SKAction = SKAction.moveTo(CGPointMake(rain.position.x, UIScreen.mainScreen().bounds.height * -1), duration: 2.0)
        rain.runAction(animatesRain, completion: { () -> Void in
            rain.removeFromParent()
            //fazer a river subir
            if self.river.position.y != 500 {
                self.river.position.y = self.river.position.y + 10
            }else {
                self.river.position.y = 320
            }
        })
    }
    
    //caso erre a operação
    func sun() {
        sunPlayed = SKSpriteNode(imageNamed: "sol")
        switch positionn {
        case 0:
            sunPlayed.position = cloud1.position
            sunPlayed.name = "saiu1"
            cloud1.removeFromParent()
        case 1:
            sunPlayed.position = cloud2.position
            sunPlayed.name = "saiu2"
            cloud2.removeFromParent()
        default:
            sunPlayed.position = cloud3.position
            sunPlayed.name = "saiu3"
            cloud3.removeFromParent()
        }
        
        //animação para o sol aparecer
        let appear = SKAction.fadeInWithDuration(0.5)
        sunPlayed.runAction(appear)
        sunPlayed.alpha = 0
        addChild(sunPlayed)
        
        //diminui a river
        if river.position.y != 320 {
            river.position.y = 320
        }
        
        //zera o nível
        level = 1
        players[index].nivelPlayer = String(level)
    }
    
    // pausa o jogo
    func pause() {
        self.view?.paused = true
    }
}