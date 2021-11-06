//
//  FancyGradientView+Animation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import Foundation
import UIKit

// MARK: Circle animation
extension FancyGradientView {
    func animateCircle() {
        nextAnimationStep(startToValue: CornerPoint.leftBottom.cgPoint(),
                           endToValue: CornerPoint.rightTop.cgPoint(),
                           animationId: "first")
    }

    private func nextAnimationStep(startToValue: CGPoint, endToValue: CGPoint, animationId: String) {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        let animationStartPoint = CABasicAnimation(keyPath: "startPoint")
        animationStartPoint.fromValue = model.direction.startPoint
        animationStartPoint.toValue = startToValue

        let animationEndPoint = CABasicAnimation(keyPath: "endPoint")
        animationEndPoint.fromValue = model.direction.endPoint
        animationEndPoint.toValue = endToValue

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationStartPoint, animationEndPoint]
        animationGroup.duration = 1.5
        animationGroup.setValue(animationId, forKey: "CompletionId")
        animationGroup.fillMode = .forwards;
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = 1

        animationGroup.delegate = self
        gradientLayer.add(animationGroup, forKey: nil)

        let newDirections = ViewModel.Direction(startPoint: startToValue, endPoint: endToValue)
        let newModel = ViewModel(direction: newDirections, colors: model.colors)
        self.model = newModel
    }
}


extension FancyGradientView {
    enum CornerPoint {
        case leftTop
        case leftBottom
        case rightBottom
        case rightTop

        func cgPoint() -> CGPoint {
            switch self {
            case .leftTop:
                return .init(x: 0, y: 0)
            case .leftBottom:
                return .init(x: 0, y: 1)
            case .rightBottom:
                return .init(x: 1, y: 1)
            case .rightTop:
                return .init(x: 1, y: 0)
            }
        }
    }
}

// MARK: - CAAnimationDelegate
extension FancyGradientView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let animId = anim.value(forKey: "CompletionId") as? String
        if animId == "first" {
            nextAnimationStep(startToValue: CornerPoint.rightBottom.cgPoint(),
                               endToValue: CornerPoint.leftTop.cgPoint(),
                               animationId: "second")
        }else if animId == "second"{
            nextAnimationStep(startToValue: CornerPoint.rightTop.cgPoint(),
                               endToValue: CornerPoint.leftBottom.cgPoint(),
                               animationId: "third")
        }else if animId == "third" {
            nextAnimationStep(startToValue: CornerPoint.leftTop.cgPoint(),
                               endToValue: CornerPoint.rightBottom.cgPoint(),
                               animationId: "forth")
        }else if animId == "forth" {
            nextAnimationStep(startToValue: CornerPoint.leftBottom.cgPoint(),
                               endToValue: CornerPoint.rightTop.cgPoint(),
                               animationId: "first")
        }
    }
}
