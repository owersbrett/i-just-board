//
//  BoardListController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

class BoardListController: ObservableObject  {
    @Published var boards: [Board] = []

    func addBoard(boardName: String, boardDescription: String)  {
        let board: Board = Board(boardName: boardName, boardDescription: boardDescription)
        debugPrint("Adding board with name: " + boardName + " and description: " + boardDescription)
        self.boards.append(board)
    }
}
