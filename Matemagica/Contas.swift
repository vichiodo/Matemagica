
//  File.swift
//  Matemagica
//
//  Created by Patricia de Abreu on 27/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit


class Contas {
    var account: String!
    var alternative1: Int!
    var alternative2: Int!
    var alternative3: Int!
    var answer: Int!
    
    var numbers: Array<Int> = [1,2,3,4,5,6,7,8,9,10]
    
    init(operacao: String){
        getOperator(operacao)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //obtem as operações de acordo com a String passada e retorna o resultado da operação
    func getOperator(operador: String) -> (result: Int, operation: String) {
        var n1: Int = 0
        var n2: Int = 0
        
        //randons de acordo com os níveis
        n1 = random(0, 50)
        n2 = random(0, 50)
        
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
        
        account = operation
        
        return (solveOperation(n1, n2: n2, op: operador), operation)
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
        
        answer = result
        addAlternatives()
        return result
    }
    
    func addAlternatives(){

        var num1 = 0
        var num2 = 0
        var num3 = 0
        
        num1 = random(answer - 20, answer - 1)
        num2 = random(answer + 1, answer + 20)
        num3 = random(answer + 3, answer + 24)
        
        if num1 < 0 {
            num1 = num1 * (-1) + 2
        }
        if num1 == answer || num1 == num2 {
            num1++
        }
        if num2 == answer || num2 == num3 {
            num2++
        }
        if num3 == answer || num3 == num1 {
            num3++
        }
        
        alternative1 = num1
        alternative2 = num2
        alternative3 = num3
        
    }
}