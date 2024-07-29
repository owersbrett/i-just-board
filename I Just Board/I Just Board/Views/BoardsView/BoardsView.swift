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
            GridOfBoardsView(boards: $boardListController.boards)
                .padding()

            // Add your other views and controls here...
        }
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
