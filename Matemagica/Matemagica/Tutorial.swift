
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
    
    // background
    var bg: SKSpriteNode = SKSpriteNode()
    
    // adiciona os nodes dos numeros
    var numero1Img: SKSpriteNode = SKSpriteNode()
    var numero2Img: SKSpriteNode = SKSpriteNode()
    var numero3Img: SKSpriteNode = SKSpriteNode()
    var sinal: SKSpriteNode = SKSpriteNode()
    
    let imgToque = SKSpriteNode(imageNamed: "toque1")
    
    // "botao" voltar
    let voltar = SKSpriteNode(imageNamed: "bloco")
    
    // flag para verificar qual a ordem que vai aparecer as funcoes
    var rodou1: Bool! = false
    var rodou2: Bool! = false
    var rodou3: Bool! = false
    
    // animacoes de fade in e fade out
    let fadeIn = SKAction.fadeInWithDuration(1.5)
    let fadeOut = SKAction.fadeOutWithDuration(1.5)
    
    var ref1 = CGPathCreateMutable()
    var ref2 = CGPathCreateMutable()
    var linha = SKShapeNode()
    var linha1Div = SKShapeNode()
    var linha2Div = SKShapeNode()

    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        // notificationCenter para verificar quando voltar para a view anterior ele para o jogo
        var notification:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "pause", name: "pauseView", object: nil)
        
        // adiciona a imagem do toque
        imgToque.position = CGPointMake(size.width - 100, size.height - 200)
        imgToque.size = CGSize(width: 100, height: 100)
        imgToque.zPosition = 100
        addChild(imgToque)
        
        // anima a imagem do toque
        tocando(imgToque)
        
        // background
        bg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        bg.size = CGSize(width: size.width, height: size.height)
        addChild(bg)
        
        // adicionando o "botao" voltar
        voltar.position = CGPoint(x: 100, y: size.height-50)
        voltar.size = CGSize(width: 100, height: 40)
        addChild(voltar)
        
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
        CGPathMoveToPoint(ref1, nil, size.width * 0.05, size.height * 0.325)
        CGPathAddLineToPoint(ref1, nil, size.width * 0.37, size.height * 0.325)
        linha.path = ref1
        linha.lineWidth = 8
        linha.fillColor = UIColor.blackColor()
        linha.strokeColor = UIColor.blackColor()
        linha.alpha = 0.0
        addChild(linha)
        
        // imagem sinal
        sinal.position = CGPoint(x: size.width * 0.105, y: size.height * 0.45)
        sinal.size = CGSize(width: size.width * 0.1, height: size.height * 0.1)
        sinal.alpha = 0.0
        addChild(sinal)

        // imagem do terceiro numero (resultado)
        numero3Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.20)
        numero3Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        numero3Img.alpha = 0.0
        addChild(numero3Img)
        
        // switch para verificar de qual operacao ele veio
        switch tag {
        case 1:
            lblTitulo.text = "4 + 5"
            
            numero1Img.texture = SKTexture(imageNamed: "4")
            numero2Img.texture = SKTexture(imageNamed: "5")
            numero3Img.texture = SKTexture(imageNamed: "9")
            sinal.texture = SKTexture(imageNamed: "adicao")
            
            bg.texture = SKTexture(imageNamed: "fazenda")
            
            n1 = 4
            n2 = 5
            
        case 2:
            lblTitulo.text = "8 - 3"
            
            numero1Img.texture = SKTexture(imageNamed: "8")
            numero2Img.texture = SKTexture(imageNamed: "3")
            numero3Img.texture = SKTexture(imageNamed: "5")
            sinal.texture = SKTexture(imageNamed: "subtracao")
            
            bg.texture = SKTexture(imageNamed: "fazenda")
            
            n1 = 5
            n2 = 3
            
        case 3:
            lblTitulo.text = "2 × 3"
            
            numero1Img.texture = SKTexture(imageNamed: "2")
            numero2Img.texture = SKTexture(imageNamed: "3")
            numero3Img.texture = SKTexture(imageNamed: "6")
            
            // COLOCAR BACKGROUND PARA MULTIPLICACAO (CHOCOLATE)
            
            n1 = 2
            n2 = 2
        case 4:
            lblTitulo.text = "4 ÷ 2"
            
            numero1Img.texture = SKTexture(imageNamed: "4")
            numero2Img.texture = SKTexture(imageNamed: "2")
            numero3Img.texture = SKTexture(imageNamed: "2")
            
            CGPathMoveToPoint(ref2, nil, size.width * 0.5, size.height * 0.75)
            CGPathAddLineToPoint(ref2, nil, size.width * 0.5, size.height * 0.55)
            linha1Div.path = ref2
            linha1Div.lineWidth = 8
            linha1Div.fillColor = UIColor.blackColor()
            linha1Div.strokeColor = UIColor.blackColor()
            linha1Div.alpha = 0.0
            addChild(linha1Div)
            
            CGPathMoveToPoint(ref2, nil, size.width * 0.495, size.height * 0.55)
            CGPathAddLineToPoint(ref2, nil, size.width * 0.9, size.height * 0.55)
            linha2Div.path = ref2
            linha2Div.lineWidth = 8
            linha2Div.fillColor = UIColor.blackColor()
            linha2Div.strokeColor = UIColor.blackColor()
            linha2Div.alpha = 0.0
            addChild(linha2Div)
            
            numero2Img.position = CGPoint(x: size.width * 0.70, y: numero1Img.position.y)
            numero3Img.position = CGPoint(x: size.width * 0.70, y: size.height * 0.45)
            
            // COLOCAR BACKGROUND PARA MULTIPLICACAO (CHOCOLATE)
            
        default:
            break
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if voltar.containsPoint(touchLocation){
            vC.voltar()
        }
        else {
            switch tag {
            case 1: // adicao
                if rodou1 == false {
                    imgToque.hidden = true
                    self.userInteractionEnabled = false
                    numero1Img.runAction(SKAction.sequence([fadeIn]))
                    addImg1(numero1Img, nome: "vaca1")
                    self.enumerateChildNodesWithName("vaca1") {
                        node, stop in
                        var no: SKNode = node
                        self.animacaoVaca(no)
                    }
                    rodou1 = true
                }
                else {
                    if rodou2 == false {
                        imgToque.hidden = true
                        self.userInteractionEnabled = false
                        numero2Img.runAction(SKAction.sequence([fadeIn]))
                        sinal.runAction(SKAction.sequence([fadeIn]))
                        addImg2(numero2Img, nome: "vaca2")
                        self.enumerateChildNodesWithName("vaca2") {
                            node, stop in
                            var no: SKNode = node
                            self.animacaoVaca(no)
                        }
                        rodou2 = true
                    }
                    else {
                        if rodou3 == false {
                            imgToque.hidden = true
                            self.userInteractionEnabled = false
                            numero3Img.runAction(SKAction.sequence([fadeIn]))
                            
                            self.enumerateChildNodesWithName("vaca1") {
                                node, stop in
                                let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.4), duration: 5.0)
                                node.runAction(SKAction.sequence([actionMove]))
                            }
                            
                            self.enumerateChildNodesWithName("vaca2") {
                                node, stop in
                                let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.3), duration: 5.0)
                                node.runAction(SKAction.sequence([actionMove]))
                            }
                            rodou3 = true
                            self.userInteractionEnabled = true
                        }
                    }
                }
                
            case 2: // subtracao
                if rodou1 == false {
                    imgToque.hidden = true
                    self.userInteractionEnabled = false
                    numero1Img.runAction(SKAction.sequence([fadeIn]))
                    addImg1(numero1Img, nome: "ovelha1")
                    addImg2(numero2Img, nome: "ovelha2")
                    self.enumerateChildNodesWithName("ovelha1") {
                        node, stop in
                        var no: SKNode = node
                        self.animacaoOvelha(no)
                    }
                    self.enumerateChildNodesWithName("ovelha2") {
                        node, stop in
                        var no: SKNode = node
                        self.animacaoOvelha(no)
                    }
                    rodou1 = true
                }
                else {
                    if rodou2 == false {
                        imgToque.hidden = true
                        self.userInteractionEnabled = false
                        numero2Img.runAction(SKAction.sequence([fadeIn]))
                        linha.runAction(SKAction.sequence([fadeIn]))
                        moveImg2("ovelha2")
                        rodou2 = true
                    }
                    else {
                        if rodou3 == false {
                            imgToque.hidden = true
                            self.userInteractionEnabled = false
                            numero3Img.runAction(SKAction.sequence([fadeIn]))
                            removeImg2("ovelha2")
                            self.enumerateChildNodesWithName("ovelha1") {
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
                    imgToque.hidden = true
                    self.userInteractionEnabled = false
                    numero1Img.runAction(SKAction.sequence([fadeIn]))
                    addImg1Multiplicacao(numero1Img, nome: "chocolate")
                    rodou1 = true
                }
                else {
                    if rodou2 == false {
                        imgToque.hidden = true
                        self.userInteractionEnabled = false
                        numero2Img.runAction(SKAction.sequence([fadeIn]))
                        linha.runAction(SKAction.sequence([fadeIn]))
                        self.enumerateChildNodesWithName("chocolate") {
                            node, stop in
                            var no: SKNode = node
                            self.addImgRepetida(no, nomeImagem: "chocolate", nomeNo1: "chocolate1",  nomeNo2: "chocolate2")
                        }
                        rodou2 = true
                    }
                    else {
                        if rodou3 == false {
                            imgToque.hidden = true
                            self.userInteractionEnabled = false
                            numero3Img.runAction(SKAction.sequence([fadeIn]))
                            self.enumerateChildNodesWithName("chocolate") {
                                node, stop in
                                let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.40), duration: 2.0)
                                node.runAction(SKAction.sequence([actionMove]))
                            }
                            self.enumerateChildNodesWithName("chocolate1") {
                                node, stop in
                                let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.35), duration: 2.0)
                                node.runAction(SKAction.sequence([actionMove]))
                            }
                            self.enumerateChildNodesWithName("chocolate2") {
                                node, stop in
                                let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.30), duration: 2.0)
                                node.runAction(SKAction.sequence([actionMove]))
                            }
                            rodou3 = true
                            self.userInteractionEnabled = true
                        }
                    }
                }
            case 4: // divisão
                if rodou1 == false {
                    imgToque.hidden = true
                    self.userInteractionEnabled = false
                    numero1Img.runAction(SKAction.sequence([fadeIn]))
                    addImgDivisao()
                    rodou1 = true
                }
                else {
                    if rodou2 == false {
                        imgToque.hidden = true
                        self.userInteractionEnabled = false
                        numero2Img.runAction(SKAction.sequence([fadeIn]))
                        
                        linha1Div.runAction(SKAction.sequence([fadeIn]))
                        linha2Div.runAction(SKAction.sequence([fadeIn]))

                        
                        let zoomIn = SKAction.scaleTo(1.5, duration: 1.5)
                        let zoomOut = SKAction.scaleTo(1.0, duration: 1.5)
                        
                        self.enumerateChildNodesWithName("pizza2") {
                            node, stop in
                            var no: SKNode = node
                            no.runAction(SKAction.sequence([zoomIn]), completion: { () -> Void in
                                no.runAction(SKAction.sequence([zoomOut]))
                            })
                        }
                        self.enumerateChildNodesWithName("pizza3") {
                            node, stop in
                            var no: SKNode = node
                            no.runAction(SKAction.sequence([zoomIn]), completion: { () -> Void in
                                no.runAction(SKAction.sequence([zoomOut]), completion: { () -> Void in
                                    self.imgToque.hidden = false
                                    self.userInteractionEnabled = true
                                })
                            })
                        }
                        rodou2 = true
                    }
                    else {
                        if rodou3 == false {
                            imgToque.hidden = true
                            self.userInteractionEnabled = false
                            numero3Img.runAction(SKAction.sequence([fadeIn]))
                            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width * 0.10, dy: 0.0), duration: 2.0)
                            let waitSomeTime1 = SKAction.waitForDuration(2)
                            let waitSomeTime2 = SKAction.waitForDuration(2)
                            
                            self.enumerateChildNodesWithName("pizza2") {
                                node, stop in
                                node.runAction(SKAction.sequence([actionMove, waitSomeTime1]))
                            }
                            self.enumerateChildNodesWithName("pizza3") {
                                node, stop in
                                node.runAction(SKAction.sequence([actionMove, waitSomeTime1]), completion: { () -> Void in
                                    self.adicionarNumeroMenosDivisao()
                                    self.linha.runAction(SKAction.sequence([self.fadeIn]))
                                    self.enumerateChildNodesWithName("divisaoMenos") {
                                        node, stop in
                                        node.runAction(SKAction.sequence([self.fadeIn, waitSomeTime2]), completion: { () -> Void in
                                            self.adicionarNumeroRestoDivisao()
                                            self.enumerateChildNodesWithName("divisaoResto") {
                                                node, stop in
                                                node.runAction(SKAction.sequence([self.fadeIn]), completion: { () -> Void in
                                                    self.userInteractionEnabled = true
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                            rodou3 = true
                        }
                    }
                }
            default:
                break
            }
        }
    }
    
    // adiciona o primeiro conjunto de imagens na adicao, subtracao e multiplicacao
    func addImg1(img: SKSpriteNode, nome: String) {
        for var i = 0; i < n1; i++ {
            let exemplo1Img = SKSpriteNode(imageNamed: nome)
            exemplo1Img.name = nome
            exemplo1Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo1Img.frame.size)
            exemplo1Img.physicsBody!.dynamic = false
            
            var xPos1 = (CGFloat(self.size.width * 1.5) * CGFloat(Double(i) / 13) + CGFloat(self.size.width))
            exemplo1Img.position = CGPointMake(xPos1, img.position.y)
            exemplo1Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(exemplo1Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 5.0)
            exemplo1Img.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgToque.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // adiciona o primeiro conjunto de imagens na adicao, subtracao e multiplicacao
    func addImg1Multiplicacao(img: SKSpriteNode, nome: String) {
        for var i = 0; i < n1; i++ {
            let exemplo1Img = SKSpriteNode(imageNamed: nome)
            exemplo1Img.name = nome
            exemplo1Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo1Img.frame.size)
            exemplo1Img.physicsBody!.dynamic = false
            
            var xPos1 = (CGFloat(self.size.width * 1.5) * CGFloat(Double(i) / 8) + CGFloat(self.size.width))
            exemplo1Img.position = CGPointMake(xPos1, img.position.y)
            exemplo1Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(exemplo1Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 5.0)
            exemplo1Img.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgToque.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // adiciona o segundo conjunto de imagens na adicao e na subtracao
    func addImg2(img: SKSpriteNode, nome: String) {
        for var i = 0; i < n2; i++ {
            let exemplo2Img = SKSpriteNode(imageNamed: nome)
            exemplo2Img.name = nome
            exemplo2Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo2Img.frame.size)
            exemplo2Img.physicsBody!.dynamic = false
            
            var xPos2 = (CGFloat(self.size.width * 1.5) * CGFloat(Double(i) / 13) + CGFloat(self.size.width))
            exemplo2Img.position = CGPointMake(xPos2, img.position.y)
            exemplo2Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(exemplo2Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 5.0)
            exemplo2Img.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgToque.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // move o segundo conjunto de imagens na subtracao
    func moveImg2(nome: String) {
        self.enumerateChildNodesWithName(nome) {
            node, stop in
            let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.1), duration: 1.5)
            node.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgToque.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // remove da tela o segundo conjunto de imagens da subtracao
    func removeImg2(nome: String) {
        self.enumerateChildNodesWithName(nome) {
            node, stop in
            node.runAction(SKAction.sequence([self.fadeOut]))
        }
    }
    
    // adiciona o segundo conjunto de imagens na multiplicacao
    func addImgRepetida(img: SKNode, nomeImagem: String, nomeNo1: String, nomeNo2: String) {
        for var i = 0; i < n2; i++ {
            let exemplo2Img = SKSpriteNode(imageNamed: nomeImagem)
            exemplo2Img.name = nomeNo1
            exemplo2Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo2Img.frame.size)
            exemplo2Img.physicsBody!.dynamic = false
            
            exemplo2Img.position = CGPointMake(img.position.x, img.position.y)
            exemplo2Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(exemplo2Img)
            
            let actionMove2 = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.width * 0.15), duration: 2.0)
            exemplo2Img.runAction(SKAction.sequence([actionMove2]))
            
            let exemplo3Img = SKSpriteNode(imageNamed: nomeImagem)
            exemplo3Img.name = nomeNo2
            exemplo3Img.physicsBody = SKPhysicsBody(rectangleOfSize: exemplo3Img.frame.size)
            exemplo3Img.physicsBody!.dynamic = false
            
            exemplo3Img.position = CGPointMake(img.position.x, img.position.y)
            exemplo3Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(exemplo3Img)
            
            let actionMove3 = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.width * 0.30), duration: 2.0)
            exemplo3Img.runAction(SKAction.sequence([actionMove3]), completion: { () -> Void in
                self.imgToque.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // adiciona imagem na divisao
    func addImgDivisao() {
        let exemploImgPizza1 = SKSpriteNode(imageNamed: "pizza1")
        exemploImgPizza1.name = "pizza1"
        exemploImgPizza1.physicsBody = SKPhysicsBody(rectangleOfSize: exemploImgPizza1.frame.size)
        exemploImgPizza1.physicsBody!.dynamic = false
        exemploImgPizza1.position = CGPointMake(size.width * 0.755, size.height * 0.205)
        exemploImgPizza1.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exemploImgPizza1.alpha = 0.0
        self.addChild(exemploImgPizza1)
        exemploImgPizza1.runAction(SKAction.sequence([fadeIn]))
        
        let exemploImgPizza2 = SKSpriteNode(imageNamed: "pizza2")
        exemploImgPizza2.name = "pizza2"
        exemploImgPizza2.physicsBody = SKPhysicsBody(rectangleOfSize: exemploImgPizza2.frame.size)
        exemploImgPizza2.physicsBody!.dynamic = false
        exemploImgPizza2.position = CGPointMake(size.width * 0.745, size.height * 0.205)
        exemploImgPizza2.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exemploImgPizza2.alpha = 0.0
        self.addChild(exemploImgPizza2)
        exemploImgPizza2.runAction(SKAction.sequence([fadeIn]))
        
        let exemploImgPizza3 = SKSpriteNode(imageNamed: "pizza3")
        exemploImgPizza3.name = "pizza3"
        exemploImgPizza3.physicsBody = SKPhysicsBody(rectangleOfSize: exemploImgPizza3.frame.size)
        exemploImgPizza3.physicsBody!.dynamic = false
        exemploImgPizza3.position = CGPointMake(size.width * 0.745, size.height * 0.195)
        exemploImgPizza3.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exemploImgPizza3.alpha = 0.0
        self.addChild(exemploImgPizza3)
        exemploImgPizza3.runAction(SKAction.sequence([fadeIn]))
        
        let exemploImgPizza4 = SKSpriteNode(imageNamed: "pizza4")
        exemploImgPizza4.name = "pizza4"
        exemploImgPizza4.physicsBody = SKPhysicsBody(rectangleOfSize: exemploImgPizza4.frame.size)
        exemploImgPizza4.physicsBody!.dynamic = false
        exemploImgPizza4.position = CGPointMake(size.width * 0.755, size.height * 0.195)
        exemploImgPizza4.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exemploImgPizza4.alpha = 0.0
        self.addChild(exemploImgPizza4)
        exemploImgPizza4.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
            self.imgToque.hidden = false
            self.userInteractionEnabled = true
        })
    }
    
    func adicionarNumeroMenosDivisao() {
        let numeroDivisaoMenos = SKSpriteNode(imageNamed: "4")
        numeroDivisaoMenos.name = "divisaoMenos"
        numeroDivisaoMenos.position = CGPoint(x: size.width * 0.25, y: size.height * 0.45)
        numeroDivisaoMenos.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        numeroDivisaoMenos.alpha = 0.0
        addChild(numeroDivisaoMenos)
    }
    
    func adicionarNumeroRestoDivisao() {
        let numeroDivisaoResto = SKSpriteNode(imageNamed: "0")
        numeroDivisaoResto.name = "divisaoResto"
        numeroDivisaoResto.position = CGPoint(x: size.width * 0.25, y: size.height * 0.20)
        numeroDivisaoResto.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        numeroDivisaoResto.alpha = 0.0
        addChild(numeroDivisaoResto)
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
    
    // animacao da vaca
    func animacaoVaca(object: SKNode) {
        let vacaAnimada = SKAction.animateWithTextures([
            SKTexture(imageNamed: "vaca3"),
            SKTexture(imageNamed: "vaca1"),
            SKTexture(imageNamed: "vaca2"),
            SKTexture(imageNamed: "vaca1"),
            ], timePerFrame: 0.3)
        
        let run = SKAction.repeatActionForever(vacaAnimada)
        object.runAction(run, withKey: "vacaAnimada")
    }
    
    // animacao do ovelha
    func animacaoOvelha(object: SKNode) {
        let ovelhaAnimada = SKAction.animateWithTextures([
            SKTexture(imageNamed: "ovelha1"),
            SKTexture(imageNamed: "ovelha2"),
            SKTexture(imageNamed: "ovelha1"),
            SKTexture(imageNamed: "ovelha3"),
            ], timePerFrame: 0.3)
        
        let run = SKAction.repeatActionForever(ovelhaAnimada)
        object.runAction(run, withKey: "ovelhaAnimada")
    }
}