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
        let scene = Tutorial(size: view.bounds.size)
        scene.tag = buttonTag
        let skView:SKView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        scene.scaleMode = .AspectFill
        scene.vC = self
        skView.presentScene(scene)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
