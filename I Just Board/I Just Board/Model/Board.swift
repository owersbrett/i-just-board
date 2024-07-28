//
//  Board.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftData

@Model
final class Board {
    var createDate: Date
    var updateDate: Date
    var boardName: String
    var boardDescription: String
    
    
    init(boardName: String, boardDescription: String) {
        self.createDate = Date()
        self.updateDate = Date()
        self.boardName = boardName
        self.boardDescription = boardDescription
    }
}
