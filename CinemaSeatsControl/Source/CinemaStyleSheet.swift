//
//  CinemaStyleSheet.swift
//  ShakuroApp

import UIKit

public enum CinemaStyleSheet {

    // MARK: - Colors

    enum Color {
        static let black: UIColor = UIColor.loadColorFromBundle(name: "TitleText") ?? .clear
        static let gray: UIColor = UIColor.loadColorFromBundle(name: "SubtitleText") ?? .clear
        static let background: UIColor = UIColor.loadColorFromBundle(name: "CinemaBackground") ?? .clear
        static let sheduleButtonBackground: UIColor = UIColor.loadColorFromBundle(name: "BlueButton") ?? .clear
    }

    // MARK: - Fonts

    enum FontFace: String {
        case poppinsRegular = "Poppins-Regular"
        case poppinsLight = "Poppins-Light"
        case poppinsMedium = "Poppins-Medium"
        case poppinsSemiBold = "Poppins-SemiBold"
        case poppinsBold = "Poppins-Bold"
    }
}

// MARK: - Helpers

extension CinemaStyleSheet.FontFace {

    func fontWithSize(_ size: CGFloat) -> UIFont {
        guard let actualFont: UIFont = UIFont(name: self.rawValue, size: size) else {
            debugPrint("Can't load font with name!!! \(self.rawValue)")
            return UIFont.systemFont(ofSize: size)
        }
        return actualFont
    }

}
