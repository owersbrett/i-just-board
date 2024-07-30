//
//  Card.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

import SwiftData

struct Card: Identifiable, Codable, Hashable {

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id && 
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.index == rhs.index
    }
    
    var id = UUID()
    var parentId: UUID
    var name: String
    var description: String    
    var index: Int
    
    init(name: String, description: String, index: Int, parentId: UUID) {
        self.id = UUID()
           self.name = name
           self.description = description
           self.index = index
        self.parentId = parentId
       }
    


}
