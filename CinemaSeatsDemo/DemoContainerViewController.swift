//
//  DemoContainerViewController.swift
//  ShakuroApp
//
//  Created by o on 05.08.2020.
//  Copyright © 2020 Shakuro. All rights reserved.
//

import Shakuro_iOS_Toolbox
import UIKit

class DemoContainerViewController: ContainerViewController {

    private enum Constant {
        static let minimumSize = CGSize(width: 375, height: 627)
    }

    @IBOutlet private var layoutContainer: UIView!

    private var isScalingEnabled: Bool = false

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.clipsToBounds = false
        layoutContainer.clipsToBounds = false
        if !isScalingEnabled {
            addMissingConstraints()
        }
        showDemo()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = containerView.bounds.size
        let layoutSize = layoutContainer.bounds.size
        if isScalingEnabled && (size.width > layoutSize.width || size.height > layoutSize.height) {
            let scale = min(layoutSize.width / size.width, layoutSize.height / size.height)
            containerView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }

    @IBAction private func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

    private func addMissingConstraints() {
        containerView.topAnchor.constraint(equalTo: layoutContainer.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: layoutContainer.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: layoutContainer.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: layoutContainer.trailingAnchor).isActive = true
    }

    private func showDemo() {
        let viewController = CinemaSeatsViewController.loadFromNib()
        let bgColor = UIColor(hex: "#FFFFFF")

        view.backgroundColor = bgColor
        containerView.backgroundColor = bgColor
        layoutContainer.backgroundColor = bgColor

        present(viewController, style: .fade, animated: false)
    }

}
