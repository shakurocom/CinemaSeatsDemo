//
//  SeatModel.swift
//  ShakuroApp

import UIKit

class SeatModel {

    enum SeatType {
        case available
        case unavailable
        case empty
    }

    var type: SeatType
    let image: UIImage?
    let currency: CGFloat?

    init(type: SeatType, image: UIImage? = nil, currency: CGFloat? = nil) {
        self.type = type
        self.image = image
        self.currency = currency
    }

    static func generate(for time: Time) -> [SeatModel] {
        // swiftlint:disable identifier_name
        let a = SeatModel(type: .available, image: Bundle.cinemaSeatsBundleHelper.image(named: "availableSeat"), currency: 10)
        let u = SeatModel(type: .unavailable, image: Bundle.cinemaSeatsBundleHelper.image(named: "unavailableSeat"), currency: 10)
        let e = SeatModel(type: .empty)

        switch time {
        case .time1:
            return [e, e, e, e, e, a, a, a, u, a, a, a, a, a, a, a, a, e, e, e, e, e,
                    e, e, e, e, a, a, a, a, u, a, a, u, a, a, a, a, a, a, e, e, e, e,
                    e, e, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, e, e,
                    e, a, a, a, a, a, a, a, u, u, u, u, u, u, a, a, a, a, a, a, a, e,
                    a, a, a, a, a, a, a, a, u, u, u, u, u, u, u, u, u, u, a, a, a, a,
                    a, a, a, a, a, a, a, a, u, u, u, u, u, u, u, u, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    e, e, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, e, e,
                    e, e, e, e, e, a, a, a, u, a, a, a, a, a, a, a, a, e, e, e, e, e]
        case .time2:
            return [e, e, e, e, e, a, a, a, u, a, a, a, a, a, a, a, a, e, e, e, e, e,
                    e, e, e, e, a, a, a, a, u, a, a, u, a, a, a, a, a, a, e, e, e, e,
                    e, e, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, e, e,
                    e, a, a, a, a, a, a, a, u, u, u, u, u, u, a, a, a, a, a, a, a, e,
                    a, a, a, a, a, a, a, a, u, u, u, u, u, u, u, u, u, u, a, a, a, a,
                    u, a, a, a, a, a, a, a, u, u, u, u, u, u, u, u, a, a, a, a, a, u,
                    u, u, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, u, u,
                    u, u, u, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, u, u, u,
                    u, u, u, u, a, a, a, a, u, a, a, a, a, a, a, a, a, a, u, u, u, u,
                    u, u, u, u, u, a, a, a, u, a, a, a, a, a, a, a, a, u, u, u, u, u]
        case .time3:
            return [e, e, e, e, e, a, a, a, a, a, a, a, a, a, a, a, a, e, e, e, e, e,
                    e, e, e, e, a, a, a, a, a, a, a, a, a, a, a, a, a, a, e, e, e, e,
                    e, e, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, e, e,
                    e, a, a, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, e,
                    a, a, a, a, a, a, a, a, a, u, u, u, u, u, u, u, u, u, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    e, e, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, e, e,
                    e, e, e, e, e, a, a, a, a, a, a, a, a, a, a, a, a, e, e, e, e, e]
        case .time4:
            return [e, e, e, e, e, a, a, a, u, a, a, a, a, a, a, a, a, e, e, e, e, e,
                    e, e, e, e, a, a, a, a, u, a, a, u, a, a, a, a, a, a, e, e, e, e,
                    e, e, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, e, e,
                    e, a, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, a, e,
                    a, a, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    u, u, u, u, u, u, u, u, u, u, u, u, u, u, u, u, u, u, u, u, u, u,
                    a, a, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    e, e, a, a, a, a, a, a, u, a, a, a, a, a, a, a, a, a, a, a, e, e,
                    e, e, e, e, e, a, a, a, u, a, a, a, a, a, a, a, a, e, e, e, e, e]
        case .time5:
            return [a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a,
                    a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a]
        }
    }

}
