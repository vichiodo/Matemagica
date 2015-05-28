//
//  TutorialDetailViewController.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 15/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit
import SpriteKit

class TutorialDetailViewController: UIViewController {
    
    var buttonTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = TutorialGameScene(size: view.bounds.size)
        scene.tag = buttonTag
        let skView:SKView = SKView(frame: self.view.frame)
        scene.vC = self
        self.view.addSubview(skView)
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func voltar(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
