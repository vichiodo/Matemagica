//
//  MiddleViewController.swift
//  
//
//  Created by Vivian Chiodo Dias on 22/05/15.
//
//

import UIKit
import SpriteKit

class MiddleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MultiGameScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill
        let skView:SKView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        skView.presentScene(scene)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
