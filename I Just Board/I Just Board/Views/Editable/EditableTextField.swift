//
//  EditableTextField.swift
//  I Just Board
//
//  Created by Brett Owers on 7/31/24.
//

import Foundation

import SwiftUI

struct EditableTextField: View {
    @State private var isEditing: Bool = false
    @Binding var text: String
    var onSubmit: ((String) -> Void)
    

    var body: some View {
        if isEditing {
            TextField("", text: $text, onEditingChanged: { editing in
                isEditing = editing
            })
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 2)
            )
            .onTapGesture {
                isEditing = true
            }
            .onSubmit {
                onSubmit(text);
                isEditing = false
            }.padding()
        } else {
            Text(text)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top], 8)
                .padding()
                .onTapGesture {
                    isEditing = true
                }
        }
    }
}
