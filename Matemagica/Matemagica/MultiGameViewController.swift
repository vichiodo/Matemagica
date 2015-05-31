//
//  MiddleViewController.swift
//
//
//  Created by Vivian Chiodo Dias on 22/05/15.
//
//

import UIKit
import SpriteKit

class MultiGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MultiGameScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill
        let skView:SKView = SKView(frame: self.view.frame)
        scene.vC = self
        self.view.addSubview(skView)
        skView.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
