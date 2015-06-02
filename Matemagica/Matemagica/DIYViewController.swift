//
//  DIYViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class DIYViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var operations: UIPickerView!
    @IBOutlet weak var operating1: UITextField!
    @IBOutlet weak var operating2: UITextField!
    @IBOutlet weak var userResult: UITextField!
    
    @IBOutlet weak var quotient: UITextField!
    @IBOutlet weak var rest: UITextField!
    
    @IBOutlet weak var result: UILabel!
    var pickerData: NSArray = NSArray()
    var operationSelectd: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operations.delegate = self
        operations.dataSource = self
        
        userResult.hidden = false
        quotient.hidden = true
        rest.hidden = true
        
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
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userResult.text = ""
        quotient.text = ""
        rest.text = ""
        result.text = "Resultado"
        result.textColor = UIColor.blackColor()
        
        switch (row) {
        case 0:
            operationSelectd = 0
            userResult.hidden = false
            quotient.hidden = true
            rest.hidden = true
        case 1:
            operationSelectd = 1
            userResult.hidden = false
            quotient.hidden = true
            rest.hidden = true
        case 2:
            operationSelectd = 2
            userResult.hidden = false
            quotient.hidden = true
            rest.hidden = true
        case 3:
            operationSelectd = 3
            userResult.hidden = true
            quotient.hidden = false
            rest.hidden = false
            
        default:
            break;
        }
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

    
}
