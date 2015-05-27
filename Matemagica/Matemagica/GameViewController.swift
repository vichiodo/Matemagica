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

//    var viewPerfil = UIStoryboard(name: "main", bundle: nil).instantiateViewControllerWithIdentifier("playerView")
    
    let notificacao:NSNotificationCenter = NSNotificationCenter.defaultCenter()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        var notification: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.postNotificationName("pauseView", object: self)
    }

    @IBAction func jogoSingle(sender: AnyObject) {
        let singleScene = SingleGameScene(size: view.bounds.size)
        singleScene.scaleMode = .ResizeFill
        let skView:SKView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        skView.presentScene(singleScene)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func voltar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
