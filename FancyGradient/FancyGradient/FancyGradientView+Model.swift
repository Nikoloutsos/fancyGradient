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

        public init(startPoint: CGPoint, endPoint: CGPoint) {
            self.startPoint = startPoint
            self.endPoint = endPoint
        }
    }
}

// MARK: - Animation types
extension FancyGradientView.ViewModel {
    public enum Animation {
        /**  Cycle  animation */
        case cycle(duration: Double)
    }
}
