//
//  FancyGradientView.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import Foundation
import UIKit

// MARK: - FancyGradientView
/// An animated GradientView. Supports custom animations and will make your look fancy and sexy 🚀
public final class FancyGradientView: UIView {
    /// When provided animID to your CustomAnimation this delegate will notify you about animation finish.
    public weak var animationDelegate: FancyGradientViewDelegate?

    /// The colors that the gradient is going to have.  🎨
    public var colors: [UIColor] = [] {
        didSet {
            applyGradient()
        }
    }

    /// The direction of the gradient.
    public var direction: Direction = .up {
        didSet {
            applyGradient()
        }
    }

    /// The gradient type (e.g axial, conic etc)
    public var type: CAGradientLayerType = .axial {
        didSet {
            applyGradient()
        }
    }

    var gradientLayer: CAGradientLayer {
         self.layer as! CAGradientLayer
    }

    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }

    /// Initializer
    /// - Parameters:
    ///   - colors: Gradient colors  (e.g [black, red])
    ///   - direction: Direction of gradient  (e.g .up)
    ///   - type: Gradient type (e.g axial)
    public init(colors: [UIColor],
                direction: Direction,
                type: CAGradientLayerType) {
        self.colors = colors
        self.direction = direction
        self.type = type
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
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.startPoint = direction.cgPoints.0
        gradientLayer.endPoint = direction.cgPoints.1
        gradientLayer.type = type
    }
}

