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
    var currentState: State
    public var applyAnimationOnChanges: Bool = true

    public var colors: [UIColor] = [] {
        didSet {
            updateCurrentState()
            applyGradient()
        }
    }

    public var direction: Direction = .up {
        didSet {
            updateCurrentState()
            applyGradient()
        }
    }

    public var type: CAGradientLayerType = .axial {
        didSet {
            updateCurrentState()
            applyGradient()
        }
    }

    var gradientLayer: CAGradientLayer {
         self.layer as! CAGradientLayer
    }

    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }

    public init(colors: [UIColor],
                direction: Direction,
                type: CAGradientLayerType) {
        self.currentState = .init(direction: direction, colors: colors, type: type)
        self.colors = currentState.colors
        self.direction = currentState.direction
        self.type = type
        super.init(frame: .zero)
        applyGradient()
    }

    public init(hexColors: [String],
                direction: Direction) {
        self.currentState = .init(direction: direction, colors: hexColors.map{ UIColor.init(hex: $0) ?? .clear}, type: type)
        self.colors = currentState.colors
        self.direction = currentState.direction
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
        gradientLayer.colors = currentState.colors.map{ $0.cgColor }
        gradientLayer.startPoint = currentState.direction.cgPoints.0
        gradientLayer.endPoint = currentState.direction.cgPoints.1
        gradientLayer.type = currentState.type
    }

    private func updateCurrentState() {
        self.currentState = .init(direction: direction, colors: colors, type: type)
    }
}

