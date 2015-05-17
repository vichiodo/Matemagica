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
    @IBOutlet weak var resultado: UILabel!
    var pickerData: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operacoes.delegate = self
        operacoes.dataSource = self
        pickerData = ["+", "-", "*", "/"]
        
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
        var n1 = operando1.text.toInt()
        var n2 = operando2.text.toInt()
        
        switch (row) {
        case 0:
            var n = Double(n1!) + Double(n2!)
            resultado.text = "\(n)"
            break;
        case 1:
            var n = Double(n1!) - Double(n2!)
            resultado.text = "\(n)"
            break;
        case 2:
            var n = Double(n1!) * Double(n2!)
            resultado.text = "\(n)"
            break;
        case 3:
            var n = Double(n1!) / Double(n2!)
            resultado.text = "\(n)"
            break;
        default:
            break;
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
