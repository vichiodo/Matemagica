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
    
    let imagePicker:UIImagePickerController = UIImagePickerController()
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    lazy var players:Array<Player> = {
        return PlayerManager.instance.buscarPlayers()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnES.possibleTitles = Set(["Editar", "Salvar"])
        nome.userInteractionEnabled = false
        foto.userInteractionEnabled = false
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        var playerSelecionado = players[userDef.integerForKey("index")]
        
        nome.text = playerSelecionado.nomePlayer
        foto.image = UIImage(data: playerSelecionado.fotoPlayer)

    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        var index = userDef.objectForKey("index") as? Int
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: index!, inSection: 0)
        if index != nil {
            tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func adicionarPlayer(sender: AnyObject) {
        btnES.title = "Salvar"
        nome.text = ""
        foto.image = nil
        
        nome.userInteractionEnabled = true
        foto.userInteractionEnabled = true
    }
    
    @IBAction func salvar(sender: AnyObject) {
        if nome.text == "" {
            let alerta: UIAlertController = UIAlertController(title: "Atenção", message: "Digite um nome", preferredStyle:.Alert)
            let al1: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            // adiciona a ação no alertController
            [alerta.addAction(al1)]
            
            // adiciona o alertController na view
            self.presentViewController(alerta, animated: true, completion: nil)
        }
        else {
            if foto.image == nil {
                let alerta: UIAlertController = UIAlertController(title: "Escolha uma foto", message: nil, preferredStyle: .ActionSheet)
                alerta.popoverPresentationController?.sourceView = self.view
                alerta.popoverPresentationController?.sourceRect = CGRectMake(self.view.frame.width / 2, self.view.frame.height / 2, 0, 0)
                let camera:UIAlertAction = UIAlertAction(title: "Tirar foto", style: .Default, handler: { (ACTION) -> Void in
                    let imagePicker:UIImagePickerController = UIImagePickerController()
                    if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                        self.imagePicker.sourceType = .Camera
                        self.presentViewController(self.imagePicker, animated: true, completion: nil)
                    }
                })
                [alerta.addAction(camera)]
                
                let galeria:UIAlertAction = UIAlertAction(title: "Escolher da galeria", style: .Default, handler: { (ACTION) -> Void in
                    self.imagePicker.sourceType = .PhotoLibrary
                    self.presentViewController(self.imagePicker, animated: true, completion: nil)
                })
                [alerta.addAction(galeria)]
                
                self.presentViewController(alerta, animated: true, completion: nil)
            }
            else {
                salvarBanco(nome.text, foto: foto.image!)
                players = PlayerManager.instance.buscarPlayers()
                self.tableView.reloadData()
                
                nome.userInteractionEnabled = false
                nome.text = ""
                foto.userInteractionEnabled = false
                
                btnES.title = "Editar"
                
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("player", forIndexPath: indexPath) as! PlayerTableViewCell
        
        cell.nome.text = players[indexPath.row].nomePlayer
        cell.foto.image = UIImage(data:players[indexPath.row].fotoPlayer)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            PlayerManager.instance.removerJogador(indexPath.row)
            players = PlayerManager.instance.buscarPlayers()
            if indexPath.row < (userDef.objectForKey("index") as! Int){
                userDef.setObject((userDef.objectForKey("index") as! Int)-1, forKey: "index")
            }
        }
        
        self.tableView.reloadData()
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
                        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                            self.imagePicker.sourceType = .Camera
                            self.presentViewController(self.imagePicker, animated: true, completion: nil)
                        }
                    })
                    [alerta.addAction(camera)]
                    
                    let galeria:UIAlertAction = UIAlertAction(title: "Escolher da galeria", style: .Default, handler: { (ACTION) -> Void in
                        self.imagePicker.sourceType = .PhotoLibrary
                        self.presentViewController(self.imagePicker, animated: true, completion: nil)
                    })
                    [alerta.addAction(galeria)]
                    
                    self.presentViewController(alerta, animated: true, completion: nil)
                }
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var imagem:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        foto.image = imagem
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func salvarBanco(nome: String, foto: UIImage){
        let player = PlayerManager.instance.novoPlayer()
        let imagem = UIImageJPEGRepresentation(foto, 1)
        
        player.setValue(nome, forKey: "nomePlayer")
        player.setValue(imagem, forKey: "fotoPlayer")
        
        PlayerManager.instance.salvarPlayer()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var playerSelecionado = players[indexPath.row]
        userDef.setObject(indexPath.row, forKey: "index")
        
        nome.text = playerSelecionado.nomePlayer
        foto.image = UIImage(data: playerSelecionado.fotoPlayer)
        
    }
}
