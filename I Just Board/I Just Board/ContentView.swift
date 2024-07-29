import SwiftUI
import SwiftData




struct ContentView: View {
    @StateObject private var currentViewController = CurrentViewController()
    @StateObject private var boardController: BoardController
    @StateObject private var cardController = CardController()
    @StateObject private var cardListController = CardListController()
    @StateObject private var complexityController = ComplexityController()
    @StateObject private var boardListController = BoardListController()

    init(){
        let boardListController = BoardListController()
               _boardListController = StateObject(wrappedValue: boardListController)
               _boardController = StateObject(wrappedValue: BoardController(boardListController: boardListController))
    }
    

    var body: some View {
        NavigationView {
            Text("").hidden()
            SidebarView(boards: boardListController.boards, selectedBoard: $boardListController.selectedBoard)
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            
            MainContentView()
        }
        .environmentObject(boardController)
        .environmentObject(boardListController)
        .environmentObject(cardController)
        .environmentObject(cardListController)
        .environmentObject(currentViewController)
        .environmentObject(complexityController)
    }
}
