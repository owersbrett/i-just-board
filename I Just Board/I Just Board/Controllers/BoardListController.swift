//
//  BoardListController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

class BoardListController: ObservableObject  {
    
    @Published var boards: [Board] = [] {
        didSet {
                    saveBoards()
                }
    }
    @Published var selectedBoard: Board?

    
    init() {
        loadBoards()
    }
    
    func addBoard(boardName: String, boardDescription: String)  {
        let board: Board = Board(name: boardName, description: boardDescription, boardColumns: [])
        debugPrint("Adding board with name: " + boardName + " and description: " + boardDescription)
        self.boards.append(board)
    }
    func selectBoard(board: Board){
        selectedBoard = board;
    }
    func updateBoard(updatedBoard: Board){
        if let boardIndex = boards.firstIndex(where: {return $0.id == updatedBoard.id}){
            boards[boardIndex] = updatedBoard;
        }
    }
    
    private func saveBoards() {
        do {
            let data = try JSONEncoder().encode(boards)
            try data.write(to: .boardsFile, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to save boards: \(error.localizedDescription)")
        }
    }

    private func loadBoards() {
        do {
            let data = try Data(contentsOf: .boardsFile)
            boards = try JSONDecoder().decode([Board].self, from: data)
        } catch {
            print("Failed to load boards: \(error.localizedDescription)")
        }
    }
}
