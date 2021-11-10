//
//  FancyGradientStyle.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import UIKit

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
