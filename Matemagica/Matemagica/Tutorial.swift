
//
//  Tutorial.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 19/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import SpriteKit

class Tutorial: SKScene {

    var tag:Int!

    override init(size: CGSize) {
        super.init(size: size)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()

        // declaração da label conta
        var lblTitulo = SKLabelNode()
        lblTitulo.fontName = "Noteworthy-Bold"
        lblTitulo.fontSize = 100
//        lblTitulo.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.2)
        lblTitulo.text = "4dashuidasuiusiadhsuadiu "
        lblTitulo.fontColor = SKColor.blackColor()
        lblTitulo.position = CGPoint(x: size.width/2, y: size.height/2)
        lblTitulo.zPosition = 100000000000

        addChild(lblTitulo)
        println("\(lblTitulo.text)")
        
//        UILabel(frame: CGRectMake(0, 0, self.view!.frame.size.width * 0.8, self.view!.frame.height * 0.2))
//        lblTitulo.adjustsFontSizeToFitWidth = true
//        lblTitulo.font = UIFont(name: "Noteworthy-Bold", size: 100)
//        lblTitulo.textAlignment = NSTextAlignment.Center
//        lblTitulo.center = CGPointMake(self.view!.frame.size.width * 0.5, self.view!.frame.size.height * 0.2)
//        lblTitulo.text = "4 + 5"
//
//        self.scene?.view!.addSubview(lblTitulo)
//
//        // declaração da label conta
//        var lblConta = UILabel(frame: CGRectMake(0, 0, self.view!.frame.size.width * 0.5, self.view!.frame.height * 0.5))
//        lblConta.adjustsFontSizeToFitWidth = true
//        lblConta.numberOfLines = 3
//        lblConta.font = UIFont(name: "Noteworthy-Bold", size: 100)
//        lblConta.textAlignment = NSTextAlignment.Center
//        lblConta.center = CGPointMake(self.view.frame.size.width * 0.25, self.view.frame.size.height * 0.5)
//        self.view.addSubview(lblConta)
//        
        switch tag {
        case 1:
            println("hfahafsuihfuaihiauh")
            println("fooooooiiiiiii =D")
//            self.navigationItem.title = "SOMA"
            lblTitulo.text = "4 + 5"
            var numero1Img: UIImage = UIImage(named: "4")!
            let imageView1 = UIImageView(image: numero1Img)
            imageView1.frame = CGRectMake(self.view!.frame.size.width * 0.2, self.view!.frame.size.height * 0.35, self.view!.frame.size.width * 0.1, self.view!.frame.size.height * 0.15)
            self.view!.addSubview(imageView1)
            
            var numero2Img: UIImage = UIImage(named: "5")!
            let imageView2 = UIImageView(image: numero2Img)
            imageView2.frame = CGRectMake(self.view!.frame.size.width * 0.2, self.view!.frame.size.height * 0.55, self.view!.frame.size.width * 0.1, self.view!.frame.size.height * 0.15)
            self.view!.addSubview(imageView2)
            
            var numero3Img: UIImage = UIImage(named: "9")!
            let imageView3 = UIImageView(image: numero3Img)
            imageView3.frame = CGRectMake(self.view!.frame.size.width * 0.2, self.view!.frame.size.height * 0.75, self.view!.frame.size.width * 0.1, self.view!.frame.size.height * 0.15)
            self.view!.addSubview(imageView3)
            
//            var dist = 0.1
//            for var i = 0; i < 4; i++ {
//                
//                //                let delayTime3 = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
//                //                dispatch_after(delayTime3, dispatch_get_main_queue()) {
//                var exemplo1Img: UIImage = UIImage(named: "4")!
//                let imageViewEx1 = UIImageView(image: exemplo1Img)
//                imageViewEx1.frame = CGRectMake(self.view.frame.size.width * CGFloat(0.3 + dist), self.view.frame.size.height * 0.35, self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.15)
//                imageViewEx1.alpha = 0.0
//                self.view.addSubview(imageViewEx1)
//                
//                UIView.animateWithDuration(2, animations: { () -> Void in
//                    
//                    imageViewEx1.alpha = 1.0
//                })
//                
//                //                    }
//                dist += 0.1
//            }
            

        default:
            break
        }
//        if tag == 1 {
//        }
//        if buttonTag == 2 {
//            self.navigationItem.title = "SUBTRAÇÃO"
//            lblTitulo.text = "Vamos aprender a subtrair?"
//        }
//        if buttonTag == 3 {
//            self.navigationItem.title = "MULTIPLICAÇÃO"
//            lblTitulo.text = "Vamos aprender a multiplicar?"
//        }
//        if buttonTag == 4 {
//            self.navigationItem.title = "DIVISÃO"
//            lblTitulo.text = "Vamos aprender a dividir?"
//        }

    }
    
    
    
    
}