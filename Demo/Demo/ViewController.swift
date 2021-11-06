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


        /** Configure Viewmodel */
        let gradientDirection = FancyGradientView.ViewModel.Direction(startPoint: CGPoint(x: 0, y: 0),
                                                                      endPoint: CGPoint(x: 1, y: 0))
        let colors = [UIColor.red, UIColor.green]
        let model = FancyGradientView.ViewModel(direction: gradientDirection,
                                                colors: colors)

        /** Add the fancyView in screen*/
        let fancyView = FancyGradientView(model: model).newAutoLayout()
        view.addSubview(fancyView)
        fancyView.pinEdges(to: view)
    }
}
