//
//  BoardsView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import SwiftUI
struct NewBoardsView: View {
    let title: String
    @Binding var complexity: Complexity
    @StateObject var boardListController: BoardListController

    var body: some View {
        VStack {
            Text("I Just A Grid of Boards")
            GridOfBoardsView(boards: $boardListController.boards).padding()
        }
    }
}

