//
//  BoardsView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import SwiftUI
struct BoardsView: View {
    let title: String
    @Binding var complexity: Complexity
    @StateObject var boardListController: BoardListController

    var body: some View {
        VStack {
            Text("I Just A Grid of Boards")
            // Display the grid of boards
            GridOfBoards(boards: $boardListController.boards)
                .padding()

            // Add your other views and controls here...
        }
    }
}


struct GridOfBoards: View {
    @Binding var boards: [Board]
    
    var body: some View {

        LazyVGrid(columns: [GridItem.init()]) {
            if (boards.isEmpty) {
 
                AddBoardButton()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ForEach(boards.indices, id: \.self) { index in
                    if index < boards.count {
                        BoardCardView(board: boards[index])
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        AddBoardButton()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            
        }
    }
}

struct BoardCardView: View {
    let board: Board

    var body: some View {
        VStack(alignment: .leading) {
            Text(board.boardName)
                .font(.headline)

            Text(board.boardDescription)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct AddBoardButton: View {
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.white)
                .frame(width: 40, height: 40)

            Text("+")
                .font(.largeTitle)
                .foregroundColor(Color.gray)
        }
        .padding().onTapGesture {
            
        }
    }
}
