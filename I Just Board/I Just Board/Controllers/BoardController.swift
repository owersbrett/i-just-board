//
//  BoardController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

class BoardController: ObservableObject  {
    @Published var board: Board = Board(boardName: "I Just Board", boardDescription: "I Just Board Description")

    func changeBoardName(boardName: String)  {
        self.board.boardName = self.board.boardName;
    }
    func changeBoardDescription(boardDescription: String){
        self.board.boardDescription = self.board.boardDescription;
    }
}
