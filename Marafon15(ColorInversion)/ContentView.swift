//
//  ContentView.swift
//  Marafon15(ColorInversion)
//
//  Created by ViktorM1Max on 12.03.2024.
//

import SwiftUI

struct DraggableRectangle: View {
    @State private var currentPosition: CGSize = .zero
    @GestureState private var gestureOffset: CGSize = .zero

    var body: some View {
        Rectangle()
            .fill(.black)
            .frame(width: 150, height: 150)
            .cornerRadius(10.0)
            .overlay(content: {
                Rectangle()
                    .fill(.white)
                    .scaleEffect(1.42)
                    .visualEffect { content, geometryProxy in
                        content.offset(x: 0, y: -(gestureOffset.height + currentPosition.height) - 107)
                    }
                    .cornerRadius(10.0)
            })
            .overlay(content: {
                Rectangle()
                    .fill(.white)
                    .scaleEffect(1.42)
                    .visualEffect { content, geometryProxy in
                        content.offset(x: 0, y: -(gestureOffset.height + currentPosition.height) + 319)
                    }
                    .cornerRadius(10.0)
            })
            .offset(x: gestureOffset.width + currentPosition.width, y: gestureOffset.height + currentPosition.height)
            .gesture(
                DragGesture()
                    .updating($gestureOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        self.currentPosition.width += value.translation.width
                        self.currentPosition.height += value.translation.height
                    }
            )
    }
}

struct ContentView: View {
    @State var yWhite = 0.0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle().fill(.white)
                Rectangle().fill(.pink)
                Rectangle().fill(.orange)
                Rectangle().fill(.black)
            }
            DraggableRectangle()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
