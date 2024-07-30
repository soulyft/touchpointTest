//
//  MultiTouchView.swift
//  touchpointTest
//
//  Created by Corey Lofthus on 7/29/24.
//

import SwiftUI

struct MultiTouchView: View {
    @Environment(TouchViewModel.self) private var touchVM

    @State private var demoTexts: [String] = Array(repeating: "", count: 4)

    func handleTouch(_ location: CGPoint, touchIndex: Int) {
        demoTexts[touchIndex] = "Finger \(touchIndex) at: \(Int(location.x)), \(Int(location.y))"

        if !touchVM.activeTouches[touchIndex] {
            touchVM.activateNextAvailableTouch()
        }
        touchVM.activeTouches[touchIndex] = true
        touchVM.touchPoints[touchIndex] = location
    }

    var body: some View {
        ZStack {
            ForEach(0..<touchVM.touchPoints.count, id: \.self) { index in
                TouchView(touchIndex: index) { location, touchIndex in
                    handleTouch(location, touchIndex: touchIndex)
                }
                .zIndex(touchVM.activeIndex == index ? 1 : 0)
            }

            VStack {
                Spacer()
                ForEach(0..<demoTexts.count, id: \.self) { index in
                    Text(demoTexts[index])
                }
            }
        }
        .onChange(of: touchVM.activeTouches) { oldValue, newValue in
            touchVM.resetTouchStatesIfNeeded(oldValue)
            if !newValue.contains(false) {
                if let firstInactiveIndex = oldValue.firstIndex(of: false) {
                    touchVM.circleIndex = firstInactiveIndex
                }
            }
        }
        .onChange(of: touchVM.activeIndex) { oldValue, newValue in
            touchVM.circleIndex = oldValue
        }
    }
}

#Preview {
    ContentView()
}
