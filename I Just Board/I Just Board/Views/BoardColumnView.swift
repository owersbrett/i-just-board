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
    @EnvironmentObject var windowSize: WindowSize
    @EnvironmentObject var confirmationController: ConfirmationController
    
    
    @Binding var column: BoardColumn
    let onSelectCard: (Card) -> Void
    let onColumnDropped: (BoardColumn, Int) -> Void
    
    var body: some View {
        VStack {
            HStack{
            EditableTextField(text: $column.name, onSubmit: {
                updatedText in
                var updatedColumn = column
                updatedColumn.name = updatedText
                boardController.updateColumn(updatedColumn)
            })
//                Text(column.name)
                
            }
            
            
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    
                    
                    ForEach(column.cards.sorted(by: {$0.index < $1.index}), id: \.id) { card in
                        CardView(card: card)
                            .onTapGesture {
                                onSelectCard(card)
                            }
                        
                            .onDrag {
                                NSItemProvider(object: card.id.uuidString as NSString)
                            }
                            .contextMenu{
                                Button(action: {
                                    confirmationController.setShowAlert(showAlert: true, itemToConfirm: .card(card), action: .delete)
                                    
                                    
                                }){
                                    Text("Delete Card: " + (card.name))
                                }
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
                        .frame(width: windowSize.size.width * 0.15, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(24)
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
            
            
        }.frame(alignment: .leading)
            .background(Color.black)
            .cornerRadius(16)
            .shadow(radius: 2)
            .onDrag {
                NSItemProvider(object: column.id.uuidString as NSString)
            }
            .onDrop(of: [UTType.text], delegate: ColumnDropDelegate(column: column, boardController: boardController, onColumnDropped: onColumnDropped))
        
    }
    
}
