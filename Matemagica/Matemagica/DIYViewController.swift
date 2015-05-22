//
//  DIYViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class DIYViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var operacoes: UIPickerView!
    @IBOutlet weak var operando1: UITextField!
    @IBOutlet weak var operando2: UITextField!
    @IBOutlet weak var resultadoUsuario: UITextField!
    
    @IBOutlet weak var quocienteDivisao: UITextField!
    @IBOutlet weak var restoDivisao: UITextField!
    
    @IBOutlet weak var resultado: UILabel!
    var pickerData: NSArray = NSArray()
    var operacaoSelecionada: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operacoes.delegate = self
        operacoes.dataSource = self
        
        resultadoUsuario.hidden = false
        quocienteDivisao.hidden = true
        restoDivisao.hidden = true
        
        pickerData = ["+", "-", "×", "÷"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        resultadoUsuario.text = ""
        quocienteDivisao.text = ""
        restoDivisao.text = ""
        resultado.text = "Resposta"
        
        switch (row) {
        case 0:
            operacaoSelecionada = 0
            resultadoUsuario.hidden = false
            quocienteDivisao.hidden = true
            restoDivisao.hidden = true
        case 1:
            operacaoSelecionada = 1
            resultadoUsuario.hidden = false
            quocienteDivisao.hidden = true
            restoDivisao.hidden = true
        case 2:
            operacaoSelecionada = 2
            resultadoUsuario.hidden = false
            quocienteDivisao.hidden = true
            restoDivisao.hidden = true
        case 3:
            operacaoSelecionada = 3
            resultadoUsuario.hidden = true
            quocienteDivisao.hidden = false
            restoDivisao.hidden = false
            
        default:
            break;
        }
    }
    
    @IBAction func verificacao(sender: AnyObject) {
        var n1 = operando1.text.toInt()
        var n2 = operando2.text.toInt()
        var respUsuario = resultadoUsuario.text.toInt()
        var respUsuarioQuociente = quocienteDivisao.text.toInt()
        var respUsuarioResto = restoDivisao.text.toInt()
        
        var respConta:Int!
        var respResto:Int!
        
        if n1 != nil && n2 != nil && (respUsuario != nil ||  (respUsuarioResto != nil && respUsuarioQuociente != nil)) {
            switch (operacaoSelecionada) {
            case 0:
                respConta = n1! + n2!
                break;
            case 1:
                respConta = n1! - n2!
                break;
            case 2:
                respConta = n1! * n2!
                break;
            case 3:
                respConta = n1! / n2!
                respResto = n1! % n2!
                break;
            default:
                break;
            }
            
            if operacaoSelecionada == 3 {
                if respUsuarioQuociente == respConta && respUsuarioResto == respResto {
                    resultado.text = "Correto! 😄"
                    resultado.textColor = UIColor.greenColor()
                }
                else {
                    resultado.text = "Errado. O certo é \(respConta) resto \(respResto)"
                    resultado.adjustsFontSizeToFitWidth = true
                    resultado.textColor = UIColor.redColor()
                    
                }

            }
            else {
                if respUsuario == respConta {
                    resultado.text = "Correto! 😄"
                    resultado.textColor = UIColor.greenColor()
                }
                else {
                    resultado.text = "Errado. O certo é \(respConta)"
                    resultado.adjustsFontSizeToFitWidth = true
                    resultado.textColor = UIColor.redColor()
                    
                }
            }
            
            
        }
        else {
            let alerta: UIAlertController = UIAlertController(title: "Atenção", message: "Preencha todos os campos", preferredStyle:.Alert)
            let al1: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            // adiciona a ação no alertController
            [alerta.addAction(al1)]
            
            // adiciona o alertController na view
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    
}
