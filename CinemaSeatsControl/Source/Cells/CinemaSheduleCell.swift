//
//  CinemaSeatsSheduleCell.swift
//  ShakuroApp

import UIKit

class CinemaSheduleCell: UICollectionViewCell {

    @IBOutlet private var timeTitle: UILabel!

    var selectedTintColor: UIColor? = CinemaStyleSheet.Color.sheduleButtonBackground
    var normalTintColor: UIColor? = UIColor.white

    override var isSelected: Bool {
        didSet {
            if let selectedTint = selectedTintColor, let normalTint = normalTintColor {
                timeTitle.textColor = isSelected ? .white : .black
                backgroundColor = isSelected ? selectedTint : normalTint
                layer.shadowColor = isSelected ? UIColor(red: 0.188, green: 0.31, blue: 0.996, alpha: 0.3).cgColor : UIColor.clear.cgColor
            }
        }
    }

    var title: String? {
        get {
            return timeTitle.text
        }
        set {
            timeTitle.text = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        timeTitle.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(14.0)
        timeTitle.minimumScaleFactor = 0.5

        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = isSelected ? UIColor(red: 0.188, green: 0.31, blue: 0.996, alpha: 0.3).cgColor : UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }

}
