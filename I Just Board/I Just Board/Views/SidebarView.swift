import Foundation
import SwiftUI

struct SidebarView: View {
    @Binding var boards: [Board]
    @Binding var selectedBoard: Board?
    @State private var boardToCopy: Board?
    @EnvironmentObject var boardController: BoardController
    @EnvironmentObject var boardListController: BoardListController
    @EnvironmentObject var windowSize: WindowSize

    var body: some View {
        VStack {
            List(selection: $selectedBoard) {
                ForEach(boards.sorted(by: { $0.index < $1.index }), id: \.id) { board in
                                SidebarItemView(board: board, boardToCopy: $boardToCopy)
                                    .environmentObject(boardListController)
                            }
                        }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 150, maxWidth: 300, alignment: .leading)
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
