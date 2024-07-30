//
//  BoardDropDelegate.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct BoardDropDelegate: DropDelegate {
    let board: Board
    @Binding var boards: [Board]
    let boardListController: BoardListController

    func validateDrop(info: DropInfo) -> Bool {
        return info.hasItemsConforming(to: [UTType.text])
    }

    func performDrop(info: DropInfo) -> Bool {
        guard let itemProvider = info.itemProviders(for: [UTType.text]).first else {
            return false
        }

        itemProvider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (item, error) in
            DispatchQueue.main.async {
                if let data = item as? Data, let uuidString = String(data: data, encoding: .utf8), let droppedBoardID = UUID(uuidString: uuidString), let droppedBoard = self.boards.first(where: { $0.id == droppedBoardID }) {
                    self.reorderBoards(droppedBoard: droppedBoard, targetBoard: self.board)
                }
            }
        }

        return true
    }

    private func reorderBoards(droppedBoard: Board, targetBoard: Board) {
        guard let sourceIndex = boards.firstIndex(of: droppedBoard),
              let destinationIndex = boards.firstIndex(of: targetBoard) else {
            return
        }

        boards.move(fromOffsets: IndexSet(integer: sourceIndex), toOffset: destinationIndex > sourceIndex ? destinationIndex + 1 : destinationIndex)

        // Update the index of boards if necessary
        for (index, board) in boards.enumerated() {
            boards[index].index = index
        }

        // Notify the controller to update the board list
        boardListController.updateBoards(boards: boards)
    }
}
