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
    @EnvironmentObject var themeController: ThemeController
    
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
                        let bindingCard = Binding<Card>(
                            get: {
                                guard let index = column.cards.firstIndex(where: { $0.id == card.id }) else {
                                    return card
                                }
                                return column.cards[index]
                            },
                            set: { newValue in
                                guard let index = column.cards.firstIndex(where: { $0.id == card.id }) else { return }
                                column.cards[index] = newValue
                            }
                        )
                        CardView(card: bindingCard)
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
                            .onDrop(of: [UTType.text], isTargeted: nil) { providers in
                                providers.first?.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (item, error) in
                                    if let data = item as? Data, let uuidString = String(data: data, encoding: .utf8), let cardId = UUID(uuidString: uuidString) {
                                        DispatchQueue.main.async {
                                            boardController.moveCard(cardId: cardId, toColumnId: column.id, toCardIndex: card.index)
                                        }
                                    }
                                }
                                return true
                            }
                    }
                    
                    
                    
                }
                
            }
            //            .cornerRadius(24)
            
            
            Button(action: {
                let card = Card(name: "Card", description: "", index: column.cards.count, parentId: column.id)
                boardController.addBoardColumnCard(card: card, boardColumnId: column.id)
            }) {
                VStack {
                    Image(systemName: "plus").foregroundColor(themeController.currentTheme.addCardFontColor)
                    Text("Add Card").foregroundColor(themeController.currentTheme.addCardFontColor)
                }
                
                
                .frame(width: windowSize.size.width * 0.15, height: 50)
                
                .cornerRadius(0)
            }.background(
                themeController.currentTheme.addCardColor)
        }.frame(alignment: .leading)
            .background(themeController.currentTheme.columnBackgroundColor)
            .cornerRadius(16)
            .shadow(radius: 2)
            .onDrag {
                NSItemProvider(object: column.id.uuidString as NSString)
            }
            .onDrop(of: [UTType.text], delegate: ColumnDropDelegate(column: column, boardController: boardController, onColumnDropped: onColumnDropped))
        
    }
    
}
