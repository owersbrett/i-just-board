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
    
    func applyTemplate(to: Board, template: [String], templateName: String){
    
        var newColumns: [BoardColumn] = []
                  for (index, name) in template.enumerated() {
                      newColumns.append(BoardColumn(name: name, description: "", cards: [], index: index))
                  }
              
        var board: Board = Board(name: templateName, description: "", boardColumns: newColumns, index: to.index)
        insertBoardAtIndex(boardToInsert: board, at: to.index)
    }
    
    func insertBoardAtIndex(boardToInsert: Board, at index: Int) {
        debugPrint("Inserting board at index...")

        // Update the index of the board to be inserted
        var newBoard = boardToInsert
        var newIndex = index
        
        if (newIndex >= boards.count){
            newIndex -= 1
        }
        newBoard.index = newIndex
        newBoard.id = UUID()

        boards.insert(newBoard, at: newIndex)

        // Update the indices of all subsequent boards
        for i in (newIndex + 1)..<boards.count {
            boards[i].index = i
        }

    }

    
    func deleteBoards(){
        debugPrint("Don't delete board...!")
//        self.boards = []
    }
    func deleteBoard(boardToDelete: Board){
        self.boards.removeAll(where: {return $0 == boardToDelete})
    }
    
    func                                                                             addBoard(boardName: String, boardDescription: String)  {
        let board: Board = Board(name: boardName, description: boardDescription, boardColumns: [], index: boards.count + 1)
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
    

    
    
    func updateBoards(boards: [Board]) {
        self.boards = boards
    }
}
