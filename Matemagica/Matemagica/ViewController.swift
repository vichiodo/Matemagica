//
//  ViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jogar: UIButton!
    @IBOutlet weak var tutorial: UIButton!
    @IBOutlet weak var diy: UIButton!
    
    
    @IBOutlet weak var logoM1: UIImageView!
    @IBOutlet weak var logoA1: UIImageView!
    @IBOutlet weak var logoT: UIImageView!
    @IBOutlet weak var logoE: UIImageView!
    @IBOutlet weak var logoM2: UIImageView!
    @IBOutlet weak var logoA2: UIImageView!
    @IBOutlet weak var logoG: UIImageView!
    @IBOutlet weak var logoI: UIImageView!
    @IBOutlet weak var logoC: UIImageView!
    @IBOutlet weak var logoA3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoM1.alpha = 0.0
        logoA1.alpha = 0.0
        logoT.alpha = 0.0
        logoE.alpha = 0.0
        logoM2.alpha = 0.0
        logoA2.alpha = 0.0
        logoG.alpha = 0.0
        logoI.alpha = 0.0
        logoC.alpha = 0.0
        logoA3.alpha = 0.0
        
        
        let delayTime3 = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime3, dispatch_get_main_queue()) {
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.logoM1.transform = CGAffineTransformMakeTranslation(0, 280)
                self.logoM1.alpha = 1.0
                }, completion: { finished in
                    UIView.animateWithDuration(1.5, animations: { () -> Void in
                        self.logoA1.transform = CGAffineTransformMakeTranslation(0, 280)
                        self.logoA1.alpha = 1.0
                        }, completion: { finished in
                            UIView.animateWithDuration(1.5, animations: { () -> Void in
                                self.logoT.transform = CGAffineTransformMakeTranslation(0, 280)
                                self.logoT.alpha = 1.0
                            })
                    })
            })
        }
        
        let delayTime2 = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime2, dispatch_get_main_queue()) {
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.logoM2.transform = CGAffineTransformMakeTranslation(0, 280)
                self.logoM2.alpha = 1.0
                }, completion: { finished in
                    UIView.animateWithDuration(1.5, animations: { () -> Void in
                        self.logoA3.transform = CGAffineTransformMakeTranslation(0, 280)
                        self.logoA3.alpha = 1.0
                        }, completion: { finished in
                            UIView.animateWithDuration(1.5, animations: { () -> Void in
                                self.logoG.transform = CGAffineTransformMakeTranslation(0, 280)
                                self.logoG.alpha = 1.0
                            })
                    })
            })
        }
        
        let delayTime1 = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime1, dispatch_get_main_queue()) {
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.logoE.transform = CGAffineTransformMakeTranslation(0, 280)
                self.logoE.alpha = 1.0
                }, completion: { finished in
                    UIView.animateWithDuration(1.5, animations: { () -> Void in
                        self.logoC.transform = CGAffineTransformMakeTranslation(0, 280)
                        self.logoC.alpha = 1.0
                        }, completion: { finished in
                            UIView.animateWithDuration(1.5, animations: { () -> Void in
                                self.logoI.transform = CGAffineTransformMakeTranslation(0, 280)
                                self.logoI.alpha = 1.0
                                }, completion: { finished in
                                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                                        self.logoA2.alpha = 1.0
                                        self.logoA2.transform = CGAffineTransformMakeScale(1.3, 1.3)
                                        }, completion: { finished in
                                            UIView.animateWithDuration(1.0, animations: { () -> Void in
                                                self.logoA2.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                                
                                            })
                                    })
                            })
                    })
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

