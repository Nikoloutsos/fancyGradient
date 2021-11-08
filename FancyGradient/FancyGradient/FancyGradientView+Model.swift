//
//  FancyGradientStyle.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import UIKit

protocol Animation {
    var animationSteps: [AnimationTransition] { get }
}

public struct AnimationTransition: Animation {
    var animationSteps: [AnimationTransition] {
        return [self]
    }

    let state: State
    let timeToTransitionToStateInSeconds: Double

    public init(colors: [UIColor], direction: Direction, time: Double) {
        self.state = .init(direction: direction, colors: colors)
        self.timeToTransitionToStateInSeconds = time
    }
}

public struct CompositeTransition: Animation {
    var animationSteps: [AnimationTransition] {
        return animationTransitions
    }

    let animationTransitions: [AnimationTransition]

    public init(animationTransitions: [AnimationTransition]) {
        self.animationTransitions = animationTransitions
    }
}


public struct State {
    let direction: Direction
    let colors: [UIColor]

    /// - Parameters:
    ///   - direction: The gradient direction
    ///   - colors: The colors used by the gradient.
    public init(direction: Direction,
                colors: [UIColor]) {
        self.direction = direction
        self.colors = colors
    }
}


public enum Direction {
    /// ⬆️
    case up
    /// ⬅️
    case left
    /// ⬇️
    case down
    //// ➡️
    case right
    /// ↗️
    case diagonalBottomLeftTopRight
    /// ↘️
    case diagonalTopLeftBottomRight
    /// ↙️
    case diagonalTopRightBottomLeft
    /// ↖️
    case diagonalBottomRightTopLeft
    case custom(startPoint: CGPoint, endPoint: CGPoint)

    var cgPoints: (CGPoint, CGPoint) {
        switch self {
        case .up:
            return (CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 0))
        case .left:
            return (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 0))
        case .down:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1))
        case .right:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0))
        case .diagonalBottomLeftTopRight:
            return (CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))
        case .diagonalTopLeftBottomRight:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
        case .diagonalTopRightBottomLeft:
            return (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1))
        case .diagonalBottomRightTopLeft:
            return (CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 0))
        case .custom(startPoint: let startPoint, endPoint: let endPoint):
            return (startPoint, endPoint)
        }
    }
}
