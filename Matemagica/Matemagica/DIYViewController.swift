//
//  DIYViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class DIYViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var operations: UIPickerView!
    @IBOutlet weak var operating1: UITextField!
    @IBOutlet weak var operating2: UITextField!
    @IBOutlet weak var userResult: UITextField!
    
    @IBOutlet weak var quotient: UITextField!
    @IBOutlet weak var rest: UITextField!
    
    @IBOutlet weak var sinalAdicao: UIImageView!
    @IBOutlet weak var sinalSubtracao: UIImageView!
    @IBOutlet weak var sinalMultiplicacao: UIImageView!
    
    @IBOutlet weak var divisor: UITextField!
    @IBOutlet weak var dividendo: UITextField!
    
    @IBOutlet weak var barra1: UIImageView!
    @IBOutlet weak var barraDivisao: UIImageView!
    
    @IBOutlet weak var result: UILabel!
    var operationSelectd: Int! = 0
    
    @IBOutlet weak var perguntaAcertei: UIButton!
    @IBOutlet weak var resultadoAcertei: UILabel!
    
    @IBOutlet weak var btnAdicao: UIButton!
    @IBOutlet weak var btnMultiplicacao: UIButton!
    @IBOutlet weak var btnSubtracao: UIButton!
    @IBOutlet weak var btnDivisao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operating1.hidden = true
        operating2.hidden = true
        userResult.hidden = true
        quotient.hidden = true
        rest.hidden = true
        
        sinalAdicao.hidden = true
        sinalMultiplicacao.hidden = true
        sinalSubtracao.hidden = true
        
        dividendo.hidden = true
        divisor.hidden = true
        barraDivisao.hidden = true
        barra1.hidden = true
        
        perguntaAcertei.hidden = true
        resultadoAcertei.hidden = true
        
        self.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    @IBAction func verificacao(sender: AnyObject) {
        var n1 = operating1.text.toInt()
        var n2 = operating2.text.toInt()
        var respUsuario = userResult.text.toInt()
        var respUsuarioQuociente = quotient.text.toInt()
        var respUsuarioResto = rest.text.toInt()
        
        var respConta:Int!
        var respResto:Int!
        
        if n1 != nil && n2 != nil && (respUsuario != nil ||  (respUsuarioResto != nil && respUsuarioQuociente != nil)) {
            switch (operationSelectd) {
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
                n1 = divisor.text.toInt()
                n2 = dividendo.text.toInt()
                respConta = n1! / n2!
                respResto = n1! % n2!
                break;
            default:
                break;
            }
            
            if operationSelectd == 3 {
                if respUsuarioQuociente == respConta && respUsuarioResto == respResto {
                    result.text = "Acertou! 😄"
                    result.textColor = UIColor.greenColor()
                }
                else {
                    result.text = "Errado. O certo é \(respConta) resto \(respResto)"
                    result.adjustsFontSizeToFitWidth = true
                    result.textColor = UIColor.redColor()
                }
            }
            else {
                if respUsuario == respConta {
                    result.text = "Acertou! 😄"
                    result.textColor = UIColor.greenColor()
                }
                else {
                    result.text = "Errado. O certo é \(respConta)"
                    result.adjustsFontSizeToFitWidth = true
                    result.textColor = UIColor.redColor()
                }
            }
        }
        else {
            var txtAlert = "Preencha todos os campos:\n\n"
            if n1 == nil {
                txtAlert += " - Primeiro número\n"
            }
            if n2 == nil {
                txtAlert += " - Segundo número\n"
            }
            if operationSelectd == 3 {
                if respUsuarioQuociente == nil {
                    txtAlert += " - Resposta do quociente\n"
                }
                if respUsuarioResto == nil {
                    txtAlert += " - Resposta do resto\n"
                }
            }
            else {
                if respUsuario == nil {
                    txtAlert += " - Sua resposta\n"
                }
            }
            
            let alerta: UIAlertController = UIAlertController(title: "Atenção", message: txtAlert, preferredStyle:.Alert)
            let al1: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            // adiciona a ação no alertController
            [alerta.addAction(al1)]
            
            // adiciona o alertController na view
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    @IBAction func voltar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func adicao(sender: AnyObject) {
        
        if btnAdicao.layer.position.y == 500 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.btnAdicao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnSubtracao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnMultiplicacao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnDivisao.transform = CGAffineTransformMakeTranslation(0, -350)
            })
        }

        operating1.text = ""
        operating2.text = ""
        userResult.text = ""
        result.text = "Resultado"
        result.textColor = UIColor.blackColor()
        operating1.placeholder = "Numero 1"
        operating2.placeholder = "Numero 2"
        userResult.placeholder = "Sua Resposta"
        
        operationSelectd = 0
        
        perguntaAcertei.hidden = false
        resultadoAcertei.hidden = false
        operating1.hidden = false
        operating2.hidden = false
        userResult.hidden = false
        sinalAdicao.hidden = false
        barra1.hidden = false
        sinalSubtracao.hidden = true
        sinalMultiplicacao.hidden = true
        divisor.hidden = true
        dividendo.hidden = true
        barraDivisao.hidden = true
        quotient.hidden = true
        rest.hidden = true
        
    }
    
    @IBAction func subtracao(sender: AnyObject) {
        
        if btnAdicao.layer.position.y == 500 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.btnAdicao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnSubtracao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnMultiplicacao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnDivisao.transform = CGAffineTransformMakeTranslation(0, -350)
            })
        }
        operating1.text = ""
        operating2.text = ""
        userResult.text = ""
        result.text = "Resultado"
        result.textColor = UIColor.blackColor()
        operating1.placeholder = "Numero 1"
        operating2.placeholder = "Numero 2"
        userResult.placeholder = "Sua Resposta"

        operationSelectd = 1
        
        perguntaAcertei.hidden = false
        resultadoAcertei.hidden = false
        operating1.hidden = false
        operating2.hidden = false
        userResult.hidden = false
        sinalSubtracao.hidden = false
        barra1.hidden = false
        sinalAdicao.hidden = true
        sinalMultiplicacao.hidden = true
        divisor.hidden = true
        dividendo.hidden = true
        barraDivisao.hidden = true
        quotient.hidden = true
        rest.hidden = true
    }
    
    @IBAction func multiplicacao(sender: AnyObject) {
        if btnAdicao.layer.position.y == 500 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.btnAdicao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnSubtracao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnMultiplicacao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnDivisao.transform = CGAffineTransformMakeTranslation(0, -350)
            })
        }
        
        operating1.text = ""
        operating2.text = ""
        userResult.text = ""
        result.text = "Resultado"
        result.textColor = UIColor.blackColor()
        operating1.placeholder = "Numero 1"
        operating2.placeholder = "Numero 2"
        userResult.placeholder = "Sua Resposta"

        operationSelectd = 2
        
        perguntaAcertei.hidden = false
        resultadoAcertei.hidden = false
        operating1.hidden = false
        operating2.hidden = false
        userResult.hidden = false
        sinalMultiplicacao.hidden = false
        barra1.hidden = false
        sinalAdicao.hidden = true
        sinalSubtracao.hidden = true
        divisor.hidden = true
        dividendo.hidden = true
        barraDivisao.hidden = true
        quotient.hidden = true
        rest.hidden = true
    }
    
    @IBAction func divisao(sender: AnyObject) {
        if btnAdicao.layer.position.y == 500 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.btnAdicao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnSubtracao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnMultiplicacao.transform = CGAffineTransformMakeTranslation(0, -350)
                self.btnDivisao.transform = CGAffineTransformMakeTranslation(0, -350)
            })
        }
        
        divisor.text = ""
        dividendo.text = ""
        quotient.text = ""
        rest.text = ""
        result.text = "Resultado"
        result.textColor = UIColor.blackColor()
        divisor.placeholder = "Divisor"
        dividendo.placeholder = "Dividendo"
        quotient.placeholder = "Quociente"
        rest.placeholder = "Resto"
        
        operationSelectd = 3
        
        perguntaAcertei.hidden = false
        resultadoAcertei.hidden = false
        divisor.hidden = false
        dividendo.hidden = false
        quotient.hidden = false
        rest.hidden = false
        barraDivisao.hidden = false
        operating1.hidden = true
        operating2.hidden = true
        sinalAdicao.hidden = true
        sinalMultiplicacao.hidden = true
        sinalSubtracao.hidden = true
        userResult.hidden = true
        barra1.hidden = true
    }
}
