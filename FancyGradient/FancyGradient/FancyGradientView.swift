//
//  FancyGradientView.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import Foundation
import UIKit

// MARK: - FancyGradientView
public final class FancyGradientView: UIView {
    var model: ViewModel

    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }

    /// - Parameter model: A viewModel. It's used by view to determine its appearance.
    public init(model: ViewModel) {
        self.model = model
        super.init(frame: .zero)
        applyGradient()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        applyGradient()
    }

    private func applyGradient() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = model.colors.map{ $0.cgColor }
        gradientLayer.startPoint = model.direction.startPoint
        gradientLayer.endPoint = model.direction.endPoint
    }
}

// MARK: Animation functions
extension FancyGradientView {

    /// Use this method to start an animation.
    /// - Parameter animation: Determines the type of animation
    public func animate(with animation: ViewModel.Animation) {
        switch animation {
        case .cycle(let duration):
            animateCircle()
        }
    }

    /// Use this method to stop any animation
    public func stopAnimation() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.removeAllAnimations()
    }
}
