
//
//  Tutorial.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 19/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import SpriteKit

class Tutorial: SKScene {
    
    // tag para verificar qual a operacao que foi clicada na tela anterior
    var tag:Int!
    
    var vC: TutorialDetailViewController!
    var lblTitulo: SKLabelNode = SKLabelNode()
    
    // numeros que serao usados para fazer a conta
    var n1: Int!
    var n2: Int!
    
    // adiciona os nodes dos numeros
    var numero1Img: SKSpriteNode = SKSpriteNode()
    var numero2Img: SKSpriteNode = SKSpriteNode()
    var numero3Img: SKSpriteNode = SKSpriteNode()
    
    let imgToque = SKSpriteNode(imageNamed: "toque1")
    
    // flag para verificar qual a ordem que vai aparecer as funcoes
    var rodou1: Bool! = false
    var rodou2: Bool! = false
    var rodou3: Bool! = false
    
    // animacoes de fade in e fade out
    let fadeIn = SKAction.fadeInWithDuration(2.0)
    let fadeOut = SKAction.fadeOutWithDuration(2.0)
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        // notificationCenter para verificar quando voltar para a view anterior ele para o jogo
        var notification:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "pause", name: "pauseView", object: nil)
        
        // adiciona a imagem do toque
        imgToque.position = CGPointMake(size.width - 100, size.height - 200)
        imgToque.size = CGSize(width: 100, height: 100)
        addChild(imgToque)
        
        // anima a imagem do toque
        tocando(imgToque)

        // label mostrando a conta do exercicio
        lblTitulo.fontName = "Noteworthy-Bold"
        lblTitulo.fontSize = 100
        lblTitulo.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
        lblTitulo.fontColor = SKColor.blackColor()
        addChild(lblTitulo)
        
        // imagem do primeiro numero da conta
        numero1Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.65)
        numero1Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        numero1Img.alpha = 0.0
        addChild(numero1Img)
        
        // imagem do segundo numero da conta
        numero2Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.45)
        numero2Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        numero2Img.alpha = 0.0
        addChild(numero2Img)
        
        // adiciona uma linha para separar a conta do resultado
        var ref = CGPathCreateMutable()
        var linha = SKShapeNode()
        CGPathMoveToPoint(ref, nil, size.width * 0.05, size.height * 0.325)
        CGPathAddLineToPoint(ref, nil, size.width * 0.37, size.height * 0.325)
        linha.path = ref
        linha.lineWidth = 8
        linha.fillColor = UIColor.blackColor()
        linha.strokeColor = UIColor.blackColor()
        addChild(linha)
        
        // imagem do terceiro numero (resultado)
        numero3Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.20)
        numero3Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        numero3Img.alpha = 0.0
        addChild(numero3Img)
        
        // switch para verificar de qual operacao ele veio
        switch tag {
        case 1:
            vC.navigationItem.title = "SOMA"
            lblTitulo.text = "4 + 5"
            
            numero1Img.texture = SKTexture(imageNamed: "4")
            numero2Img.texture = SKTexture(imageNamed: "5")
            numero3Img.texture = SKTexture(imageNamed: "9")
            
            n1 = 4
            n2 = 5
            
        case 2:
            vC.navigationItem.title = "SUBTRAÇÃO"
            lblTitulo.text = "8 - 3"
            
            numero1Img.texture = SKTexture(imageNamed: "8")
            numero2Img.texture = SKTexture(imageNamed: "3")
            numero3Img.texture = SKTexture(imageNamed: "5")
            
            n1 = 5
            n2 = 3
            
        case 3:
            vC.navigationItem.title = "MULTIPLICAÇÃO"
            lblTitulo.text = "2 × 3"
            
            numero1Img.texture = SKTexture(imageNamed: "2")
            numero2Img.texture = SKTexture(imageNamed: "3")
            numero3Img.texture = SKTexture(imageNamed: "6")
            
            n1 = 2
            n2 = 2
        case 4:
            vC.navigationItem.title = "DIVISÃO"
            lblTitulo.text = "10 ÷ 5"
        default:
            break
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        switch tag {
        case 1: // adicao
            if rodou1 == false {
                imgToque.alpha = 0.0
                self.userInteractionEnabled = false
                numero1Img.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
                    self.imgToque.alpha = 1.0
                    self.userInteractionEnabled = true
                })
                addImg1(numero1Img)
                rodou1 = true
            }
            else {
                if rodou2 == false {
                    imgToque.alpha = 0.0
                    self.userInteractionEnabled = false
                    numero2Img.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
                        self.imgToque.alpha = 1.0
                        self.userInteractionEnabled = true
                    })
                    addImg2(numero2Img)
                    rodou2 = true
                }
                else {
                    if rodou3 == false {
                        imgToque.alpha = 0.0
                        self.userInteractionEnabled = false
                        numero3Img.runAction(SKAction.sequence([fadeIn]))
                        
                        self.enumerateChildNodesWithName("4") {
                            node, stop in
                            let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.4), duration: 2.0)
                            node.runAction(SKAction.sequence([actionMove]))
                        }
                        
                        self.enumerateChildNodesWithName("5") {
                            node, stop in
                            let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.3), duration: 2.0)
                            node.runAction(SKAction.sequence([actionMove]))
                        }
                        rodou3 = true
                        self.userInteractionEnabled = true
                    }
                }
            }
            
        case 2: // subtracao
            if rodou1 == false {
                imgToque.alpha = 0.0
                self.userInteractionEnabled = false
                numero1Img.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
                    self.imgToque.alpha = 1.0
                    self.userInteractionEnabled = true
                })
                addImg1(numero1Img)
                addImg2(numero2Img)
                rodou1 = true
            }
            else {
                if rodou2 == false {
                    imgToque.alpha = 0.0
                    self.userInteractionEnabled = false
                    numero2Img.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
                        self.imgToque.alpha = 1.0
                        self.userInteractionEnabled = true
                    })
                    moveImg2()
                    rodou2 = true
                }
                else {
                    if rodou3 == false {
                        imgToque.alpha = 0.0
                        self.userInteractionEnabled = false
                        numero3Img.runAction(SKAction.sequence([fadeIn]))
                        removeImg2()
                        self.enumerateChildNodesWithName("4") {
                            node, stop in
                            let actionMove = SKAction.moveToY(self.numero3Img.position.y, duration: 2.0)
                            node.runAction(SKAction.sequence([actionMove]))
                        }
                        rodou3 = true
                        self.userInteractionEnabled = true
                    }
                }
            }
        case 3: // multiplicacao
            if rodou1 == false {
                imgToque.alpha = 0.0
                self.userInteractionEnabled = false
                numero1Img.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
                    self.imgToque.alpha = 1.0
                    self.userInteractionEnabled = true
                })
                addImg1(numero1Img)
                rodou1 = true
            }
            else {
                if rodou2 == false {
                    imgToque.alpha = 0.0
                    self.userInteractionEnabled = false
                    numero2Img.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
                        self.imgToque.alpha = 1.0
                        self.userInteractionEnabled = true
                    })

                    self.enumerateChildNodesWithName("4") {
                        node, stop in
                        var no: SKNode = node
                        self.addImgRepetida(no)
                    }
                    rodou2 = true
                }
                else {
                    if rodou3 == false {
                        imgToque.alpha = 0.0
                        self.userInteractionEnabled = false
                        numero3Img.runAction(SKAction.sequence([fadeIn]))
                        self.enumerateChildNodesWithName("7") {
                            node, stop in
                            let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.3), duration: 2.0)
                            node.runAction(SKAction.sequence([actionMove]))
                        }
                        
                        self.enumerateChildNodesWithName("4") {
                            node, stop in
                            let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.3), duration: 2.0)
                            
                            node.runAction(SKAction.sequence([actionMove]))
                        }
                        rodou3 = true
                        self.userInteractionEnabled = false

                    }
                }
            }
        case 4:
            var bla = 0
        default:
            break
        }
        
    }
    
    // adiciona o primeiro conjunto de imagens na adicao, subtracao e multiplicacao
    func addImg1(img: SKSpriteNode) {
        for var i = 0; i < n1; i++ {
            let exemplo1Img = SKSpriteNode(imageNamed: "4")
            exemplo1Img.name = "4"
            exemplo1Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo1Img.frame.size)
            exemplo1Img.physicsBody!.dynamic = false
            
            var xPos1 = (CGFloat(self.size.width * 2) * CGFloat(Double(i) / 20) + CGFloat(self.size.width))
            exemplo1Img.position = CGPointMake(xPos1, img.position.y)
            exemplo1Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
            self.addChild(exemplo1Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 2.0)
            exemplo1Img.runAction(SKAction.sequence([actionMove]))
        }
    }
    
    // adiciona o segundo conjunto de imagens na adicao e na subtracao
    func addImg2(img: SKSpriteNode) {
        for var i = 0; i < n2; i++ {
            let exemplo2Img = SKSpriteNode(imageNamed: "5")
            exemplo2Img.name = "5"
            exemplo2Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo2Img.frame.size)
            exemplo2Img.physicsBody!.dynamic = false
            
            var xPos2 = (CGFloat(self.size.width * 2) * CGFloat(Double(i) / 20) + CGFloat(self.size.width))
            exemplo2Img.position = CGPointMake(xPos2, img.position.y)
            exemplo2Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
            self.addChild(exemplo2Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 2.0)
            exemplo2Img.runAction(SKAction.sequence([actionMove]))
        }
    }
    
    // move o segundo conjunto de imagens na subtracao
    func moveImg2() {
        self.enumerateChildNodesWithName("5") {
            node, stop in
            let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.1), duration: 2.0)
            node.runAction(SKAction.sequence([actionMove]))
        }
    }
    
    // remove da tela o segundo conjunto de imagens da subtracao
    func removeImg2() {
        self.enumerateChildNodesWithName("5") {
            node, stop in
            node.runAction(SKAction.sequence([self.fadeOut]))
        }
    }
    
    // adiciona o segundo conjunto de imagens na multiplicacao
    func addImgRepetida(img: SKNode) {
        for var i = 0; i < n2; i++ {
            let exemplo2Img = SKSpriteNode(imageNamed: "7")
            exemplo2Img.name = "7"
            exemplo2Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo2Img.frame.size)
            exemplo2Img.physicsBody!.dynamic = false
            
            exemplo2Img.position = CGPointMake(img.position.x, img.position.y)
            exemplo2Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
            self.addChild(exemplo2Img)
            
            let actionMove2 = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.width * 0.2), duration: 2.0)
            exemplo2Img.runAction(SKAction.sequence([actionMove2]))
            
            
            let exemplo3Img = SKSpriteNode(imageNamed: "7")
            exemplo3Img.name = "7"
            exemplo3Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo3Img.frame.size)
            exemplo3Img.physicsBody!.dynamic = false
            
            exemplo3Img.position = CGPointMake(img.position.x, img.position.y)
            exemplo3Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
            self.addChild(exemplo3Img)
            
            let actionMove3 = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.width * 0.4), duration: 2.0)
            exemplo3Img.runAction(SKAction.sequence([actionMove3]))

        }
    }
    
    // pausa o jogo
    func pause() {
        self.view?.paused = true
    }
    
    // animacao do toque
    func tocando(object: SKSpriteNode) {
        
        let toqueNaTela = SKAction.animateWithTextures([
            SKTexture(imageNamed: "toque1"),
            SKTexture(imageNamed: "toque2"),
            ], timePerFrame: 0.5)
        
        let run = SKAction.repeatActionForever(toqueNaTela)
        object.runAction(run, withKey: "tocando")
    }

}