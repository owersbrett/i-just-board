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
        return lhs.id.uuidString == rhs.id.uuidString && lhs.name == rhs.name && lhs.description == rhs.description
    }
    
    var id = UUID()
    var name: String
    var description: String    

}
