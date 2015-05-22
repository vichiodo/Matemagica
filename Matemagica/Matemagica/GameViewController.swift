//
//  GameViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var viewPerfil = PlayerViewController()
    let notificacao:NSNotificationCenter = NSNotificationCenter.defaultCenter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func jogoSingle(sender: AnyObject) {
        let singleScene = SingleGameScene(size: view.bounds.size)
        singleScene.scaleMode = .ResizeFill
        let skView:SKView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        skView.presentScene(singleScene)
        
    }
    
    
    @IBAction func jogoMulti(sender: AnyObject) {

        var mensagem:NSDictionary = NSDictionary(object: 1, forKey: "mensagem")

        notificacao.postNotificationName("mudarView", object: self, userInfo: mensagem as? [NSObject : AnyObject])

        self.presentViewController(viewPerfil, animated: true, completion: nil)
        
//        let scene = MultiGameScene(size: view.bounds.size)
//        scene.scaleMode = .ResizeFill
//        let skView:SKView = SKView(frame: self.view.frame)
//        self.view.addSubview(skView)
//        skView.presentScene(scene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
