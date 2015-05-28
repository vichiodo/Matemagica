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
    
    let notificacao:NSNotificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        var notification: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.postNotificationName("pauseMulti", object: self)
        notification.postNotificationName("pauseSingle", object: self)
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "singleGame" {
            var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let index = userDef.objectForKey("index") as! Int
            
            if index != -1 {
                return true
            }
            else {
                let alerta: UIAlertController = UIAlertController(title: "Atenção", message: "Cadastre ou selecione um jogador", preferredStyle:.Alert)
                let al1: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: { (ACTION) -> Void in
                    let playerVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("playerView") as! UIViewController
                    self.presentViewController(playerVC, animated: true, completion: nil)
                })
                // adiciona a ação no alertController
                [alerta.addAction(al1)]
                // adiciona o alertController na view
                self.presentViewController(alerta, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}
