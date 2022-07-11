//
//  CinemaStyleSheet.swift
//  ShakuroApp

import UIKit

public enum CinemaStyleSheet {

    // MARK: - Colors

    enum Color {
        static let black: UIColor = CinemaSeatsBundleHelper.readColor(named: "TitleText") ?? .clear
        static let gray: UIColor = CinemaSeatsBundleHelper.readColor(named: "SubtitleText") ?? .clear
        static let background: UIColor = CinemaSeatsBundleHelper.readColor(named: "CinemaBackground") ?? .clear
        static let sheduleButtonBackground: UIColor = CinemaSeatsBundleHelper.readColor(named: "BlueButton") ?? .clear
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
