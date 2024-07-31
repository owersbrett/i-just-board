
//
//  WindowSizeReaderView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/31/24.
//

import Foundation
import SwiftUI
import Combine

struct WindowSizeReader: View {
    @EnvironmentObject var windowSize: WindowSize

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: WindowSizePreferenceKey.self, value: geometry.size)
                .onPreferenceChange(WindowSizePreferenceKey.self) { size in
                    windowSize.size = size
                }
        }
    }
}

struct WindowSizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
