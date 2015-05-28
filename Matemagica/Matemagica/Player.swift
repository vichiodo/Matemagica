//
//  Player.swift
//  Matemagica
//
//  Created by Vivian Chiodo Dias on 16/05/15.
//  Copyright (c) 2015 Vivian Chiodo Dias. All rights reserved.
//

import Foundation
import CoreData

class Player: NSManagedObject {

    @NSManaged var fotoPlayer: NSData
    @NSManaged var nivelPlayer: String
    @NSManaged var nomePlayer: String
    @NSManaged var scorePlayer: String

}
