//
//  TutorialViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        var notification: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.postNotificationName("pauseTutorial", object: self)
    }

    // passa por Segue qual o botao que ele clicou para carregar as infos
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "adicaoIdentifier") {
            var tutorialVC : TutorialDetailViewController = segue.destinationViewController as! TutorialDetailViewController
            tutorialVC.buttonTag = sender!.tag
        }
        
        if (segue.identifier == "subtracaoIdentifier") {
            var tutorialVC : TutorialDetailViewController = segue.destinationViewController as! TutorialDetailViewController
            tutorialVC.buttonTag = sender!.tag
        }
        
        if (segue.identifier == "multiplicacaoIdentifier") {
            var tutorialVC : TutorialDetailViewController = segue.destinationViewController as! TutorialDetailViewController
            tutorialVC.buttonTag = sender!.tag
        }
        
        if (segue.identifier == "divisaoIdentifier") {
            var tutorialVC : TutorialDetailViewController = segue.destinationViewController as! TutorialDetailViewController
            tutorialVC.buttonTag = sender!.tag
        }
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
}
