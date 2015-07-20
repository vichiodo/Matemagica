
//
//  Tutorial.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 19/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import SpriteKit

class TutorialGameScene: SKScene {
    
    // tag para verificar qual a operacao que foi clicada na tela anterior
    var tag:Int!
    var vC: TutorialDetailViewController!
    let lblTitle: SKLabelNode = SKLabelNode()
    
    // numeros que serao usados para fazer a conta
    var n1: Int!
    var n2: Int!
    
    // background
    let bg: SKSpriteNode = SKSpriteNode()
    
    // adiciona os nodes dos numeros
    let number1Img: SKSpriteNode = SKSpriteNode()
    let number2Img: SKSpriteNode = SKSpriteNode()
    let number3Img: SKSpriteNode = SKSpriteNode()
    let sign: SKSpriteNode = SKSpriteNode()
    let blackBoard: SKSpriteNode = SKSpriteNode()
    
    let imgTouch = SKSpriteNode(imageNamed: "toque1")
    
    // verificar do toque para qual a ordem que vai aparecer as funcoes
    var touchNumber: Int = 1
    
    // animacoes de fade in e fade out
    let fadeIn = SKAction.fadeInWithDuration(1.5)
    let fadeOut = SKAction.fadeOutWithDuration(1.5)
    
    var ref1 = CGPathCreateMutable()
    var ref2 = CGPathCreateMutable()
    var lineResult = SKShapeNode()
    var lineDivision1 = SKShapeNode()
    var lineDivision2 = SKShapeNode()
    
    let back = SKSpriteNode(imageNamed: "voltar")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        // notificationCenter para verificar quando voltar para a view anterior ele para o jogo
        var notification:NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "pause", name: "pauseTutorial", object: nil)
        
        // adiciona a imagem do toque
        imgTouch.position = CGPointMake(size.width - 100, size.height - 200)
        imgTouch.size = CGSize(width: 100, height: 100)
        imgTouch.zPosition = 100
        addChild(imgTouch)
        
        // anima a imagem do toque
        touching(imgTouch)
        
        // background
        bg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        bg.size = CGSize(width: size.width, height: size.height)
        addChild(bg)
        
        // "botao" voltar
        back.position = CGPoint(x: 53.5, y: size.height - 65.6)
        back.size = CGSize(width: 75, height: 75)
        addChild(back)
        
        // label mostrando a conta do exercicio
        lblTitle.fontName = "Noteworthy-Bold"
        lblTitle.fontSize = 100
        lblTitle.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
        lblTitle.fontColor = SKColor.blackColor()
        addChild(lblTitle)
        
        // imagem do quadro negro
        blackBoard.position = CGPoint(x: size.width * 0.20, y: size.height * 0.43)
        blackBoard.size = CGSize(width: size.width * 0.40, height: size.height * 0.7)
        blackBoard.texture = SKTexture(imageNamed: "quadro")
        addChild(blackBoard)
        
        // imagem do primeiro numero da conta
        number1Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.65)
        number1Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        number1Img.alpha = 0.0
        addChild(number1Img)
        
        // imagem do segundo numero da conta
        number2Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.45)
        number2Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        number2Img.alpha = 0.0
        addChild(number2Img)
        
        // adiciona uma linha para separar a conta do resultado
        CGPathMoveToPoint(ref1, nil, size.width * 0.05, size.height * 0.325)
        CGPathAddLineToPoint(ref1, nil, size.width * 0.37, size.height * 0.325)
        lineResult.path = ref1
        lineResult.lineWidth = 8
        lineResult.fillColor = UIColor.blackColor()
        lineResult.strokeColor = UIColor.blackColor()
        lineResult.alpha = 0.0
        addChild(lineResult)
        
        // imagem sinal
        sign.position = CGPoint(x: size.width * 0.105, y: size.height * 0.45)
        sign.size = CGSize(width: size.width * 0.1, height: size.height * 0.1)
        sign.alpha = 0.0
        addChild(sign)
        
        // imagem do terceiro numero (resultado)
        number3Img.position = CGPoint(x: size.width * 0.25, y: size.height * 0.20)
        number3Img.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        number3Img.alpha = 0.0
        addChild(number3Img)
        
        // switch para verificar de qual operacao ele veio
        switch tag {
        case 1:
            lblTitle.text = "4 + 5"
            
            number1Img.texture = SKTexture(imageNamed: "4")
            number2Img.texture = SKTexture(imageNamed: "5")
            number3Img.texture = SKTexture(imageNamed: "9")
            sign.texture = SKTexture(imageNamed: "add")
            
            bg.texture = SKTexture(imageNamed: "fazenda")
            
            n1 = 4
            n2 = 5
            
        case 2:
            lblTitle.text = "8 - 3"
            
            number1Img.texture = SKTexture(imageNamed: "8")
            number2Img.texture = SKTexture(imageNamed: "3")
            number3Img.texture = SKTexture(imageNamed: "5")
            sign.texture = SKTexture(imageNamed: "subtracao2")
            
            bg.texture = SKTexture(imageNamed: "fazenda")
            
            n1 = 5
            n2 = 3
            
        case 3:
            lblTitle.text = "2 × 3"
            
            number1Img.texture = SKTexture(imageNamed: "2")
            number2Img.texture = SKTexture(imageNamed: "3")
            number3Img.texture = SKTexture(imageNamed: "6")
            sign.texture = SKTexture(imageNamed: "multiplicacao2")
            
            bg.texture = SKTexture(imageNamed: "bgchocolate")
            
            n1 = 2
            n2 = 2
        case 4:
            lblTitle.text = "4 ÷ 2"
            
            number1Img.texture = SKTexture(imageNamed: "4")
            number2Img.texture = SKTexture(imageNamed: "2")
            number3Img.texture = SKTexture(imageNamed: "2")
            sign.texture = SKTexture(imageNamed: "subtracao2")
            bg.texture = SKTexture(imageNamed: "xadrez")
            
            blackBoard.position = CGPoint(x: size.width * 0.50, y: size.height * 0.40)
            blackBoard.size = CGSize(width: size.width * 0.95, height: size.height * 0.80)
            
            CGPathMoveToPoint(ref2, nil, size.width * 0.5, size.height * 0.75)
            CGPathAddLineToPoint(ref2, nil, size.width * 0.5, size.height * 0.55)
            lineDivision1.path = ref2
            lineDivision1.lineWidth = 8
            lineDivision1.fillColor = UIColor.blackColor()
            lineDivision1.strokeColor = UIColor.blackColor()
            lineDivision1.alpha = 0.0
            addChild(lineDivision1)
            
            CGPathMoveToPoint(ref2, nil, size.width * 0.495, size.height * 0.55)
            CGPathAddLineToPoint(ref2, nil, size.width * 0.9, size.height * 0.55)
            lineDivision2.path = ref2
            lineDivision2.lineWidth = 8
            lineDivision2.fillColor = UIColor.blackColor()
            lineDivision2.strokeColor = UIColor.blackColor()
            lineDivision2.alpha = 0.0
            addChild(lineDivision2)
            
            number2Img.position = CGPoint(x: size.width * 0.70, y: number1Img.position.y)
            number3Img.position = CGPoint(x: size.width * 0.70, y: size.height * 0.45)
        default:
            break
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if back.containsPoint(touchLocation){
            vC.back()
        }
            
        else {
            switch tag {
            case 1: // adicao
                if touchNumber == 1 {
                    imgTouch.hidden = true
                    self.userInteractionEnabled = false
                    number1Img.runAction(SKAction.sequence([fadeIn]))
                    runAction(SKAction.playSoundFileNamed("adicao1.mp3", waitForCompletion: false))
                    addImg1(number1Img, name: "vaca1")
                    self.enumerateChildNodesWithName("vaca1") {
                        node, stop in
                        var no: SKNode = node
                        self.animationCow(no)
                    }
                    touchNumber++
                }
                else {
                    if touchNumber == 2 {
                        imgTouch.hidden = true
                        self.userInteractionEnabled = false
                        number2Img.runAction(SKAction.sequence([fadeIn]))
                        lineResult.runAction(SKAction.sequence([fadeIn]))
                        sign.runAction(SKAction.sequence([fadeIn]))
                        
                        runAction(SKAction.playSoundFileNamed("adicao2.mp3", waitForCompletion: true), completion: { () -> Void in
                            self.runAction(SKAction.playSoundFileNamed("adicao3.mp3", waitForCompletion: true), completion: { () -> Void in
                                self.runAction(SKAction.playSoundFileNamed("adicao4.mp3", waitForCompletion: true))
                            })
                        })
                        
                        addImg2(number2Img, name: "vaca2")
                        self.enumerateChildNodesWithName("vaca2") {
                            node, stop in
                            var no: SKNode = node
                            self.animationCow(no)
                        }
                        touchNumber++
                    }
                    else {
                        if touchNumber == 3 {
                            imgTouch.hidden = true
                            self.userInteractionEnabled = false
                            number3Img.runAction(SKAction.sequence([fadeIn]))
                            runAction(SKAction.playSoundFileNamed("adicao5.mp3", waitForCompletion: false))
                            
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
                            touchNumber++
                            self.userInteractionEnabled = true
                        }
                    }
                }
                
            case 2: // subtracao
                if touchNumber == 1 {
                    imgTouch.hidden = true
                    self.userInteractionEnabled = false
                    number1Img.runAction(SKAction.sequence([fadeIn]))
                    runAction(SKAction.playSoundFileNamed("subtracao1.mp3", waitForCompletion: true))
                    addImg1(number1Img, name: "ovelha1")
                    addImg2(number2Img, name: "ovelha2")
                    self.enumerateChildNodesWithName("ovelha1") {
                        node, stop in
                        var no: SKNode = node
                        self.animationSheep(no)
                    }
                    self.enumerateChildNodesWithName("ovelha2") {
                        node, stop in
                        var no: SKNode = node
                        self.animationSheep(no)
                    }
                    touchNumber++
                }
                else {
                    if touchNumber == 2 {
                        imgTouch.hidden = true
                        self.userInteractionEnabled = false
                        number2Img.runAction(SKAction.sequence([fadeIn]))
                        lineResult.runAction(SKAction.sequence([fadeIn]))
                        sign.runAction(SKAction.sequence([fadeIn]))
                        runAction(SKAction.playSoundFileNamed("subtracao2.mp3", waitForCompletion: true), completion: { () -> Void in
                            self.runAction(SKAction.playSoundFileNamed("subtracao3.mp3", waitForCompletion: true), completion: { () -> Void in
                                self.runAction(SKAction.playSoundFileNamed("subtracao4.mp3", waitForCompletion: true))
                            })
                        })
                        
                        moveImg2("ovelha2")
                        touchNumber++
                    }
                    else {
                        if touchNumber == 3 {
                            imgTouch.hidden = true
                            self.userInteractionEnabled = false
                            number3Img.runAction(SKAction.sequence([fadeIn]))
                            runAction(SKAction.playSoundFileNamed("subtracao5.mp3", waitForCompletion: true))
                            removeImg2("ovelha2")
                            self.enumerateChildNodesWithName("ovelha1") {
                                node, stop in
                                let actionMove = SKAction.moveToY(self.number3Img.position.y, duration: 2.0)
                                node.runAction(SKAction.sequence([actionMove]))
                            }
                            touchNumber++
                            self.userInteractionEnabled = true
                        }
                    }
                }
                
            case 3: // multiplicacao
                if touchNumber == 1 {
                    imgTouch.hidden = true
                    self.userInteractionEnabled = false
                    number1Img.runAction(SKAction.sequence([fadeIn]))
                    runAction(SKAction.playSoundFileNamed("multiplicacao1.mp3", waitForCompletion: true))
                    addImg1Multiplication(number1Img, name: "chocolate")
                    touchNumber++
                }
                else {
                    if touchNumber == 2 {
                        imgTouch.hidden = true
                        self.userInteractionEnabled = false
                        number2Img.runAction(SKAction.sequence([fadeIn]))
                        lineResult.runAction(SKAction.sequence([fadeIn]))
                        sign.runAction(SKAction.sequence([fadeIn]))
                        runAction(SKAction.playSoundFileNamed("multiplicacao2.mp3", waitForCompletion: true), completion: { () -> Void in
                            self.runAction(SKAction.playSoundFileNamed("multiplicacao3.mp3", waitForCompletion: true), completion: { () -> Void in
                                self.runAction(SKAction.playSoundFileNamed("multiplicacao4.mp3", waitForCompletion: true))
                            })
                        })
                        
                        self.enumerateChildNodesWithName("chocolate") {
                            node, stop in
                            var no: SKNode = node
                            self.addImgMultiplication(no, imgName: "chocolate", img1Name: "chocolate1",  img2Name: "chocolate2")
                        }
                        touchNumber++
                    }
                    else {
                        if touchNumber == 3 {
                            imgTouch.hidden = true
                            self.userInteractionEnabled = false
                            number3Img.runAction(SKAction.sequence([fadeIn]))
                            runAction(SKAction.playSoundFileNamed("multiplicacao5.mp3", waitForCompletion: true))
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
                            touchNumber++
                            self.userInteractionEnabled = true
                        }
                    }
                }
            case 4: // divisão
                if touchNumber == 1 {
                    imgTouch.hidden = true
                    self.userInteractionEnabled = false
                    number1Img.runAction(SKAction.sequence([fadeIn]))
                    runAction(SKAction.playSoundFileNamed("divisao1.mp3", waitForCompletion: true))
                    addImgDivision()
                    touchNumber++
                }
                else {
                    if touchNumber == 2 {
                        imgTouch.hidden = true
                        self.userInteractionEnabled = false
                        number2Img.runAction(SKAction.sequence([fadeIn]))
                        
                        runAction(SKAction.playSoundFileNamed("divisao2.mp3", waitForCompletion: true))
                        
                        lineDivision1.runAction(SKAction.sequence([fadeIn]))
                        lineDivision2.runAction(SKAction.sequence([fadeIn]))
                        
                        let zoomIn = SKAction.scaleTo(1.2, duration: 1.5)
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
                                    self.imgTouch.hidden = false
                                    self.userInteractionEnabled = true
                                })
                            })
                        }
                        touchNumber++
                    }
                    else {
                        if touchNumber == 3 {
                            imgTouch.hidden = true
                            self.userInteractionEnabled = false
                            number3Img.runAction(SKAction.sequence([fadeIn]))
                            runAction(SKAction.playSoundFileNamed("divisao3.mp3", waitForCompletion: true))
                            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width * 0.10, dy: 0.0), duration: 2.0)
                            let waitSomeTime1 = SKAction.waitForDuration(1)
                            let waitSomeTime2 = SKAction.waitForDuration(0.5)
                            
                            self.enumerateChildNodesWithName("pizza2") {
                                node, stop in
                                node.runAction(SKAction.sequence([actionMove, waitSomeTime1]))
                            }
                            self.enumerateChildNodesWithName("pizza3") {
                                node, stop in
                                node.runAction(SKAction.sequence([actionMove, waitSomeTime1]), completion: { () -> Void in
                                    self.addSubtractDivision()
                                    self.runAction(SKAction.playSoundFileNamed("divisao4.mp3", waitForCompletion: true))
                                    
                                    self.lineResult.runAction(SKAction.sequence([self.fadeIn]))
                                    self.sign.runAction(SKAction.sequence([self.fadeIn]))
                                    self.enumerateChildNodesWithName("subtraction") {
                                        node, stop in
                                        node.runAction(SKAction.sequence([SKAction.fadeInWithDuration(0.5), waitSomeTime2]), completion: { () -> Void in
                                            self.addRestDivision()
                                            
                                            self.enumerateChildNodesWithName("rest") {
                                                node, stop in
                                                node.runAction(SKAction.sequence([SKAction.fadeInWithDuration(0.5)]), completion: { () -> Void in
                                                    self.userInteractionEnabled = true
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                            touchNumber++
                        }
                    }
                }
            default:
                break
            }
        }
    }
    
    // adiciona o primeiro conjunto de imagens na adicao, subtracao e multiplicacao
    func addImg1(img: SKSpriteNode, name: String) {
        for var i = 0; i < n1; i++ {
            let ex1Img = SKSpriteNode(imageNamed: name)
            ex1Img.name = name
            ex1Img.physicsBody = SKPhysicsBody(rectangleOfSize: ex1Img.frame.size)
            ex1Img.physicsBody!.dynamic = false
            
            var xPos1 = (CGFloat(self.size.width * 1.5) * CGFloat(Double(i) / 13) + CGFloat(self.size.width))
            ex1Img.position = CGPointMake(xPos1, img.position.y)
            ex1Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(ex1Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 5.0)
            ex1Img.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgTouch.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // adiciona o primeiro conjunto de imagens na adicao, subtracao e multiplicacao
    func addImg1Multiplication(img: SKSpriteNode, name: String) {
        for var i = 0; i < n1; i++ {
            let ex1Img = SKSpriteNode(imageNamed: name)
            ex1Img.name = name
            ex1Img.physicsBody = SKPhysicsBody(rectangleOfSize: ex1Img.frame.size)
            ex1Img.physicsBody!.dynamic = false
            
            var xPos1 = (CGFloat(self.size.width * 1.5) * CGFloat(Double(i) / 8) + CGFloat(self.size.width))
            ex1Img.position = CGPointMake(xPos1, img.position.y)
            ex1Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(ex1Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 5.0)
            ex1Img.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgTouch.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // adiciona o segundo conjunto de imagens na adicao e na subtracao
    func addImg2(img: SKSpriteNode, name: String) {
        for var i = 0; i < n2; i++ {
            let ex2Img = SKSpriteNode(imageNamed: name)
            ex2Img.name = name
            ex2Img.physicsBody = SKPhysicsBody(rectangleOfSize: ex2Img.frame.size)
            ex2Img.physicsBody!.dynamic = false
            
            var xPos2 = (CGFloat(self.size.width * 1.5) * CGFloat(Double(i) / 13) + CGFloat(self.size.width))
            ex2Img.position = CGPointMake(xPos2, img.position.y)
            ex2Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(ex2Img)
            
            let actionMove = SKAction.moveBy(CGVector(dx: -self.size.width / 2, dy: 0.0), duration: 5.0)
            ex2Img.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgTouch.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // move o segundo conjunto de imagens na subtracao
    func moveImg2(name: String) {
        self.enumerateChildNodesWithName(name) {
            node, stop in
            let actionMove = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.height * 0.1), duration: 1.5)
            node.runAction(SKAction.sequence([actionMove]), completion: { () -> Void in
                self.imgTouch.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // remove da tela o segundo conjunto de imagens da subtracao
    func removeImg2(name: String) {
        self.enumerateChildNodesWithName(name) {
            node, stop in
            node.runAction(SKAction.sequence([self.fadeOut]))
        }
    }
    
    // adiciona o segundo conjunto de imagens na multiplicacao
    func addImgMultiplication(img: SKNode, imgName: String, img1Name: String, img2Name: String) {
        for var i = 0; i < n2; i++ {
            let ex2Img = SKSpriteNode(imageNamed: imgName)
            ex2Img.name = img1Name
            ex2Img.physicsBody = SKPhysicsBody(rectangleOfSize: ex2Img.frame.size)
            ex2Img.physicsBody!.dynamic = false
            
            ex2Img.position = CGPointMake(img.position.x, img.position.y)
            ex2Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(ex2Img)
            
            let actionMove2 = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.width * 0.15), duration: 2.0)
            ex2Img.runAction(SKAction.sequence([actionMove2]))
            
            let ex3Img = SKSpriteNode(imageNamed: imgName)
            ex3Img.name = img2Name
            ex3Img.physicsBody = SKPhysicsBody(rectangleOfSize: ex3Img.frame.size)
            ex3Img.physicsBody!.dynamic = false
            
            ex3Img.position = CGPointMake(img.position.x, img.position.y)
            ex3Img.size = CGSize(width: size.width * 0.2, height: size.height * 0.1)
            self.addChild(ex3Img)
            
            let actionMove3 = SKAction.moveBy(CGVector(dx: 0.0, dy: -self.size.width * 0.30), duration: 2.0)
            ex3Img.runAction(SKAction.sequence([actionMove3]), completion: { () -> Void in
                self.imgTouch.hidden = false
                self.userInteractionEnabled = true
            })
        }
    }
    
    // adiciona imagem na divisao
    func addImgDivision() {
        let exImgPizza1 = SKSpriteNode(imageNamed: "pizza1")
        exImgPizza1.name = "pizza1"
        exImgPizza1.physicsBody = SKPhysicsBody(rectangleOfSize: exImgPizza1.frame.size)
        exImgPizza1.physicsBody!.dynamic = false
        exImgPizza1.position = CGPointMake(size.width * 0.755, size.height * 0.205)
        exImgPizza1.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exImgPizza1.alpha = 0.0
        self.addChild(exImgPizza1)
        exImgPizza1.runAction(SKAction.sequence([fadeIn]))
        
        let exImgPizza2 = SKSpriteNode(imageNamed: "pizza2")
        exImgPizza2.name = "pizza2"
        exImgPizza2.physicsBody = SKPhysicsBody(rectangleOfSize: exImgPizza2.frame.size)
        exImgPizza2.physicsBody!.dynamic = false
        exImgPizza2.position = CGPointMake(size.width * 0.745, size.height * 0.205)
        exImgPizza2.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exImgPizza2.alpha = 0.0
        self.addChild(exImgPizza2)
        exImgPizza2.runAction(SKAction.sequence([fadeIn]))
        
        let exImgPizza3 = SKSpriteNode(imageNamed: "pizza3")
        exImgPizza3.name = "pizza3"
        exImgPizza3.physicsBody = SKPhysicsBody(rectangleOfSize: exImgPizza3.frame.size)
        exImgPizza3.physicsBody!.dynamic = false
        exImgPizza3.position = CGPointMake(size.width * 0.745, size.height * 0.195)
        exImgPizza3.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exImgPizza3.alpha = 0.0
        self.addChild(exImgPizza3)
        exImgPizza3.runAction(SKAction.sequence([fadeIn]))
        
        let exImgPizza4 = SKSpriteNode(imageNamed: "pizza4")
        exImgPizza4.name = "pizza4"
        exImgPizza4.physicsBody = SKPhysicsBody(rectangleOfSize: exImgPizza4.frame.size)
        exImgPizza4.physicsBody!.dynamic = false
        exImgPizza4.position = CGPointMake(size.width * 0.755, size.height * 0.195)
        exImgPizza4.size = CGSize(width: size.width * 0.30, height: size.height * 0.30)
        exImgPizza4.alpha = 0.0
        self.addChild(exImgPizza4)
        exImgPizza4.runAction(SKAction.sequence([fadeIn]), completion: { () -> Void in
            self.imgTouch.hidden = false
            self.userInteractionEnabled = true
        })
    }
    
    func addSubtractDivision() {
        let subtraction = SKSpriteNode(imageNamed: "4")
        subtraction.name = "subtraction"
        subtraction.position = CGPoint(x: size.width * 0.25, y: size.height * 0.45)
        subtraction.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        subtraction.alpha = 0.0
        addChild(subtraction)
    }
    
    func addRestDivision() {
        let rest = SKSpriteNode(imageNamed: "0")
        rest.name = "rest"
        rest.position = CGPoint(x: size.width * 0.25, y: size.height * 0.20)
        rest.size = CGSize(width: size.width * 0.1, height: size.height * 0.15)
        rest.alpha = 0.0
        addChild(rest)
    }
    
    // pausa o jogo
    func pause() {
        self.view?.paused = true
    }
    
    // animacao do toque
    func touching(object: SKSpriteNode) {
        let toqueNaTela = SKAction.animateWithTextures([
            SKTexture(imageNamed: "toque1"),
            SKTexture(imageNamed: "toque2"),
            ], timePerFrame: 0.5)
        
        let run = SKAction.repeatActionForever(toqueNaTela)
        object.runAction(run, withKey: "touching")
    }
    
    // animacao da vaca
    func animationCow(object: SKNode) {
        let animateCow = SKAction.animateWithTextures([
            SKTexture(imageNamed: "vaca3"),
            SKTexture(imageNamed: "vaca1"),
            SKTexture(imageNamed: "vaca2"),
            SKTexture(imageNamed: "vaca1"),
            ], timePerFrame: 0.3)
        
        let run = SKAction.repeatActionForever(animateCow)
        object.runAction(run, withKey: "animationCow")
    }
    
    // animacao da ovelha
    func animationSheep(object: SKNode) {
        let animateSheep = SKAction.animateWithTextures([
            SKTexture(imageNamed: "ovelha1"),
            SKTexture(imageNamed: "ovelha2"),
            SKTexture(imageNamed: "ovelha1"),
            SKTexture(imageNamed: "ovelha3"),
            ], timePerFrame: 0.3)
        
        let run = SKAction.repeatActionForever(animateSheep)
        object.runAction(run, withKey: "animationSheep")
    }
}