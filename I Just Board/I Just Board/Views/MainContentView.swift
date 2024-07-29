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
                VStack{
                    Text(board.name).font(.title)
                    Text(board.description).font(.subheadline)

                }.onTapGesture {
                    selectedBoard = board
                }
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 20) {
                        ForEach(board.boardColumns) { column in
                            BoardColumnView(column: column) { card in
                               
                                self.selectedCard = card
                            }.onTapGesture {
                                    self.selectedColumn = column
                            }
                        }

                        Button(action: {
                            let boardColumn = BoardColumn(name: "My New Column", description: "I Just A Column", cards: [])
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
                if let currentCard = selectedCard {
                    SelectedCardView(card: currentCard, onSave: { 
                        updatedCard in
                        boardController.updateCard(updatedCard)
                        self.selectedCard = nil
                    })
                } else if let currentColumn = selectedColumn {
                    SelectedColumnView(column: currentColumn, onSave: {
                        updatedColumn in
                        boardController.updateColumn(updatedColumn)
                        self.selectedColumn = nil
                    })
                } else if let currentBoard = selectedBoard {
                    SelectedBoardView(board: currentBoard, onSave: {
                        updatedBoard in
                        boardController.updateBoard(updatedBoard)
                        self.selectedBoard = nil
                    })
                }
                
            } else {
                Text("Select a board or create a new one")
            }
        }
    }
}
