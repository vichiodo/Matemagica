//
//  TutorialViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var adicao: UIButton!
    @IBOutlet weak var subtracao: UIButton!
    @IBOutlet weak var multiplicacao: UIButton!
    @IBOutlet weak var divisao: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tutorial"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        var notification: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.postNotificationName("pauseView", object: self)
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
