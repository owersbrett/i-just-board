//
//  BoardController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import Combine

class BoardController: ObservableObject  {
    @Published var board: Board?
    private let boardListController: BoardListController
    private var cancellables = Set<AnyCancellable>()
    
    
    init(boardListController: BoardListController) {
        self.boardListController = boardListController
        boardListController.$selectedBoard
            .assign(to: \.board, on: self)
            .store(in: &cancellables)
    }
    
    
    func getColumn(by id: UUID) -> BoardColumn? {
        return board?.boardColumns.first { $0.id == id }
    }
    
    func deleteBoardColumn(columnToDelete: BoardColumn){
        guard var board = board else {return}
        
        board.boardColumns.removeAll(where: {$0.id == columnToDelete.id})
        self.board = board
    }
    
    func deleteBoard(board: Board){
        boardListController.deleteBoard(boardToDelete: board)
    }
    
    func deleteCard(card: Card){
        guard var board = board else {return}
        guard var column = board.boardColumns.first(where: {return $0.id == card.parentId}) else {return }
        guard let columnIndex = board.boardColumns.firstIndex(where: {return $0.id == card.parentId}) else {return }
        guard let cardIndex = column.cards.firstIndex(where: {return $0.id == card.id}) else {return }
        column.cards.remove(at: cardIndex)
        board.boardColumns[columnIndex] = column
        self.board = board
        self.boardListController.updateBoard(updatedBoard: board)
        
        
    }
    func moveColumn(_ column: BoardColumn, toIndex newIndex: Int) {
        guard let board = board else { return }
        guard let oldIndex = board.boardColumns.firstIndex(where: { $0.id == column.id }) else { return }
        guard let actualNewIndex = board.boardColumns.firstIndex(where: {$0.index == newIndex }) else { return }
        var newColumns = board.boardColumns
        
        newColumns = validateColumnIndexes(for: newColumns)
        newColumns.remove(at: oldIndex)
        newColumns.insert(column, at: actualNewIndex)
        
        
        
        // Update indexes
        for (index, _) in newColumns.enumerated() {
            newColumns[index].index = index
        }
        
        self.board?.boardColumns = newColumns
    }
    
    func validateColumnIndexes(for columns: [BoardColumn]) -> [BoardColumn]{
        // Ensure the indices are sequential
        var newColumns: [BoardColumn] = []
        for (index, column) in columns.enumerated() {
            newColumns.append(column)
            newColumns[index].index = index
        }
        
        
        // Update the board columns with validated indices
        return newColumns
    }
    
    
    func addBoardColumn(boardColumn: BoardColumn){
        guard var board = self.board else { return }
        board.boardColumns.append(boardColumn)
        debugPrint(board.boardColumns.count)
        self.boardListController.updateBoard(updatedBoard: board)
        
        self.board = board
    }
    func addBoardColumnCard(card: Card, boardColumnId: UUID) {
        guard var board = self.board else { return }
        guard let columnIndex = board.boardColumns.firstIndex(where: { $0.id == boardColumnId }) else { return }
        
        var boardColumn = board.boardColumns[columnIndex]
        boardColumn.cards.append(card)
        board.boardColumns[columnIndex] = boardColumn
        
        self.boardListController.updateBoard(updatedBoard: board)
        self.board = board
    }
    
    func moveCard(cardId: UUID, toColumnId: UUID, toCardIndex: Int) {
        guard var board = self.board else { return }
        var updatedColumns = board.boardColumns
        var cardToMove: Card?
        var sourceColumnIndex: Int?
        var sourceCardIndex: Int?
        
        // Find the card to move and its current location
        for (columnIndex, column) in updatedColumns.enumerated() {
            if let cardIndex = column.cards.firstIndex(where: { $0.id == cardId }) {
                cardToMove = column.cards[cardIndex]
                sourceColumnIndex = columnIndex
                sourceCardIndex = cardIndex
                break
            }
        }
        
        guard let card = cardToMove, let sourceIndex = sourceColumnIndex, let sourceCardIdx = sourceCardIndex else { return }
        
        if card.parentId != toColumnId {
            // Moving to a different column
            // Remove from previous column
            updatedColumns[sourceIndex].cards.remove(at: sourceCardIdx)
            
            // Insert at new index in the new column
            if let targetColumnIndex = updatedColumns.firstIndex(where: { $0.id == toColumnId }) {
                updatedColumns[targetColumnIndex].cards.insert(card, at: toCardIndex)
                
                // Update card's parent ID
                updatedColumns[targetColumnIndex].cards[toCardIndex].parentId = toColumnId
                
                // Reindex current (new) list
                for (i, _) in updatedColumns[targetColumnIndex].cards.enumerated() {
                    updatedColumns[targetColumnIndex].cards[i].index = i
                }
                
                // Reindex previous list
                for (i, _) in updatedColumns[sourceIndex].cards.enumerated() {
                    updatedColumns[sourceIndex].cards[i].index = i
                }
            }
        } else {
            // Moving within the same column
            // Remove from previous position
            updatedColumns[sourceIndex].cards.remove(at: sourceCardIdx)
            
            // Insert at new index
            let targetColumnIndex = sourceIndex
            let adjustedIndex = toCardIndex > sourceCardIdx ? toCardIndex : toCardIndex
            updatedColumns[targetColumnIndex].cards.insert(card, at: adjustedIndex)
            
            // Reindex the list
            for (i, _) in updatedColumns[targetColumnIndex].cards.enumerated() {
                updatedColumns[targetColumnIndex].cards[i].index = i
            }
        }
        
        board.boardColumns = updatedColumns
        self.board = board
        self.boardListController.updateBoard(updatedBoard: board)
    }


    
    //    can be optimized by passing along the current column
    func updateCard(_ updatedCard: Card) {
        guard var board = self.board else { return }
        
        for (columnIndex, column) in board.boardColumns.enumerated() {
            if let cardIndex = column.cards.firstIndex(where: { $0.id == updatedCard.id }) {
                board.boardColumns[columnIndex].cards[cardIndex] = updatedCard
                self.board = board
                self.boardListController.updateBoard(updatedBoard: board)
                
                return
            }
        }
    }
    func updateColumn(_ updatedColumn: BoardColumn) {
        debugPrint("Updating column: " + updatedColumn.name)
        
        debugPrint("Updating column: " + updatedColumn.description)
        guard var board = self.board else { return }
        if let columnIndex = board.boardColumns.firstIndex(where: { $0.id == updatedColumn.id }){
            board.boardColumns[columnIndex] = updatedColumn
            self.board = board
            self.boardListController.updateBoard(updatedBoard: board)
            
            return
        }
        
    }
    
    func updateBoard(_ updatedBoard: Board) {
        self.board = updatedBoard
        self.boardListController.updateBoard(updatedBoard: updatedBoard)
        return
    }
    
    
    
    
}
