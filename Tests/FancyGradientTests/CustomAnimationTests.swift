//
//  CustomAnimationTests.swift
//  FancyGradientTests
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 14/11/21.
//

import XCTest
@testable import FancyGradient

class CustomAnimationTests: XCTestCase {
    var sut: Animationable!

    func test_whenAddSerialAnimations_durationShouldBeCorrect() {
        sut = CustomAnimation()
            .then(EmptyAnimation(duration: 1))
            .then(DirectionAnimation(newDirection: .up, duration: 2))
            .then(ColorAnimation(newColors: [], duration: 3))
            .then(ColorStopsAnimation(colorStops: [], duration: 4))

        XCTAssertEqual(sut.duration, 1 + 2 + 3 + 4)
    }

    func test_combinationAnimation_duratinShouldBeCorrect() {
        sut = CombineAnimation(ColorStopsAnimation(colorStops: [], duration: 1),
                               ColorAnimation(newColors: [], duration: 5),
                               DirectionAnimation(newDirection: .up, duration: 10))

        XCTAssertEqual(sut.duration, 10)
    }
}
