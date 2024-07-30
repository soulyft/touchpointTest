//
//  TouchViewModel.swift
//  touchpointTest
//
//  Created by Corey Lofthus on 7/29/24.
//

import SwiftUI

@Observable class TouchViewModel {
    var touchPoints: [CGPoint] = Array(repeating: .zero, count: 4)
    var activeTouches: [Bool] = [false, false, false, false]
    var readyTouches: [Bool] = [true, false, false, false]
    var activeIndex: Int = 0
    var circleIndex: Int = 0

    var isTouched: Bool { activeTouches.contains(true) }

    func activateNextAvailableTouch() {
        if let firstInactiveIndex = readyTouches.firstIndex(of: false) {
            readyTouches[firstInactiveIndex] = true
            activeIndex = firstInactiveIndex
        }
    }

    func resetTouchStatesIfNeeded(_ oldValue: [Bool]) {
        if !activeTouches.contains(true) {
            readyTouches = [true, false, false, false]
            activeIndex = 0
            circleIndex = 0
        } else if !oldValue.contains(false) {
            activateNextAvailableTouch()
        }
    }
}
