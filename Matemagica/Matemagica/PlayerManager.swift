//
//  PlayerManager.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import CoreData
import UIKit


class PlayerManager{
    static let sharedInstance = PlayerManager()
    static let entityName: String = "Player"
    
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext!
        
        }()
    
    private init(){}
    
    func novoPlayer() ->Player {
        return NSEntityDescription.insertNewObjectForEntityForName(PlayerManager.entityName, inManagedObjectContext: managedContext) as! Player
    }

    
    
    func buscarPlayers() ->Array<Player> {
        
        let buscaRequest = NSFetchRequest(entityName: PlayerManager.entityName)
        var erro: NSError?
        let buscaResultados = managedContext.executeFetchRequest(buscaRequest, error: &erro) as? [NSManagedObject]
        if let resultados = buscaResultados as? [Player] {
            return resultados
        } else {
            println("Não foi possível buscar esse jogador. Erro: \(erro), \(erro!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        return Array<Player>()
    }

    func buscarPlayer(index: Int) -> Player{
        var player: Player = buscarPlayers()[index]
        return player
    }
    
    func salvarPlayer() {
        
        var erro: NSError?
        managedContext.save(&erro)
        
        if let e = erro {
            println("Não foi possível salvar esse jogador. Erro: \(erro), \(erro!.userInfo)")
        }
    }
    
    func removerTodos() {
        var arrayPlay: Array<Player> = buscarPlayers()
        
        for player: Player in arrayPlay {
            managedContext.deleteObject(player)
        }
    }
    
    func removerJogador(index: Int) {
        var arrayPlay: Array<Player> = buscarPlayers()
        managedContext.deleteObject(arrayPlay[index] as NSManagedObject)
        salvarPlayer()
        
    }
    
    func salvarNovoPlayer(nome: String, foto: UIImage){
        let player = novoPlayer()
        let imagem = UIImageJPEGRepresentation(foto, 1)
        
        player.setValue(nome, forKey: "nomePlayer")
        player.setValue(imagem, forKey: "fotoPlayer")
        player.setValue("0", forKey: "nivelPlayer")
        player.setValue("0", forKey: "scorePlayer")
        salvarPlayer()
    }

}
