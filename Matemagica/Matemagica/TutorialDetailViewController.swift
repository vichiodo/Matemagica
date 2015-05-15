//
//  TutorialDetailViewController.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 15/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class TutorialDetailViewController: UIViewController {
    
    var buttonTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // declaração da label conta
        var lblTitulo = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width * 0.8, self.view.frame.height * 0.2))
        lblTitulo.adjustsFontSizeToFitWidth = true
        lblTitulo.font = UIFont(name: "Noteworthy-Bold", size: 100)
        lblTitulo.textAlignment = NSTextAlignment.Center
        lblTitulo.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.2)
        self.view.addSubview(lblTitulo)
        
        // declaração da label conta
        var lblConta = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width * 0.5, self.view.frame.height * 0.5))
        lblConta.adjustsFontSizeToFitWidth = true
        lblConta.numberOfLines = 3
        lblConta.font = UIFont(name: "Noteworthy-Bold", size: 100)
        lblConta.textAlignment = NSTextAlignment.Center
        lblConta.center = CGPointMake(self.view.frame.size.width * 0.25, self.view.frame.size.height * 0.5)
        self.view.addSubview(lblConta)


        if buttonTag == 1 {
            self.navigationItem.title = "SOMA"
            lblTitulo.text = "1 + 3"
            lblConta.text = "  1\n+3\n--"
            
        }
        if buttonTag == 2 {
            self.navigationItem.title = "SUBTRAÇÃO"
            lblTitulo.text = "Vamos aprender a subtrair?"
        }
        if buttonTag == 3 {
            self.navigationItem.title = "MULTIPLICAÇÃO"
            lblTitulo.text = "Vamos aprender a multiplicar?"
        }
        if buttonTag == 4 {
            self.navigationItem.title = "DIVISÃO"
            lblTitulo.text = "Vamos aprender a dividir?"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
