import Foundation
import SwiftUI

struct SidebarView: View {
    @Binding var boards: [Board]
    @Binding var selectedBoard: Board?
    @State private var boardToCopy: Board?
    @EnvironmentObject var boardController: BoardController
    @EnvironmentObject var boardListController: BoardListController
    @EnvironmentObject var windowSize: WindowSize
    @EnvironmentObject var themeController: ThemeController
    var body: some View {
        VStack {
            List(selection: $selectedBoard) {
                ForEach(boards.sorted(by: { $0.index < $1.index }), id: \.id) { board in
                                SidebarItemView(board: board, boardToCopy: $boardToCopy)
                                    .environmentObject(boardListController)
                                    .cornerRadius(16)
                            }
                        }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 150, maxWidth: 300, alignment: .leading)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        Button(action: {
                            debugPrint("Adding board...")
                            var board = boardListController.addBoard(boardName: "Board", boardDescription: "")
                            boardListController.selectBoard(board: board)
                        }) {
                            Label("Add Board", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }
}

