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
                if let data = item as? Data, let droppedID = String(data: data, encoding: .utf8), let droppedColumn = boardController.board?.boardColumns.first(where: { $0.id.uuidString == droppedID }) {
                    onColumnDropped(droppedColumn, column.index)
                }
            }
        }

        return true
    }
}
