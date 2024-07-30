//
//  BoardColumnView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
struct BoardColumnView: View {
    @EnvironmentObject var boardController: BoardController

    let column: BoardColumn
    let onSelectCard: (Card) -> Void
    let onColumnDropped: (BoardColumn, Int) -> Void

    var body: some View {
        VStack {
            Text(column.name).font(.title)
            Text(column.description).font(.subheadline)

            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    ForEach(column.cards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                onSelectCard(card)
                            }
                            .onDrag {
                                NSItemProvider(object: card.id.uuidString as NSString)
                            }
                    }

                    Button(action: {
                        let card = Card(name: "Card", description: "", index: column.cards.count + 1, parentId: column.id)
                        boardController.addBoardColumnCard(card: card, boardColumnId: column.id)
                    }) {
                        VStack {
                            Image(systemName: "plus")
                            Text("Add Card")
                        }
                        .frame(width: 200, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .onDrop(of: [UTType.text], isTargeted: nil) { providers in
                    providers.first?.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (item, error) in
                        if let data = item as? Data, let uuidString = String(data: data, encoding: .utf8), let cardId = UUID(uuidString: uuidString) {
                            DispatchQueue.main.async {
                                boardController.moveCard(cardId: cardId, toColumnId: column.id)
                            }
                        }
                    }
                    return true
                }
            }
        }
        .onDrag {
            NSItemProvider(object: column.id.uuidString as NSString)
        }
        .onDrop(of: [UTType.text], delegate: ColumnDropDelegate(column: column, boardController: boardController, onColumnDropped: onColumnDropped))
    }
}
