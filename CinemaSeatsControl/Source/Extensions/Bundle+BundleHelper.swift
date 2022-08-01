//
// Bundle+BundleHelper.swift
//

import Foundation
import Shakuro_CommonTypes

extension Bundle {
    
    static let cinemaSeatsBundleHelper: BundleHelper = {
        let bundleHelper = BundleHelper(targetClass: CinemaSeatsViewController.self, bundleName: "CinemaSeats")
        let fonts: [(fontName: String, fontExtension: String)] = [
            (fontName: "Poppins-Bold", fontExtension: "ttf"),
            (fontName: "Poppins-Light", fontExtension: "ttf"),
            (fontName: "Poppins-Medium", fontExtension: "ttf"),
            (fontName: "Poppins-SemiBold", fontExtension: "ttf"),
            (fontName: "Poppins-Regular", fontExtension: "ttf")
        ]
        bundleHelper.registerFonts(fonts)
        return bundleHelper
    }()

}
