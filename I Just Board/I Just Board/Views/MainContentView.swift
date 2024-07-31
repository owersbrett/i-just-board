//
//  MainContentView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//
//
import Foundation
import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var boardController: BoardController
    @EnvironmentObject var confirmationController: ConfirmationController
    
    
    var body: some View {
        VStack {
            if let board = boardController.board {
                VStack {
                    VStack {
                        Text(board.name).font(.title)
                        if (!board.description.isEmpty){
                            Text(board.description).font(.subheadline)
                        }
                    }.padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black)).padding()
                    
                    
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(board.boardColumns.sorted(by: { $0.index < $1.index }), id: \.id) { column in
                                let bindingColumn = Binding<BoardColumn>(
                                                                 get: {
                                                                     guard let index = board.boardColumns.firstIndex(where: { $0.id == column.id }) else {
                                                                         return column
                                                                     }
                                                                     return boardController.board?.boardColumns[index] ?? column
                                                                 },
                                                                 set: { newValue in
                                                                     guard let index = board.boardColumns.firstIndex(where: { $0.id == column.id }) else { return }
                                                                     boardController.board?.boardColumns[index] = newValue
                                                                 }
                                                             )
                                BoardColumnView(column: bindingColumn, onSelectCard: { card in
                                    //                                    self.selectedCard = card
                                }, onColumnDropped: { droppedColumn, targetIndex in
                                    boardController.moveColumn(droppedColumn, toIndex: targetIndex)
                                })
                                .onTapGesture {
                                    //                                    self.selectedColumn = column
                                }
                                .contextMenu{
                                    Button(action: {
                                        confirmationController.setShowAlert(showAlert:true, itemToConfirm: .column(column), action: .delete)
                                        
                                    }){
                                        Text("Delete Column: " + (column.name))
                                    }
                                }
                            }
                            
                            Button(action: {
                                let boardColumn = BoardColumn(name: "Column", description: "", cards: [], index: board.boardColumns.count)
                                boardController.addBoardColumn(boardColumn: boardColumn)
                            }) {
                                VStack {
                                    Image(systemName: "plus")
                                    Text("Add Column")
                                }
                                .frame(width: 200, height: 50)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                    }
                    .frame(maxHeight: .infinity, alignment: .top) // Ensure the ScrollView fills available space and aligns to the top
                }
                .frame(maxHeight: .infinity, alignment: .top) // Ensure the VStack fills available space and aligns to the top
                
                
                
                Spacer() // Push the content to the top
            } else {
                Spacer()
                Text("I Just Boards").frame(alignment: .center)
                Spacer()
            }
        }
        .alert(isPresented: $confirmationController.showAlert) {
            Alert(
                title: Text("Delete " + confirmationController.getLabel(specific: false)),
                message: Text("Are you sure you want to delete " + confirmationController.getLabel(specific: true)),
                primaryButton: .destructive(Text("Delete")) {
                    confirmationController.confirmItem(boardController: boardController)
                },
                secondaryButton: .cancel(){
                    confirmationController.setShowAlert(showAlert: false, itemToConfirm: nil, action: nil)
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Ensure the outer VStack fills available space and aligns to the top
    }
}
