//
//  ViewController.swift
//  Demo
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import UIKit
import FancyGradient

class ViewController: UIViewController {
    var fancyView: FancyGradientView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Add the fancyView in screen*/
        fancyView = FancyGradientView(colors: [UIColor.black, UIColor.orange], direction: .diagonalTopLeftBottomRight, type: .axial)
            .newAutoLayout()
        fancyView.delegate = self

        view.addSubview(fancyView)
        fancyView.pinEdges(to: view)


        // Enable one at a time!
//        playExampleAnimation1()
//        playExampleAnimation2()
//        playExampleAnimation3()
//        playExampleAnimation4()
        playExampleAnimation5()
    }


    func playExampleAnimation1() {
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(EmptyAnimation(duration: 1)) // Delay 1 second
            .then(DirectionAnimation(newDirection: .right, duration: 2))
        fancyView.animate(animation: myCustomAnimation)
    }

    func playExampleAnimation2() { // This is like the direction does a full cycle
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(EmptyAnimation(duration: 1)) // Delay 1 second
            .then(DirectionAnimation(newDirection: .right, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalBottomLeftTopRight, duration: 1))
            .then(DirectionAnimation(newDirection: .up, duration: 1))
            .then(DirectionAnimation(newDirection: .diagonalBottomRightTopLeft, duration: 1))
            .then(DirectionAnimation(newDirection: .left, duration: 1))
        fancyView.animate(animation: myCustomAnimation)
    }


    func playExampleAnimation3() {
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(EmptyAnimation(duration: 1)) // Delay 1 second
            .then(ColorAnimation(newColors: [UIColor.blue, UIColor.cyan], duration: 3))
            .then(ColorAnimation(newColors: [UIColor.cyan, UIColor.blue], duration: 3))
            .then(ColorAnimation(newColors: [UIColor.purple, UIColor.blue, UIColor.black], duration: 3))
        fancyView.animate(animation: myCustomAnimation)
    }


    func playExampleAnimation4() {
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

    func playExampleAnimation5() {
        let myCustomAnimation = CustomAnimation(animID: "myAnimationID")
            .then(EmptyAnimation(duration: 1)) // Delay 1 second
            .then(ColorAnimation(newColors: [UIColor.black, UIColor.green], duration: 1))
            .then(ColorAnimation(newColors: [UIColor.black, UIColor.black, UIColor.green], duration: 1))
            .then(ColorAnimation(newColors: [UIColor.black, UIColor.green], duration: 1))
            .then(ColorAnimation(newColors: [UIColor.black, UIColor.black, UIColor.green], duration: 1))
            .then(ColorAnimation(newColors: [UIColor.black, UIColor.green], duration: 1))
        fancyView.animate(animation: myCustomAnimation)
    }
}

extension ViewController: FancyGradientViewDelegate {
    func animationDidFinished(animId: String) {
        print("Finished animation \(animId)")
    }
}
