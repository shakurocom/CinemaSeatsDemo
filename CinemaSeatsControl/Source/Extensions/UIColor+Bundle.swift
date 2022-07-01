//
//  UIColor+Bundle.swift
//
//  Created by Eugene Klyuenkov.
//

import UIKit

extension UIColor {

    static func loadColorFromBundle(name: String) -> UIColor? {
        return UIColor(named: name, in: Bundle.findBundleIfNeeded(for: CinemaSeatsViewController.self), compatibleWith: nil)
    }

}
