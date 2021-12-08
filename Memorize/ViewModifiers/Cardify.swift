//
//  Cardify.swift
//  Memorize
//
//  Created by Kutay Karakamış on 7.12.2021.
//

import SwiftUI

// MARK: This "View Modifier" takes view and modify. Makes it a Card

struct Cardify: ViewModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).stroke(lineWidth: DrawingConstants.lineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
