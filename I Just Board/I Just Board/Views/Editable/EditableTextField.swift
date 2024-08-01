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
    
    // Define a font size variable
    var fontSize: CGFloat = 24
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            if isEditing {
                TextField("", text: $text, onEditingChanged: { editing in
                    isEditing = editing
                })
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 2)
                )
                .focused($isFocused)
                .onAppear {
                    isFocused = true
                }
                .onChange(of: isFocused) { focused in
                    if !focused {
                        isEditing = false
                    }
                }
                .onSubmit {
                    onSubmit(text)
                    isEditing = false
                }
                .font(.system(size: fontSize)) // Set the font size for the TextField
                .padding()
            } else {
                Text(text)
                    .font(.system(size: fontSize)) // Set the font size for the Text
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .onTapGesture {
                        isEditing = true
                    }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isEditing {
                isFocused = false
            }
        }
    }
}
