//
//  UIImage+Bundle.swift
//
//  Created by Eugene Klyuenkov.
//

import UIKit

public extension UIImage {

    static func loadImageFromBundle(name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle.findBundleIfNeeded(for: CinemaSeatsViewController.self), compatibleWith: nil)
    }

}
