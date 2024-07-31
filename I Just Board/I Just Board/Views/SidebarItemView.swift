//
//  SidebarItemView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/30/24.
//


import SwiftUI
import UniformTypeIdentifiers

struct SidebarItemView: View {
    let board: Board
    @Binding var boardToCopy: Board?
    @EnvironmentObject var boardListController: BoardListController
    @State private var showDeleteConfirmation = false
    @State private var boardToDelete: Board?
    
    
    var body: some View {
        VStack {
            
            Text(board.name).frame(minWidth: 150)
        }
        .tag(board)
        .padding()
        
        .onTapGesture {
            debugPrint("Printing did tap")
            boardListController.selectBoard(board: board)
        }
        .onDrag {
            NSItemProvider(object: String(board.id.uuidString) as NSString)
        }
        .onDrop(of: [UTType.text], delegate: BoardDropDelegate(board: board, boards: $boardListController.boards, boardListController: boardListController))
        .contextMenu {
            Button(action: {
                debugPrint("Copy Board: " + board.name)
                boardToCopy = board
            }){
                Text("Copy Board")
            }
            if boardToCopy != nil {
                Button(action: {
                    debugPrint("Paste")
                    boardListController.insertBoardAtIndex(boardToInsert: boardToCopy!, at: board.index)
                }){
                    Text("Paste Board: " + (boardToCopy?.name ?? ""))
                }
            }
            Button(action: {
                boardToDelete = board
                showDeleteConfirmation = true
                
            }){
                Text("Delete Board: " + (board.name))
            }
            Menu {
                Button(action: {
                    applyTemplate(to: board, template: "SPRINT")
                }) {
                    Text("Sprint")
                }
                // Add more templates as needed
            } label: {
                Text("Templates")
            }
        }.alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Delete Board"),
                message: Text("Are you sure you want to delete this board?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let _boardToDelete = boardToDelete {
                        boardListController.deleteBoard(boardToDelete: _boardToDelete)
                        boardToDelete = nil
                    }
                    showDeleteConfirmation = false
                },
                secondaryButton: .cancel(){
                    boardToDelete = nil
                    showDeleteConfirmation = false
                }
            )
        }
    }
    
    private func applyTemplate(to board: Board, template: String) {
        switch template {
        case "SPRINT":
            boardListController.applyTemplate(to: board, template: ["PRIORITY", "BACKLOG", "SPRINT", "DOING", "DONE", "ARCHIVE"], templateName: template)
        default:
            break
        }
    }
}
