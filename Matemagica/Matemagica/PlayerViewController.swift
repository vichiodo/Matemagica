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
    @IBOutlet weak var txtNamePlayer: UITextField!
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    let imagePicker:UIImagePickerController = UIImagePickerController()
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    // carrega o vetor de usuarios cadastrados no CoreData
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // desabilita o toque
        txtNamePlayer.userInteractionEnabled = false
        imgPlayer.userInteractionEnabled = false
        btnAdd.hidden = false
        btnSave.hidden = true
        btnCancel.hidden = true
        
        // delegate para o imagePicker
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // se ja tiver algum jogador selecionado, carrega as informações
        if userDef.objectForKey("index") != nil && userDef.objectForKey("index") as! Int != -1 {
            var selectedPlayer = players[userDef.integerForKey("index")]
            txtNamePlayer.text = selectedPlayer.nomePlayer
            txtNamePlayer.borderStyle = UITextBorderStyle.None
            imgPlayer.image = UIImage(data: selectedPlayer.fotoPlayer)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        var index = userDef.objectForKey("index") as? Int
        if index != nil && index >= 0 {
            let rowToSelect:NSIndexPath = NSIndexPath(forRow: index!, inSection: 0)
            tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addNewPlayer(sender: AnyObject) {
        // quando clicado, habilita a edição
        if btnAdd.tag == 1 {
            btnCancel.hidden = false
            btnAdd.hidden = true
            btnSave.hidden = false
            
            txtNamePlayer.text = ""
            txtNamePlayer.borderStyle = UITextBorderStyle.RoundedRect
            imgPlayer.image = UIImage(named: "imgdefault")
            
            txtNamePlayer.userInteractionEnabled = true
            imgPlayer.userInteractionEnabled = true
            tableView.allowsSelection = false
            txtNamePlayer.becomeFirstResponder()
            btnAdd.tag = 0
        }
            
        else if btnAdd.tag == 0 {
            // só salva player novo no CoreData se tiver cadastrado nome e imagem
            if txtNamePlayer.text == "" {
                var alertview = JSSAlertView().show(self, title: "Digite um nome", buttonText: "OK")
                txtNamePlayer.becomeFirstResponder()
            }
            else {
                if imgPlayer.image == UIImage(named: "imgdefault") {
                 }
                else { // se estiver com nome e foto, salva os dados
                    btnCancel.hidden = true
                    btnAdd.tag = 1
                    PlayerManager.sharedInstance.salvarNovoPlayer(txtNamePlayer.text, foto: imgPlayer.image!)
                    players = PlayerManager.sharedInstance.buscarPlayers()
                    self.tableView.reloadData()
                    
                    txtNamePlayer.userInteractionEnabled = false
                    imgPlayer.userInteractionEnabled = false
                    tableView.allowsSelection = true
                    
                    var index = players.count - 1
                    var playerSelecionado = players[index]
                    userDef.setObject(index, forKey: "index")
                    
                    txtNamePlayer.text = playerSelecionado.nomePlayer
                    txtNamePlayer.borderStyle = UITextBorderStyle.None
                    imgPlayer.image = UIImage(data: playerSelecionado.fotoPlayer)
                    let rowToSelect:NSIndexPath = NSIndexPath(forRow: index, inSection: 0)
                    tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
                    

                }
                btnAdd.hidden = false
                btnSave.hidden = true

            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if userDef.objectForKey("index") != nil && userDef.objectForKey("index") as! Int != -1 {
            var selectedPlayer = players[userDef.integerForKey("index")]
            txtNamePlayer.text = selectedPlayer.nomePlayer
            imgPlayer.image = UIImage(data: selectedPlayer.fotoPlayer)
        }
        else {
            txtNamePlayer.text = ""
            imgPlayer.image = UIImage(named: "imgdefault")
        }
        
        txtNamePlayer.userInteractionEnabled = false
        txtNamePlayer.borderStyle = UITextBorderStyle.None
        imgPlayer.userInteractionEnabled = false
        tableView.allowsSelection = true
        btnAdd.tag = 1
        btnCancel.hidden = true
        btnAdd.hidden = false
        btnSave.hidden = true

    }
    
    // MARK: - TableView

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
        cell.score.text = "Vitórias: \(players[indexPath.row].scorePlayer)"
        cell.nivel.text = "Nível: \(players[indexPath.row].nivelPlayer)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            PlayerManager.sharedInstance.removerJogador(indexPath.row)
            players = PlayerManager.sharedInstance.buscarPlayers()
            if indexPath.row == 0 {
                userDef.setObject(-1, forKey: "index")
            }
            else {
                if indexPath.row < (userDef.objectForKey("index") as! Int) {
                    userDef.setObject((userDef.objectForKey("index") as! Int)-1, forKey: "index")
                }
                if indexPath.row == (userDef.objectForKey("index") as! Int) {
                    userDef.setObject(-1, forKey: "index")
                    tableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
            }
        }
        
        if indexPath.row >= 0 {
            tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
        }
        
        if userDef.objectForKey("index") != nil && userDef.objectForKey("index") as! Int != -1 {
            var selectedPlayer = players[userDef.integerForKey("index")]
            txtNamePlayer.text = selectedPlayer.nomePlayer
            imgPlayer.image = UIImage(data: selectedPlayer.fotoPlayer)
        }
        else {
            txtNamePlayer.text = ""
            imgPlayer.image = UIImage(named: "imgdefault")
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
                    if imgPlayer.userInteractionEnabled {
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
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var imagem:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgPlayer.image = imagem
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var playerSelecionado = players[indexPath.row]
        userDef.setObject(indexPath.row, forKey: "index")
        
        txtNamePlayer.text = playerSelecionado.nomePlayer
        imgPlayer.image = UIImage(data: playerSelecionado.fotoPlayer)
        
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
