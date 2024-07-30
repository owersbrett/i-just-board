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
    @State private var selectedCard: Card?
    @State private var selectedColumn: BoardColumn?
    @State private var selectedBoard: Board?

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

                    
                    .onTapGesture {
                        selectedBoard = board
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(board.boardColumns.sorted(by: { $0.index < $1.index })) { column in
                                BoardColumnView(column: column, onSelectCard: { card in
                                    self.selectedCard = card
                                }, onColumnDropped: { droppedColumn, targetIndex in
                                    boardController.moveColumn(droppedColumn, toIndex: targetIndex)
                                })
                                .onTapGesture {
                                    self.selectedColumn = column
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

                if let currentCard = selectedCard {
                    SelectedCardView(card: currentCard, onSave: {
                        updatedCard in
                        boardController.updateCard(updatedCard)
                        self.selectedCard = nil
                    }, onDelete: {
                        updatedCard in
                        boardController.deleteCard(card: updatedCard)
                        self.selectedCard = nil
                    }).frame(maxWidth: 500)
                } else if let currentColumn = selectedColumn {
                    SelectedColumnView(column: currentColumn, onSave: {
                        updatedColumn in
                        boardController.updateColumn(updatedColumn)
                        self.selectedColumn = nil
                    }).frame(maxWidth: 500)
                } else if let currentBoard = selectedBoard {
                    SelectedBoardView(board: currentBoard, onSave: {
                        updatedBoard in
                        boardController.updateBoard(updatedBoard)
                        self.selectedBoard = nil
                    }).frame(maxWidth: 500)
                }
                
                Spacer() // Push the content to the top
            } else {
                Spacer()
                Text("I Just Boards").frame(alignment: .center)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Ensure the outer VStack fills available space and aligns to the top
    }
}
