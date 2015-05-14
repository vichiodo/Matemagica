//
//  Player.swift
//  
//
//  Created by Vivian Chiodo Dias on 14/05/15.
//
//

import Foundation
import CoreData

class Player: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var foto: String
    @NSManaged var nivel: NSNumber
    @NSManaged var score: NSNumber

}
