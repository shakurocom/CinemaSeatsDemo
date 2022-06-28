//
//  MovieInfo.swift
//  ShakuroApp

import UIKit

enum Time: String, CaseIterable {
    case time1 = "7:30 PM"
    case time2 = "9:30 PM"
    case time3 = "11:30 PM"
    case time4 = "13:30 PM"
    case time5 = "15:30 PM"
}

struct MovieInfo {
    let title: String?
    let country: String
    let date: String
    let address: String
    let sheduleDates: [Time]
}

extension MovieInfo {

    static func generateInfo() -> MovieInfo {
        return MovieInfo(title: NSLocalizedString("John Wick: Chapter 3 - Parabellum", comment: ""),
                         country: NSLocalizedString("USA, 2019 / 2h 10min", comment: ""),
                         date: NSLocalizedString("Friday, 17 May", comment: ""),
                         address: NSLocalizedString("AMC Lincoln Square 13", comment: ""),
                         sheduleDates: Time.allCases)
    }

}
