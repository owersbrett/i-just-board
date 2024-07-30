//
//  SidebarView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//
import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct SidebarView: View {
    @Binding var boards: [Board]
    @Binding var selectedBoard: Board?
    @EnvironmentObject var boardController: BoardController
    @EnvironmentObject var boardListController: BoardListController

    var body: some View {
        VStack {
            List(selection: $selectedBoard) {
                ForEach(boards) { board in
                    VStack {
                        Text(board.name).frame(minWidth: 150)
                    }
                    
                        .tag(board)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.black))

                        .onTapGesture {
                            debugPrint("Printing did tap")
                            boardListController.selectBoard(board: board)
                        }
                        .onDrag {
                            NSItemProvider(object: String(board.id.uuidString) as NSString)
                        }
                        .onDrop(of: [UTType.text], delegate: BoardDropDelegate(board: board, boards: $boards, boardListController: boardListController))
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 150, maxWidth: 300)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        Button(action: {
                            debugPrint("Deleting board...")
                            boardListController.deleteBoards()
                        }) {
                            Label("Delete Board", systemImage: "minus")
                        }
                        Button(action: {
                            debugPrint("Adding board...")
                            boardListController.addBoard(boardName: "Board", boardDescription: "")
                        }) {
                            Label("Add Board", systemImage: "plus")
                        }
                    }
                
                }
            }
        }
    }
}
