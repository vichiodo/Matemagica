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
    
    override func viewWillAppear(animated: Bool) {
        var notification: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.postNotificationName("pauseMulti", object: self)
        notification.postNotificationName("pauseSingle", object: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // so realiza a passagem para o jogo single player se ja tiver um player selecionado na tabela
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "singleGame" {
            var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let index = userDef.objectForKey("index") as! Int
            
            if index != -1 {
                return true
            }
            else {
                var alertview = JSSAlertView().show(self, title: "Cadastre ou selecione um jogador", buttonText: "OK")
                alertview.addAction(alertAction)                
                return false
            }
        }
        return true
    }
    
    func alertAction() {
        let playerVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("playerView") as! UIViewController
        self.presentViewController(playerVC, animated: true, completion: nil)
    }
}
