
//  File.swift
//  Matemagica
//
//  Created by Patricia de Abreu on 27/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit


class Contas {
    var conta: String!
    var alternativa1: Int!
    var alternativa2: Int!
    var alternativa3: Int!
    var resposta: Int!
    
    var numeros: Array<Int> = [1,2,3,4,5,6,7,8,9,10]
    
    init(operacao: String){
        obterOperacoes(operacao)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        conta = operacao
        
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
        
        resposta = resultado
        addAlternativas()
        return resultado
    }
    
    func addAlternativas(){

        var num1 = 0
        var num2 = 0
        var num3 = 0
        
        num1 = random(resposta - 20, resposta - 1)
        num2 = random(resposta + 1, resposta + 20)
        num3 = random(resposta + 3, resposta + 24)
        
        if num1 < 0 {
            num1 = num1 * (-1) + 2
        }
        if num1 == resposta || num1 == num2 {
            num1++
        }
        if num2 == resposta || num2 == num3 {
            num2++
        }
        if num3 == resposta || num3 == num1 {
            num3++
        }
        
        alternativa1 = num1
        alternativa2 = num2
        alternativa3 = num3
        
    }
}