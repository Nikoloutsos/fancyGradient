//
//  FancyGradientTests.swift
//  FancyGradientTests
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 14/11/21.
//

import XCTest
@testable import FancyGradient

class FancyGradientTests: XCTestCase {
    var sut: FancyGradientView!

    override func setUp() {
        sut = FancyGradientView(colors: [UIColor.red, UIColor.black], direction: .up)
    }

    func test_whenInitialized_sutHasCAGradientLayer() {
        XCTAssertNotNil(sut.layer as? CAGradientLayer)
    }

    func test_whenDelegateAndAnimIDProvided_delegateMethdodIsCalled() {
        let spy = FancyGradientViewDelegateSpy()
        sut.delegate = spy

        let caAnimation = CAAnimation()
        caAnimation.setValue("animID", forKey: "CompletionId")
        sut.animationDidStop(caAnimation, finished: true)

        XCTAssertFalse(spy.actions.isEmpty)
    }

    func test_whenDelegateAndAnimIDProvided_delegateMethdodIsCalledWithCorrectAnimId() {
        let spy = FancyGradientViewDelegateSpy()
        sut.delegate = spy

        let caAnimation = CAAnimation()
        caAnimation.setValue("animID", forKey: "CompletionId")
        sut.animationDidStop(caAnimation, finished: true)

        XCTAssertEqual(spy.actions.first, .animationDidFinished(animId: "animID"))
    }
}
