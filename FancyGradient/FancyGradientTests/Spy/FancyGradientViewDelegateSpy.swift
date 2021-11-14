//
//  FancyGradientViewDelegateSpy.swift
//  FancyGradientTests
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 14/11/21.
//

import Foundation
@testable import FancyGradient

final class FancyGradientViewDelegateSpy: FancyGradientViewDelegate {
    enum Actions {
        case animationDidFinished(animId: String)
    }
    var actions: [Actions] = []

    func animationDidFinished(animId: String) {
        actions.append(.animationDidFinished(animId: animId))
    }
}

extension FancyGradientViewDelegateSpy.Actions: Equatable {}
