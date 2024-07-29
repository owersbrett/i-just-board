//
//  SidebarView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftUI

struct SidebarView: View {
    let boards: [Board]
    @Binding var selectedBoard: Board?
    @EnvironmentObject var boardController: BoardController
    @EnvironmentObject var boardListController: BoardListController

    var body: some View {

        List(boards, selection: $selectedBoard) { board in
            Text(board.name)
                .tag(board).onTapGesture {
                    debugPrint("Printing did tap")
                    boardListController.selectBoard(board: board)
                }
        }
        
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    debugPrint("Adding board...")
                    boardListController.addBoard(boardName: "I Just A Board", boardDescription: "I Just A Board Description")
                }) {
                    Label("Add Board", systemImage: "plus")
                }
            }
        }
    }
}
