//
//  CinemaSeatsViewController.swift
//  ShakuroApp

import Foundation
import UIKit

class CinemaSeatsViewController: UIViewController, BaseViewControllerProtocol, SeatSelectorDelegate {

    struct Option {
        let info: MovieInfo
    }

    private enum Constant {
        static let minimumFontScale: CGFloat = 0.5
        static let maximumFontScale: CGFloat = 3.5
        static let seatPrice: CGFloat = 10.0
    }

    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var buyButton: UIButton!

    @IBOutlet private var seatSelector: SeatSelector!
    @IBOutlet private var container1View: UIView!
    @IBOutlet private var container2View: UIView!
    @IBOutlet private var contentContainer: UIStackView!

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var countryLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var currencyLabel: UILabel!
    @IBOutlet private var ticketNumberLabel: UILabel!

    @IBOutlet private var availableLabel: UILabel!
    @IBOutlet private var selectedLabel: UILabel!

    private weak var appRouter: RoutingSupport?
    private var info: MovieInfo!
    private var currency: CGFloat = 0
    private var convinience: CGFloat = 0
    private var selectedSeats: Int = 0
    private var selectedTimeIndex: Int = 0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buyButton.isHidden = true

        setupFonts()
        setupColors()
        setupValues()
        setupSeats()
        setupViews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.seatSelector.setZoomScale(Constant.minimumFontScale, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - SeatSelectorDelegate

    func seatSelected(_ seat: Seat) {
        print("Seat at row: \(seat.row) and column: \(seat.column)\n")
    }

    func getSelectedSeats(_ seats: [Seat]) {
        currency = 0
        convinience = 0
        seats.forEach { (seat) in
            self.currency += CGFloat(seat.price)
            self.convinience += 2
        }
        currencyLabel.text = "\(currency)" + " USD"
        ticketNumberLabel.text = NSLocalizedString(" for", comment: "") + " \(seats.count) " + NSLocalizedString("tickets", comment: "")
        selectedSeats = seats.count
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CinemaSeatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.sheduleDates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CinemaSheduleCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.cinemaSheduleCell.identifier, for: indexPath)
        cell.title = info.sheduleDates[indexPath.item].rawValue
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTimeIndex = indexPath.item
        seatSelector.setupSeats(SeatModel.generate(for: info.sheduleDates[selectedTimeIndex]))
    }

}

// MARK: - Private

private extension CinemaSeatsViewController {

    func setupViews() {
        buyButton.setTitle(NSLocalizedString("Buy", comment: ""), for: .normal)
        buyButton.layer.cornerRadius = 6

        container1View.clipsToBounds = true
        container1View.layer.cornerRadius = 32
        container1View.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        container2View.clipsToBounds = true
        container2View.layer.cornerRadius = 16
        container2View.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 98, height: 40)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 24
        let collectionFrame = CGRect(origin: .zero,
                                     size: CGSize(width: layout.itemSize.width,
                                                  height: layout.itemSize.height + layout.sectionInset.bottom + layout.sectionInset.top))

        let cinemaSheduleCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        cinemaSheduleCollectionView.clipsToBounds = false
        cinemaSheduleCollectionView.showsVerticalScrollIndicator = false
        cinemaSheduleCollectionView.showsHorizontalScrollIndicator = false
        cinemaSheduleCollectionView.backgroundColor = UIColor.clear
        cinemaSheduleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cinemaSheduleCollectionView.register(R.nib.cinemaSheduleCell)

        let cinemaSheduleContainer = UIView(frame: cinemaSheduleCollectionView.bounds)
        cinemaSheduleContainer.backgroundColor = UIColor.clear
        cinemaSheduleContainer.clipsToBounds = false
        cinemaSheduleContainer.translatesAutoresizingMaskIntoConstraints = false
        cinemaSheduleContainer.heightAnchor.constraint(equalToConstant: collectionFrame.size.height).isActive = true

        cinemaSheduleContainer.addSubview(cinemaSheduleCollectionView)
        contentContainer.addArrangedSubview(cinemaSheduleContainer)

        cinemaSheduleCollectionView.topAnchor.constraint(equalTo: cinemaSheduleContainer.topAnchor).isActive = true
        cinemaSheduleCollectionView.bottomAnchor.constraint(equalTo: cinemaSheduleContainer.bottomAnchor).isActive = true
        cinemaSheduleCollectionView.leadingAnchor.constraint(equalTo: cinemaSheduleContainer.leadingAnchor, constant: 0).isActive = true
        cinemaSheduleCollectionView.trailingAnchor.constraint(equalTo: cinemaSheduleContainer.trailingAnchor, constant: 32).isActive = true

        cinemaSheduleCollectionView.delegate = self
        cinemaSheduleCollectionView.dataSource = self

        if selectedTimeIndex < info.sheduleDates.count {
            cinemaSheduleCollectionView.selectItem(at: IndexPath(row: selectedTimeIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }

    func setupFonts() {
        buyButton.titleLabel?.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(16.0)
        titleLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18.0)
        countryLabel.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(12.0)
        dateLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18.0)
        addressLabel.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(12.0)
        currencyLabel.font = CinemaStyleSheet.FontFace.poppinsBold.fontWithSize(16.0)
        ticketNumberLabel.font = CinemaStyleSheet.FontFace.poppinsRegular.fontWithSize(16.0)
        availableLabel.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(12.0)
        selectedLabel.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(12.0)
    }

    func setupColors() {
        view.backgroundColor = CinemaStyleSheet.Color.background
        buyButton.tintColor = UIColor.white
        titleLabel.textColor = CinemaStyleSheet.Color.black
        countryLabel.textColor = CinemaStyleSheet.Color.gray
        dateLabel.textColor = CinemaStyleSheet.Color.black
        addressLabel.textColor = CinemaStyleSheet.Color.gray
        currencyLabel.textColor = UIColor.white
        ticketNumberLabel.textColor = UIColor.white
    }

    func setupValues() {
        info = MovieInfo.generateInfo()
        titleLabel.text = info.title
        countryLabel.text = info.country
        dateLabel.text = info.date
        addressLabel.text = info.address
        currencyLabel.text = "0.0 USD"
        ticketNumberLabel.text = NSLocalizedString(" for", comment: "") + " 0 " + NSLocalizedString("tickets", comment: "")
    }

    func setupSeats() {
        seatSelector.setSeatSize(CGSize(width: 10, height: 10))
        seatSelector.setSeatsImage(UIImage.loadImageFromBundle(name: "availableSeat"), unavailableImage: UIImage.loadImageFromBundle(name: "unavailableSeat"), selectedImage: UIImage.loadImageFromBundle(name: "selectedSeat"))
        seatSelector.setupSeats(SeatModel.generate(for: info.sheduleDates[selectedTimeIndex]))
        seatSelector.seatSelectorDelegate = self
        seatSelector.minimumZoomScale = Constant.minimumFontScale
        seatSelector.maximumZoomScale = Constant.maximumFontScale
        seatSelector.seatPrice = Constant.seatPrice
    }

    // MARK: Actions

    @IBAction func backButtonPressed(_ sender: UIButton) {
        appRouter?.appRouter.dismissViewController(self, animated: true)
    }

    @IBAction func buyButtonPressed(_ sender: UIButton) {

        let paymentInfo: [Info] = [Info(title: NSLocalizedString("Movie", comment: ""), value: info.title),
                                   Info(title: NSLocalizedString("Movie Theater", comment: ""), value: info.address),
                                   Info(title: NSLocalizedString("Date & Time", comment: ""), value: info.date),
                                   Info(title: NSLocalizedString("Place", comment: ""), value: "Hall B, series 7, place 7, 8th")]

        let ticketInfo: [Info] = [Info(title: NSLocalizedString("\(selectedSeats) tickets", comment: ""), value: "\(currency) USD"),
                                 Info(title: NSLocalizedString("Convenience fee", comment: ""), value: "\(convinience) USD"),
                                 Info(title: NSLocalizedString("Total", comment: ""), value: "\(currency + convinience) USD")]

        _ = appRouter?.presentViewController(type: PaymentViewController.self,
                                             options: PaymentViewController.Option(paymentInfo: paymentInfo, ticketInfo: ticketInfo),
                                             from: self,
                                             style: .modalDefault,
                                             animated: true)
    }

}
