//
//  PlayerGameViewController.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 27/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class PlayerGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var jogador1: UILabel!
    @IBOutlet weak var jogador2: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSelecione: UILabel!
    
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()
    
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var usuarioSelecionado = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gradiente: CAGradientLayer = CAGradientLayer()
        var cor1: UIColor = UIColor(red: 33/255, green: 73/255, blue: 150/255, alpha: 1)
        var cor2: UIColor = UIColor(red: 33, green: 73, blue: 150, alpha: 1)

        gradiente.colors = [cor1.CGColor, cor2.CGColor]
        gradiente.frame = view.bounds
        view.layer.insertSublayer(gradiente, atIndex: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        userDef.setObject("-1", forKey: "jogador1")
        userDef.setObject("-1", forKey: "jogador2")
        jogador1.text = "Jogador 1"
        jogador2.text = "Jogador 2"
        img1.image = UIImage(named:"imgdefault")
        img2.image = UIImage(named:"imgdefault")
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
        cell.score.text = "Vitórias: \(players[indexPath.row].scorePlayer)"
        cell.nivel.text = "Nível: \(players[indexPath.row].nivelPlayer)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var playerSelecionado = players[indexPath.row]
        
        if usuarioSelecionado == 1 {
            if jogador2.text != "Jogador 2" {
                if indexPath.row != userDef.objectForKey("jogador2") as! Int {
                    userDef.setObject(indexPath.row, forKey: "jogador1")
                    jogador1.text = playerSelecionado.nomePlayer
                    img1.image = UIImage(data: playerSelecionado.fotoPlayer)
                }
                else {
                    lblSelecione.text = "Jogador não pode ser igual!"
                    lblSelecione.textColor = UIColor.redColor()
                }
            }
            else {
                userDef.setObject(indexPath.row, forKey: "jogador1")
                jogador1.text = playerSelecionado.nomePlayer
                img1.image = UIImage(data: playerSelecionado.fotoPlayer)
            }
        }
        else if usuarioSelecionado == 2 {
            if jogador1.text != "Jogador 1" {
                if indexPath.row != userDef.objectForKey("jogador1") as! Int {
                    userDef.setObject(indexPath.row, forKey: "jogador2")
                    jogador2.text = playerSelecionado.nomePlayer
                    img2.image = UIImage(data: playerSelecionado.fotoPlayer)
                }
                else {
                    lblSelecione.text = "Jogador não pode ser igual!"
                    lblSelecione.textColor = UIColor.redColor()
                }
            }
            else {
                userDef.setObject(indexPath.row, forKey: "jogador2")
                jogador2.text = playerSelecionado.nomePlayer
                img2.image = UIImage(data: playerSelecionado.fotoPlayer)
            }
        }
        if jogador1.text != "Jogador 1" && jogador2.text != "Jogador 2" {
            lblSelecione.text = "Vamos jogar?"
            lblSelecione.textColor = UIColor.blueColor()
        }

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInView(self.view)
        
        for obstacleView in self.view.subviews {
            let obstacleViewFrame = self.view.convertRect(obstacleView.frame, toView: obstacleView.superview)
            if (CGRectContainsPoint(obstacleViewFrame, touchLocation)) {
                if obstacleView.tag == 1 {
                    lblSelecione.text = "Escolha o primeiro jogador"
                    lblSelecione.textColor = UIColor.blackColor()
                    usuarioSelecionado = 1
                }
                if obstacleView.tag == 2 {
                    lblSelecione.text = "Escolha o segundo jogador"
                    lblSelecione.textColor = UIColor.blackColor()
                    usuarioSelecionado = 2
                }
            }
        }
    }
    
    @IBAction func voltar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "jogar" {
            if jogador1.text != "Jogador 1" && jogador2.text != "Jogador 2" {
                return true
            }
            else {
                
                var alertview = JSSAlertView().show(self, title: "Escolha dois jogadores", buttonText: "OK", color: UIColorFromHex(0x33cc33, alpha: 1))
                alertview.setTextTheme(.Light)

                
                
                
//                let alerta: UIAlertController = UIAlertController(title: "Atenção", message: "Selecione os jogadores", preferredStyle:.Alert)
//                let al1: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                // adiciona a ação no alertController
//                [alerta.addAction(al1)]
//                
//                // adiciona o alertController na view
//                self.presentViewController(alerta, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
}
