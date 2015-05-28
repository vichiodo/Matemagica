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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        userDef.setObject("-1", forKey: "jogador1")
        userDef.setObject("-1", forKey: "jogador2")
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
                    lblSelecione.text = "Jogador nao pode ser igual!"
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
                    lblSelecione.text = "Jogador nao pode ser igual!"
                }
            }
            else {
                userDef.setObject(indexPath.row, forKey: "jogador2")
                jogador2.text = playerSelecionado.nomePlayer
                img2.image = UIImage(data: playerSelecionado.fotoPlayer)
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInView(self.view)
        
        for obstacleView in self.view.subviews {
            let obstacleViewFrame = self.view.convertRect(obstacleView.frame, toView: obstacleView.superview)
            if (CGRectContainsPoint(obstacleViewFrame, touchLocation)) {
                if obstacleView.tag == 1 {
                    lblSelecione.text = "Selecione o primeiro jogador na tabela"
                    usuarioSelecionado = 1
                }
                if obstacleView.tag == 2 {
                    lblSelecione.text = "Selecione o segundo jogador na tabela"
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
                let alerta: UIAlertController = UIAlertController(title: "Atenção", message: "Selecione os jogadores", preferredStyle:.Alert)
                let al1: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
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
