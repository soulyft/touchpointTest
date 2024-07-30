//
//  TouchView.swift
//  touchpointTest
//
//  Created by Corey Lofthus on 7/29/24.
//

import SwiftUI

struct TouchView: View {
    @GestureState private var isTouched = false
    let touchIndex: Int
    @Environment(TouchViewModel.self) private var touchVM
    let action: (CGPoint, Int) -> Void

    var body: some View {
        GeometryReader { geo in
            if touchVM.readyTouches[touchIndex] {
                Color.clear.contentShape(Rectangle()) // Allow full area for gestures
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .updating($isTouched) { _, gestureState, _ in
                                gestureState = true
                            }
                            .onChanged { gesture in
                                action(gesture.location, touchIndex)
                            }
                            .onEnded { _ in
                                action(.zero, touchIndex) // Signal touch end
                            }
                    )
                    .onChange(of: isTouched) { oldValue, newValue in
                        if !newValue {
                            touchVM.activeTouches[touchIndex] = false
                            touchVM.readyTouches[touchIndex] = false
                            touchVM.activateNextAvailableTouch()
                        }
                    }
            } else {
                Color.clear
            }
        }
    }
}

#Preview {
    ContentView()
}
