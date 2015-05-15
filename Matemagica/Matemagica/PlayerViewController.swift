//
//  PlayerViewController.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var btnES: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnES.possibleTitles = Set(["Editar", "Salvar"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func adicionarPlayer(sender: AnyObject) {
        btnES.title = "Salvar"
    }
    
    @IBAction func salvar(sender: AnyObject) {
        
        
        
        
        btnES.title = "Editar"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("player", forIndexPath: indexPath) as! PlayerTableViewCell
        
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
        }
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInView(self.view)
        
        for ponto in self.view.subviews{
            let pontoFrame = self.view.convertRect(ponto.frame, toView: ponto.superview)
            if CGRectContainsPoint(pontoFrame, touchLocation){
                if ponto.tag == 1 {
                    let alerta: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
                    alerta.popoverPresentationController?.sourceView = self.view
                    alerta.popoverPresentationController?.sourceRect = CGRectMake(touchLocation.x, touchLocation.y, 0, 0)
                    let camera:UIAlertAction = UIAlertAction(title: "Tirar foto", style: .Default, handler: { (ACTION) -> Void in
                        let imagePicker:UIImagePickerController = UIImagePickerController()
                        imagePicker.sourceType = .Camera
                        imagePicker.delegate = self
                        imagePicker.allowsEditing = true
                        
                        
                        self.presentViewController(imagePicker, animated: true, completion: nil)

                        println("teste")
                    })
                    [alerta.addAction(camera)]
                    
                    
                    self.presentViewController(alerta, animated: true, completion: nil)
                    println("Funciona?")
                }
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var imagem:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        foto.image = imagem
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
