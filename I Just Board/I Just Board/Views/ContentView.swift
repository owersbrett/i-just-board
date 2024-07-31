import SwiftUI
import SwiftData


import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var windowSize = WindowSize()
    @StateObject private var confirmationController = ConfirmationController(boardController:  nil)
    
    @StateObject private var currentViewController = CurrentViewController()
    @StateObject private var boardController: BoardController
    @StateObject private var complexityController = ComplexityController()
    @StateObject private var boardListController: BoardListController

    init() {
        let boardListController = BoardListController()
        _boardListController = StateObject(wrappedValue: boardListController)
        let boardController = BoardController(boardListController: boardListController)
        _boardController = StateObject(wrappedValue: BoardController(boardListController: boardListController))
        _confirmationController = StateObject(wrappedValue: ConfirmationController(boardController: boardController))
    }

    var body: some View {
        NavigationView {
            Text("").hidden()
            SidebarView(boards: $boardListController.boards, selectedBoard: $boardListController.selectedBoard)
                .frame(minWidth: windowSize.size.width * 0.1, maxWidth: windowSize.size.width * 0.3)
            MainContentView()
        }
        .background(WindowSizeReader())
        .environmentObject(boardController)
        .environmentObject(boardListController)
        .environmentObject(currentViewController)
        .environmentObject(confirmationController)
        .environmentObject(complexityController)
        .environmentObject(windowSize)
    }
}
