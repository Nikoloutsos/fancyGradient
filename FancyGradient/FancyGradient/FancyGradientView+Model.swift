//
//  FancyGradientStyle.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import UIKit

// MARK: - ViewModel
extension FancyGradientView {
    public struct ViewModel {
        let direction: Direction
        let colors: [UIColor]

        /// - Parameters:
        ///   - direction: The gradient direction
        ///   - colors: The colors used by the gradient.
        public init(direction: FancyGradientView.ViewModel.Direction,
                    colors: [UIColor]) {
            self.direction = direction
            self.colors = colors
        }
    }
}

// MARK: - Direction
extension FancyGradientView.ViewModel {
    public struct Direction {
        let startPoint: CGPoint
        let endPoint: CGPoint

        /// - Parameters:
        ///   - startPoint: The starting point of gradient. (0,0) is topleft and (1,1) bottom right
        ///   - endPoint: The ending point of gradient. (0,0) is topleft and (1,1) bottom right
        public init(startPoint: CGPoint, endPoint: CGPoint) {
            self.startPoint = startPoint
            self.endPoint = endPoint
        }
    }
}

// MARK: - Animation types
extension FancyGradientView.ViewModel {
    /// The different types of animations
    public enum Animation {
        case cycle(duration: Double)
    }
}
