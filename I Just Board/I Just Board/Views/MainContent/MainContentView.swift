import Foundation
import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var boardController: BoardController
    @EnvironmentObject var confirmationController: ConfirmationController
    @EnvironmentObject var windowSize: WindowSize
    @EnvironmentObject var themeController: ThemeController
    @State private var inactivityTimer: Timer?
    @State private var showArrow = false
    
    private func startInactivityTimer() {
        debugPrint("Start Timer...")
        inactivityTimer?.invalidate()
        inactivityTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            debugPrint("Stop Timer...")
            withAnimation {
                showArrow = true
            }
        }
    }
    
    private func resetInactivityTimer() {
        inactivityTimer?.invalidate()
        withAnimation {
            showArrow = false
        }
        startInactivityTimer()
    }
    
    private func animateArrow() {
        // Implement your arrow animations here
    }
    
    var body: some View {
        VStack {
            if let board = boardController.board {
                let bindingBoard = Binding<Board>(
                    get: {
                        return boardController.board ?? board
                    },
                    set: { newValue in
                        boardController.board = newValue
                    }
                )
                VStack {
                    VStack {
                        EditableTextField(text: bindingBoard.name, viewEnum: .board, onSubmit: { newValue in
                            var board = bindingBoard.wrappedValue
                            board.name = newValue
                            boardController.updateBoard(board)
                        }, fontSize: 32)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(themeController.currentTheme.boardBackgroundColor))
                    .padding()
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(board.boardColumns.sorted(by: { $0.index < $1.index }), id: \.id) { column in
                                let bindingColumn = Binding<BoardColumn>(
                                    get: {
                                        guard let index = board.boardColumns.firstIndex(where: { $0.id == column.id }) else {
                                            return column
                                        }
                                        let count = boardController.board?.boardColumns.count
                                        if count! <= index {
                                            return column
                                        }
                                        return boardController.board?.boardColumns[index] ?? column
                                    },
                                    set: { newValue in
                                        guard let index = board.boardColumns.firstIndex(where: { $0.id == column.id }) else { return }
                                        boardController.board?.boardColumns[index] = newValue
                                    }
                                )
                                BoardColumnView(column: bindingColumn, onSelectCard: { card in
                                    // self.selectedCard = card
                                }, onColumnDropped: { droppedColumn, targetIndex in
                                    boardController.moveColumn(droppedColumn, toIndex: targetIndex)
                                })
                                .onTapGesture {
                                    // self.selectedColumn = column
                                }
                                .contextMenu {
                                    Button(action: {
                                        confirmationController.setShowAlert(showAlert: true, itemToConfirm: .column(column), action: .delete)
                                    }) {
                                        Text("Delete Column: " + (column.name))
                                    }
                                }
                            }
                            
                            Button(action: {
                                let boardColumn = BoardColumn(name: "Column", description: "", cards: [], index: board.boardColumns.count)
                                boardController.addBoardColumn(boardColumn: boardColumn)
                            }) {
                                VStack {
                                    Image(systemName: "plus")
                                    Text("Add Column")
                                }
                                .onAppear {
                                    startInactivityTimer()
                                }
                                .onTapGesture {
                                    resetInactivityTimer()
                                }
                                .padding()
                                .frame(width: windowSize.size.width * 0.15, height: 50)
                                //                                .background(themeController.currentTheme.addColumnColor)
                                .cornerRadius(12) // Adjusted corner radius
                                .foregroundColor(themeController.currentTheme.addCardFontColor) // Ensure text color is readable
                                .shadow(radius: 5) // Optional: Add shadow for better visual appearance
                            }.background(themeController.currentTheme.addCardColor)
                                .cornerRadius(16)
                        }
                        .padding()
                    }
                    .frame(maxHeight: .infinity, alignment: .top) // Ensure the ScrollView fills available space and aligns to the top
                }
                .frame(maxHeight: .infinity, alignment: .top) // Ensure the VStack fills available space and aligns to the top
                
                Spacer() // Push the content to the top
            } else {
                GeometryReader {
                    geometry in
                    ZStack {
                        VStack {
                            Spacer()
                            VStack{
                                HStack{
                                    Text("I").bold().font(.system(size: 100))
                                    Spacer()
                                }
                                HStack{
                                    Text("Just").bold().font(.system(size: 100))
                                    Spacer()
                                }
                                HStack{
                                    Text("Board").bold().font(.system(size: 100))
                                    Spacer()
                                }
                            }.padding()
                        }
                        
                        if showArrow {
                            ArrowView()
                                .position(x: geometry.size.width - 26, y: 26)
                                .onAppear {
                                    animateArrow()
                                }
                        }
                    }.onAppear {
                        startInactivityTimer()
                    }
                    .onTapGesture {
                        resetInactivityTimer()
                    }
                }
                
                
                //                Spacer()
            }
        }
        .alert(isPresented: $confirmationController.showAlert) {
            Alert(
                title: Text("Delete " + confirmationController.getLabel(specific: false)),
                message: Text("Are you sure you want to delete " + confirmationController.getLabel(specific: true)),
                primaryButton: .destructive(Text("Delete")) {
                    confirmationController.confirmItem(boardController: boardController)
                },
                secondaryButton: .cancel() {
                    confirmationController.setShowAlert(showAlert: false, itemToConfirm: nil, action: nil)
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(themeController.currentTheme.boardBackgroundColor)
    }
}
