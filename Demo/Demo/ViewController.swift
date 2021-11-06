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


        // MARK: Configure Viewmodel
        let gradientDirection = FancyGradientView.ViewModel.Direction(startPoint: CGPoint(x: 0, y: 1),
                                                                      endPoint: CGPoint(x: 1, y: 1))
        let colors = [UIColor.blue, UIColor.purple,  UIColor.systemPink]
        let model = FancyGradientView.ViewModel(direction: gradientDirection,
                                                colors: colors)

        // MARK: Add the fancyView in screen*/
        let fancyView = FancyGradientView(model: model).newAutoLayout()
        view.addSubview(fancyView)
        fancyView.pinEdges(to: view)
        fancyView.animate(with: .cycle(duration: 4))
    }
}
