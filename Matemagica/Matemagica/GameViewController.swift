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


    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func jogoSingle(sender: AnyObject) {
//        let scene = GameScene(size: view.bounds.size)
//        scene.scaleMode = .ResizeFill
//        let skView:SKView = SKView(frame: self.view.frame)
//        self.view.addSubview(skView)
//        skView.presentScene(scene)
        
    }
    
    
    @IBAction func jogoMulti(sender: AnyObject) {
        let scene = MultiGameScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill
        let skView:SKView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        skView.presentScene(scene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
