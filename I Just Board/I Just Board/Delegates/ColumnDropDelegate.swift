//
//  ColumnDropDelegate.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct ColumnDropDelegate: DropDelegate {
    let column: BoardColumn
    let boardController: BoardController
    let onColumnDropped: (BoardColumn, Int) -> Void

    func validateDrop(info: DropInfo) -> Bool {
        return info.hasItemsConforming(to: [UTType.text])
    }

    func performDrop(info: DropInfo) -> Bool {
        guard let itemProvider = info.itemProviders(for: [UTType.text]).first else {
            return false
        }

        itemProvider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (item, error) in
            DispatchQueue.main.async {
                if let data = item as? Data, let droppedID = String(data: data, encoding: .utf8) {
                    if let droppedColumn = boardController.board?.boardColumns.first(where: { $0.id.uuidString == droppedID }) {
                        // Handle dropping a column
                        onColumnDropped(droppedColumn, column.index)
                    } else if let droppedCard = boardController.board?.boardColumns.flatMap({ $0.cards }).first(where: { $0.id.uuidString == droppedID }) {
                        // Handle dropping a card from any column
                        if let sourceColumn = boardController.board?.boardColumns.first(where: { $0.cards.contains(where: { $0.id.uuidString == droppedID }) }) {
                            // Find the source and target column indices
                            if let sourceColumnIndex = boardController.board?.boardColumns.firstIndex(where: { $0.id == sourceColumn.id }),
                               let targetColumnIndex = boardController.board?.boardColumns.firstIndex(where: { $0.id == column.id }) {
                                // Call moveCard function
                                boardController.moveCard(cardId: droppedCard.id, toColumnId: column.id, toCardIndex: column.cards.count)
                            }
                            
                        }
                    }
                }
            }
        }

        return true
    }
}
