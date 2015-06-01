//
//  PlayerGameViewController.swift
//  Matemagica
//
//  Created by Ricardo Hochman on 27/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import UIKit

class PlayerGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var namePlayer1: UILabel!
    @IBOutlet weak var namePlayer2: UILabel!
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSelected: UILabel!
    
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()
    
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var userSelected = 0
    
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
        namePlayer1.text = "Jogador 1"
        namePlayer2.text = "Jogador 2"
        imgPlayer1.image = UIImage(named:"imgdefault")
        imgPlayer2.image = UIImage(named:"imgdefault")
        
        tableView.reloadData()
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
        
        if userSelected == 1 {
            if namePlayer2.text != "Jogador 2" {
                if indexPath.row != userDef.objectForKey("jogador2") as! Int {
                    userDef.setObject(indexPath.row, forKey: "jogador1")
                    namePlayer1.text = playerSelecionado.nomePlayer
                    imgPlayer1.image = UIImage(data: playerSelecionado.fotoPlayer)
                }
                else {
                    lblSelected.text = "Jogador não pode ser igual!"
                    lblSelected.textColor = UIColor.redColor()
                }
            }
            else {
                userDef.setObject(indexPath.row, forKey: "jogador1")
                namePlayer1.text = playerSelecionado.nomePlayer
                imgPlayer1.image = UIImage(data: playerSelecionado.fotoPlayer)
            }
        }
        else if userSelected == 2 {
            if namePlayer1.text != "Jogador 1" {
                if indexPath.row != userDef.objectForKey("jogador1") as! Int {
                    userDef.setObject(indexPath.row, forKey: "jogador2")
                    namePlayer2.text = playerSelecionado.nomePlayer
                    imgPlayer2.image = UIImage(data: playerSelecionado.fotoPlayer)
                }
                else {
                    lblSelected.text = "Jogador não pode ser igual!"
                    lblSelected.textColor = UIColor.redColor()
                }
            }
            else {
                userDef.setObject(indexPath.row, forKey: "jogador2")
                namePlayer2.text = playerSelecionado.nomePlayer
                imgPlayer2.image = UIImage(data: playerSelecionado.fotoPlayer)
            }
        }
        if namePlayer1.text != "Jogador 1" && namePlayer2.text != "Jogador 2" {
            lblSelected.text = "Vamos jogar?"
            lblSelected.textColor = UIColor.blueColor()
        }

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInView(self.view)
        
        for obstacleView in self.view.subviews {
            let obstacleViewFrame = self.view.convertRect(obstacleView.frame, toView: obstacleView.superview)
            if (CGRectContainsPoint(obstacleViewFrame, touchLocation)) {
                if obstacleView.tag == 1 {
                    lblSelected.text = "Escolha o primeiro jogador"
                    lblSelected.textColor = UIColor.blackColor()
                    userSelected = 1
                }
                if obstacleView.tag == 2 {
                    lblSelected.text = "Escolha o segundo jogador"
                    lblSelected.textColor = UIColor.blackColor()
                    userSelected = 2
                }
            }
        }
    }
    
    @IBAction func voltar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "jogar" {
            if namePlayer1.text != "Jogador 1" && namePlayer2.text != "Jogador 2" {
                return true
            }
            else {
                
                var alertview = JSSAlertView().show(self, title: "Escolha dois jogadores", buttonText: "OK", color: UIColorFromHex(0x33cc33, alpha: 1))
                alertview.setTextTheme(.Light)

                return false
            }
        }
        return true
    }
    
}
