//
//  ViewController.swift
//  Demo
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 24/12/21.
//

import UIKit
import FancyGradient

class ViewController: UIViewController {
    var fancyView: FancyGradientView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Add the fancyView in screen*/
        fancyView = FancyGradientView(colors: [UIColor.blue, UIColor.green],
                                      direction: .down,
                                      colorStops: [0, 1],
                                      type: .axial).newAutoLayout()
        fancyView.delegate = self

        view.addSubview(fancyView)
        fancyView.pinEdges(to: view)

        // Enable one at a time!
        demo()
//        demo2()
//        demo3()
//        demo4()
//        demo5()
    }

    func demo() {
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(EmptyAnimation(duration: 0.5))
            .then(ColorStopsAnimation(colorStops: [1, 1], duration: 1))
            .then(DirectionAnimation(newDirection: .down, duration: 0.3))
            .then(CombineAnimation(
                ColorAnimation(newColors: [.init(hexString: "#fa709a"), .init(hexString: "#fee140")], duration: 1),
                ColorStopsAnimation(colorStops: [0.1, 0.9], duration: 1)
            ))
            .then(ColorStopsAnimation(colorStops: [1, 1], duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalTopLeftBottomRight, duration: 0.3))
            .then(CombineAnimation(
                ColorAnimation(newColors: [.init(hexString: "#00bf8f"), .init(hexString: "#001510")], duration: 3),
                ColorStopsAnimation(colorStops: [0.2, 0.8], duration: 3)
            ))
            .then(DirectionAnimation(newDirection: .down, duration: 1))
            .then(ColorStopsAnimation(colorStops: [0.1, 0.9], duration: 1))

        fancyView.animate(animation: myCustomAnimation)
    }

    func demo2() {
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(DirectionAnimation(newDirection: .diagonalTopRightBottomLeft, duration: 1))
            .then(DirectionAnimation(newDirection: .left, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalBottomRightTopLeft, duration: 1))
            .then(DirectionAnimation(newDirection: .up, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalBottomLeftTopRight, duration: 1))
            .then(DirectionAnimation(newDirection: .right, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalTopLeftBottomRight, duration: 1))
            .then(DirectionAnimation(newDirection: .down, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalTopRightBottomLeft, duration: 1))
            .then(DirectionAnimation(newDirection: .left, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalBottomRightTopLeft, duration: 1))
            .then(DirectionAnimation(newDirection: .up, duration: 0.5))
            .then(DirectionAnimation(newDirection: .diagonalBottomLeftTopRight, duration: 1))
            .then(DirectionAnimation(newDirection: .right, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalTopLeftBottomRight, duration: 1))
            .then(DirectionAnimation(newDirection: .down, duration: 1))

        fancyView.animate(animation: myCustomAnimation)
    }


    func demo3() {
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(EmptyAnimation(duration: 1)) // delay 1 second
            .then(DirectionAnimation(newDirection: .up, duration: 3))
        fancyView.animate(animation: myCustomAnimation)
    }

    func demo4() {
        let myCustomAnimation = CustomAnimation()
            .then(EmptyAnimation(duration: 1)) // Delay 1 second
            .then(ColorAnimation(newColors: [UIColor.blue, UIColor.cyan], duration: 3))
            .then(ColorAnimation(newColors: [UIColor.cyan, UIColor.blue], duration: 3))
            .then(ColorAnimation(newColors: [UIColor.purple, UIColor.blue, UIColor.black], duration: 3))
            .then(DirectionAnimation(newDirection: .up, duration: 2))
        fancyView.animate(animation: myCustomAnimation)
    }


    func demo5() {
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(EmptyAnimation(duration: 1)) // Delay 1 second
            .then(
                CombineAnimation(
                    DirectionAnimation(newDirection: .right, duration: 1),
                    ColorAnimation(newColors: [UIColor.black, UIColor.green], duration: 3)
                )
            )
            .then(DirectionAnimation(newDirection: .right, duration: 2))
            .then(DirectionAnimation(newDirection: .diagonalBottomLeftTopRight, duration: 2))
        fancyView.animate(animation: myCustomAnimation)
    }
}

extension ViewController: FancyGradientViewDelegate {
    func animationDidFinished(animId: String) {
        print("Finished animation \(animId)")
    }
}

