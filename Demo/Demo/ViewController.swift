//
//  ViewController.swift
//  Demo
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import UIKit
import FancyGradient

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Add the fancyView in screen*/
        let fancyView = FancyGradientView(colors: [UIColor.black, UIColor.blue], direction: .diagonalTopLeftBottomRight, type: .axial)
            .newAutoLayout()

        view.addSubview(fancyView)
        fancyView.pinEdges(to: view)

        let myCustomAnimation = CustomAnimation()
            .then(EmptyAnimation(duration: 2)) // Delay
            .then(DirectionAnimation(newDirection: .right, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalBottomLeftTopRight, duration: 1))
            .then(DirectionAnimation(newDirection: .up, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalBottomRightTopLeft, duration: 1))
            .then(DirectionAnimation(newDirection: .left, duration: 1))
            .then(ColorAnimation(newColors: [UIColor.blue, UIColor.cyan], duration: 3))
            .then(ColorAnimation(newColors: [UIColor.blue, UIColor.green], duration: 3))

        fancyView.animate(animation: myCustomAnimation)

    }
}
