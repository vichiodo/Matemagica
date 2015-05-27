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
        
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        CGPathMoveToPoint(ref, nil, 0, size.height/2)
        CGPathAddLineToPoint(ref, nil, size.width, size.height/2)
        
        line.path = ref
        line.lineWidth = 4
        line.fillColor = UIColor.blackColor()
        line.strokeColor = UIColor.blackColor()
        
        self.addChild(line)
        
        
        addConta()
        posicaoAlternativas()
        
    }
    
    func addConta(){
        
        switch operacao {
        case 0: // operação +
            let veioDaConta = obterOperacoes("+")
            resposta = veioDaConta.resultado
            conta.text = veioDaConta.operacao
            conta2.text = conta.text

        case 1: // operação -
            let veioDaConta = obterOperacoes("-")
            resposta = veioDaConta.resultado
            conta.text = veioDaConta.operacao
            conta2.text = conta.text
        case 2: // operação *
            let veioDaConta = obterOperacoes("*")
            resposta = veioDaConta.resultado
            conta.text = veioDaConta.operacao
            conta2.text = conta.text

        default: // operação /
            let veioDaConta = obterOperacoes("/")
            resposta = veioDaConta.resultado
            conta.text = veioDaConta.operacao
            conta2.text = conta.text
        }
        
        
        for var i = 0; i < 2; ++i{

            if i == 0{
                conta.position = CGPoint(x: size.width/2, y: size.height/2+120)
                conta.fontColor = UIColor.blackColor()
                conta.zRotation = CGFloat(M_1_PI*9.85)
                conta.fontSize = 120
                conta.name = "conta\(i+1)"
            }
            else{
                conta2.position = CGPoint(x: size.width/2, y: size.height/2-120)
                conta2.fontColor = UIColor.blackColor()
                conta2.fontSize = 120
                conta2.name = "conta\(i+1)"
            }
            
        }
        self.addChild(conta)
        self.addChild(conta2)
    }
    
    func addAlternativas(){
        
        posicao = random(0, 3)
        var num1 = 0
        var num2 = 0
        var num3 = 0
        var num4 = 0
        
        alternativa11.name = "errado"
        alternativa12.name = "errado"
        alternativa13.name = "errado"
        alternativa14.name = "errado"
        alternativa21.name = "errado"
        alternativa22.name = "errado"
        alternativa23.name = "errado"
        alternativa24.name = "errado"


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
            
            num4 = random(resposta + 1, resposta + 20)
            if num4 == resposta || num2 == num4 || num3 == num4{
                num4++
            }
        
            
            alternativa11.text = "\(resposta)"
            alternativa12.text = "\(num2)"
            alternativa13.text = "\(num3)"
            alternativa14.text = "\(num4)"
            alternativa21.text = "\(resposta)"
            alternativa22.text = "\(num2)"
            alternativa23.text = "\(num3)"
            alternativa24.text = "\(num4)"
            alternativa11.name = "certa1"
            alternativa21.name = "certa2"
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
            num4 = random(resposta + 1, resposta + 20)
            if num4 == resposta || num1 == num4 || num3 == num4{
                num4++
            }
            
            alternativa11.text = "\(num1)"
            alternativa12.text = "\(resposta)"
            alternativa13.text = "\(num3)"
            alternativa14.text = "\(num4)"
            alternativa21.text = "\(num1)"
            alternativa22.text = "\(resposta)"
            alternativa23.text = "\(num3)"
            alternativa24.text = "\(num4)"
            alternativa12.name = "certa1"
            alternativa22.name = "certa2"

        case 2: // nuvem3
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
            num4 = random(resposta + 1, resposta + 20)
            if num4 == resposta || num2 == num4 || num1 == num4{
                num4++
            }
            
            alternativa11.text = "\(num1)"
            alternativa12.text = "\(num2)"
            alternativa13.text = "\(resposta)"
            alternativa14.text = "\(num4)"
            alternativa21.text = "\(num1)"
            alternativa22.text = "\(num2)"
            alternativa23.text = "\(resposta)"
            alternativa24.text = "\(num4)"
            alternativa13.name = "certa1"
            alternativa23.name = "certa2"
            
        default:
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
            num3 = random(resposta + 1, resposta + 20)
            if num3 == resposta || num2 == num3 || num3 == num1{
                num3++
            }

            alternativa11.text = "\(num1)"
            alternativa12.text = "\(num2)"
            alternativa13.text = "\(num3)"
            alternativa14.text = "\(resposta)"
            alternativa21.text = "\(num1)"
            alternativa22.text = "\(num2)"
            alternativa23.text = "\(num3)"
            alternativa24.text = "\(resposta)"
            alternativa14.name = "certa1"
            alternativa24.name = "certa2"
        }

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        
    }
    
    //obtem as operações de acordo com a String passada e retorna o resultado da operação
    func obterOperacoes(operador: String) -> (resultado: Int, operacao: String) {
        var n1: Int = 0
        var n2: Int = 0
        
        //randons de acordo com os níveis
        n1 = random(0, 50)
        n2 = random(0, 50)
        
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
            n1 = random(1, 10)
            n2 = random(1, 10)
            operacao = " \(n1) × \(n2)"
            
        }else if operador == "/" {
            
            var array = random(0, 9)
            n2 = numeros[array]
            
            do{
                n1 = random(n2, 20)
            }while n1 % n2 != 0
            
            operacao = "\(n1) ÷ \(n2)"
        }
        
        return (resolveOperacao(n1, n2: n2, op: operador), operacao)
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
        
        addAlternativas()

    }
    


}
