//
//  TicketInfoCell.swift
//  ShakuroApp

import UIKit

class TicketInfoCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(14)
        titleLabel.textColor = CinemaSeatsBundleHelper.readColor(named: "Cinema400")
        subtitleLabel.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(14)
        subtitleLabel.textColor = CinemaSeatsBundleHelper.readColor(named: "cDark")
    }

    func setInfo(info: Info?) {
        titleLabel.text = info?.title
        subtitleLabel.text = info?.value
    }

    func setUI() {
        titleLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(16)
        titleLabel.textColor = CinemaSeatsBundleHelper.readColor(named: "cDark")
        subtitleLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(16)
        subtitleLabel.textColor = CinemaSeatsBundleHelper.readColor(named: "cDark")
    }

}
