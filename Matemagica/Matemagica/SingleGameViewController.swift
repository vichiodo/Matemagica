//
//  SingleGameViewController.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 28/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit
import SpriteKit

class SingleGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SingleGameScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill
        let skView:SKView = SKView(frame: self.view.frame)
        scene.vC = self
        self.view.addSubview(skView)
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func voltar() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
