//
//  FloatingViewModifier.swift
//  ZipFinder
//
//  Created by Vince Carlo Santos on 5/26/23.
//

import Foundation
import SwiftUI

struct FloatingViewModifier: ViewModifier {
    @State var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? 4 : -4)
            .animation(
                Animation
                    .easeOut(duration: 2)
                    .repeatForever(),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

extension View {
    func levitate() -> some View {
        self.modifier(FloatingViewModifier())
    }
}

