//
//  ArrowView.swift
//  I Just Board
//
//  Created by Brett Owers on 8/1/24.
//

import Foundation
import SwiftUI

struct ArrowView: View {
    @State private var shimmer = false
    @State private var elongate = false
    @State private var translateY = false
    
    var body: some View {
        VStack {
            Image(systemName: "arrow.up")
                .foregroundColor(.white)
                .cornerRadius(10)
                .opacity(shimmer ? 0.5 : 1.0)
                .scaleEffect(elongate ? 1.5 : 1.0)
                .offset(y: translateY ? -10 : 10)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        shimmer.toggle()
                    }
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(1)) {
                        elongate.toggle()
                    }
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(2)) {
                        translateY.toggle()
                    }
                }
        }
    }
}
