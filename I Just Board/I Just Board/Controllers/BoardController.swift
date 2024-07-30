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
        
        board.boardColumns[columnIndex].cards.append(card)
        self.boardListController.updateBoard(updatedBoard: board)

        self.board = board
        
        
    }
    func moveCard(cardId: UUID, toColumnId: UUID) {
        guard var board = self.board else { return }
        
        var updatedColumns = board.boardColumns
        
        // Find the card and its current column
        for (columnIndex, column) in updatedColumns.enumerated() {
            if let cardIndex = column.cards.firstIndex(where: { $0.id == cardId }) {
                let card = updatedColumns[columnIndex].cards.remove(at: cardIndex)
                
                // Find the target column and add the card
                if let targetColumnIndex = updatedColumns.firstIndex(where: { $0.id == toColumnId }) {
                    updatedColumns[targetColumnIndex].cards.append(card)
                    board.boardColumns = updatedColumns
                    self.board = board
                    self.boardListController.updateBoard(updatedBoard: board)

                    return
                }
            }
        }
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
