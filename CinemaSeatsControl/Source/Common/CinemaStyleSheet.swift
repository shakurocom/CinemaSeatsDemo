//
//  CinemaStyleSheet.swift
//  ShakuroApp

import UIKit

public enum CinemaStyleSheet {

    // MARK: - Colors

    enum Color {
        static let black: UIColor = CinemaSeatsBundleHelper.color(named: "TitleText") ?? .clear
        static let gray: UIColor = CinemaSeatsBundleHelper.color(named: "SubtitleText") ?? .clear
        static let background: UIColor = CinemaSeatsBundleHelper.color(named: "CinemaBackground") ?? .clear
        static let sheduleButtonBackground: UIColor = CinemaSeatsBundleHelper.color(named: "BlueButton") ?? .clear
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
