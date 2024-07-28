//
//  HorizontalBarView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import SwiftUI

struct HorizontalBarView: View {
    
    @EnvironmentObject var boardListController: BoardListController

    @Binding
    var complexity: Complexity;
    
    

    
    var body: some View
    {
        HStack {
            Spacer()
            Menu {
                Button("Add Board") { /* action */ }
                Button("List Boards") { /* action */ }
                Button("Archive Board") { /* action */ }
                Button("Pin Board") { /* action */ }
                Button("Delete") { /* action */ }
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding()
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(16)
    }

}
