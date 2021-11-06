//
//  FancyGradientStyle.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import UIKit

public extension FancyGradientView {
    struct ViewModel {
        let direction: Direction
        let colors: [UIColor]

        public init(direction: FancyGradientView.ViewModel.Direction, colors: [UIColor]) {
            self.direction = direction
            self.colors = colors
        }
    }
}

public extension FancyGradientView.ViewModel {
    struct Direction {
        let startPoint: CGPoint
        let endPoint: CGPoint

        public init(startPoint: CGPoint, endPoint: CGPoint) {
            self.startPoint = startPoint
            self.endPoint = endPoint
        }
    }
}
