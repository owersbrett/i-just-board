//
//  ConfirmationController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/31/24.
//

import Foundation

class ConfirmationController: ObservableObject {
    @Published var showAlert = false
    @Published var itemToConfirm: ConfirmableItem?
    @Published var action: ConfirmableAction?
    private let boardController: BoardController?

    init(boardController: BoardController?) {
        self.boardController = boardController
    }
    
    func setShowAlert(showAlert: Bool, itemToConfirm: ConfirmableItem?, action: ConfirmableAction?) {
        self.showAlert = showAlert
        self.itemToConfirm = itemToConfirm
        self.action = action
    }
    
    func getShowAlert() -> Bool {
        return self.showAlert
    }
    
    enum ConfirmableItem {
        case card(Card)
        case column(BoardColumn)
        case board(Board)
        
        func toString() -> String {
            switch self {
            case .board:
                return "Board"
            case .column:
                return "Column"
            case .card:
                return "Card"
            }
        }
    }
    
    func getLabel(specific: Bool) -> String {
        guard let item = self.itemToConfirm else { return "Error" }
        if !specific {
            return item.toString()
        }
        switch item {
        case .card(let card):
            return card.name
        case .column(let column):
            return column.name
        case .board(let board):
            return board.name
        }
    }
    
    enum ConfirmableAction {
        case delete
        case save
    }
    
    func confirmItem() {
        switch action {
        case .delete:
            deleteItem()
        case .save:
            debugPrint("Implement save confirmation")
        default:
            debugPrint("Cannot identify action")
        }
    }
    
    private func deleteItem() {
        guard let item = itemToConfirm else { return }
        debugPrint("Deleting item")
        debugPrint(item.toString())
        switch item {
        case .card(let card):
            debugPrint(card.name)
            boardController?.deleteCard(card: card)
        case .column(let column):
            debugPrint(column.name)
            boardController?.deleteBoardColumn(columnToDelete: column)
        case .board(let board):
            debugPrint(board.name)
            boardController?.deleteBoard(board: board)
        }
        resetConfirmation()
    }
    
    private func resetConfirmation() {
        self.itemToConfirm = nil
        self.action = nil
    }
}
