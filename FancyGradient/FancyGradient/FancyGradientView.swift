//
//  FancyGradientView.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import Foundation
import UIKit

public final class FancyGradientView: UIView {
    /** Contains all the UI configuration */
    private let model: ViewModel

    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }

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
