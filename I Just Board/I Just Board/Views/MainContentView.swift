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
    @Binding var selectedBoard: Board?
    @EnvironmentObject var boardController: BoardController

    var body: some View {
        VStack {
            if let board = selectedBoard {
                Text(board.boardName).font(.title)
                Text(board.boardDescription).font(.subheadline)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 20) {
                        ForEach(board.boardColumns) { column in
                    BoardColumnView(column: column)
                        }
                        
                        Button(action: {
                            debugPrint("Adding column...")
                            var boardColumn = BoardColumn.createDefault()
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
            } else {
                Text("Select a board or create a new one")
            }
        }
    }
}
