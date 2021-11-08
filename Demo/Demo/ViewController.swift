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
        let fancyView = FancyGradientView(colors: [UIColor.black, UIColor.blue], direction: .diagonalTopLeftBottomRight)
            .newAutoLayout()

        view.addSubview(fancyView)
        fancyView.pinEdges(to: view)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print(1)
            fancyView.animate(newColors: [UIColor.purple, UIColor.magenta], duration: 4)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(2)
            fancyView.animate(newColors: [UIColor.systemPink, UIColor.yellow], duration: 4)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            print(3)
            fancyView.animate(newColors: [UIColor.green, UIColor.black], duration: 4)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
            print(4)
            fancyView.animate(newDirection: .down, duration: 4)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            let uiLabel = UILabel().newAutoLayout()
            uiLabel.text = "Hi Athinakis 👋"
            uiLabel.textColor = .white
            uiLabel.alpha = 0
            self.view.addSubview(uiLabel)
            NSLayoutConstraint.activate([
                uiLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                uiLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])

            UIView.animate(withDuration: 1) {
                uiLabel.alpha = 1
            }
        }
    }
}
