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
    
    lazy var players:Array<Player> = {
        return PlayerManager.sharedInstance.buscarPlayers()
        }()
    
    var userDef: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var playerSelecionado = players[indexPath.row]
        userDef.setObject(indexPath.row, forKey: "jogador1")
        userDef.setObject(indexPath.row, forKey: "jogador2")

        
        jogador1.text = playerSelecionado.nomePlayer
        img1.image = UIImage(data: playerSelecionado.fotoPlayer)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let touchLocation = touch.locationInView(self.view)
        
        

    }
    
    @IBAction func voltar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
