//
//  SeatsSelector.swift
//  ShakuroApp

import UIKit

class Seat: HitTestButton {
    var row: Int = 0
    var column: Int = 0
    var isAvailable: Bool = true
    var isSelectedSeat: Bool = true
    var price: CGFloat = 0.0
}

/// Delegate of the seat selector.
protocol SeatSelectorDelegate: AnyObject {

    /// Called when a seat is selected.
    func seatSelected(_ seat: Seat)

    /// Transfers selected seats every time one seat is selected.
    func getSelectedSeats(_ seats: [Seat])
}

class SeatSelector: UIScrollView, UIScrollViewDelegate {

    private enum Constant {
        static let numberOfSeatsInRow: Int = 22
        static let verticalSpaceBetweenSeats: Int = 3
        static let horisontalSpaceBetweenSeats: Int = 1
        static let zoomScaleValueForChangeMode: CGFloat = 1.0
        static let hitTestInset: UIEdgeInsets = UIEdgeInsets(top: -8, left: -8, bottom: -8, right: -8)
    }

    weak var seatSelectorDelegate: SeatSelectorDelegate?
    var seatPrice: CGFloat = 10.0
    var selectedSeatLimit: Int = 0

    private var seatWidth: CGFloat = 20.0
    private var seatHeight: CGFloat = 20.0
    private var selectedSeats: [Seat] = []
    private var allSeats: [Seat] = []

    private var availableImage: UIImage?
    private var unavailableImage: UIImage?
    private var selectedImage: UIImage?

    private var zoomableView: UIView = UIView()

    private var isFirstLoad: Bool = true
    private var isZoomed: Bool = false

    private var screenLabel: UILabel?
    private var screenImageView: UIImageView?

    // MARK: - Init and Configuration

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
      }

    override func layoutSubviews() {
        super.layoutSubviews()

        // center content after zooming
        if isFirstLoad {
            isFirstLoad = false
            if let aViewForZooming = self.delegate?.viewForZooming?(in: self) {
                let aWidth = bounds.width
                let aHeight = bounds.height
                let aViewForZoomingWidth = aViewForZooming.frame.width
                let aViewForZoomingHeight = aViewForZooming.frame.height
                var aViewForZoomingFrame = aViewForZooming.frame

                if aViewForZoomingWidth < aWidth {
                    aViewForZoomingFrame.origin.x = (aWidth - aViewForZoomingWidth) / 2.0
                } else {
                    aViewForZoomingFrame.origin.x = 0
                }
                if aViewForZoomingHeight < aHeight {
                    aViewForZoomingFrame.origin.y = (aHeight - aViewForZoomingHeight) / 2.0
                } else {
                    aViewForZoomingFrame.origin.y = 0
                }
                aViewForZooming.frame = aViewForZoomingFrame
            }
        }
    }

    /// Sets the seat size.
    func setSeatSize(_ size: CGSize) {
        seatWidth = size.width
        seatHeight = size.height
    }

    /// Sets an array of available seats.
    func setupSeats(_ seats: [SeatModel]) {
        allSeats.forEach({ $0.removeFromSuperview() })
        allSeats.removeAll()

        var initialSeatX: Int = 0
        var initialSeatY: Int = 10
        var initialRow: Int = 1
        var initialColumn: Int = 1
        var finalWidth: Int = 0

        for index in 0...seats.count - 1 {
            let seatAtPosition = seats[index]

            switch seatAtPosition.type {
            case .available:
                initialSeatX += Constant.horisontalSpaceBetweenSeats
                createSeatButtonWithPosition(initialSeatX, initialSeatY: initialSeatY, initialRow: initialRow, initialColumn: initialColumn, isAvailable: true)
                initialSeatX += Constant.horisontalSpaceBetweenSeats
                initialColumn += 1

            case .unavailable:
                initialSeatX += Constant.horisontalSpaceBetweenSeats
                createSeatButtonWithPosition(initialSeatX, initialSeatY: initialSeatY, initialRow: initialRow, initialColumn: initialColumn, isAvailable: false)
                initialSeatX += Constant.horisontalSpaceBetweenSeats
                initialColumn += 1

            case .empty:
                initialSeatX += Constant.horisontalSpaceBetweenSeats + 1
                initialColumn += 1
            }

            // next row
            if index > 0 && (index + 1) % Constant.numberOfSeatsInRow == 0 {
                if initialSeatX > finalWidth {
                    finalWidth = initialSeatX
                }
                initialSeatX = 0
                initialColumn = 1
                initialSeatY += Constant.verticalSpaceBetweenSeats
                initialRow += 1
            }
        }

        if screenLabel == nil && screenImageView == nil {
            let label: UILabel = UILabel()
            label.font = CinemaStyleSheet.FontFace.poppinsRegular.fontWithSize(10.0)
            label.textColor = UIColor.white
            label.text = NSLocalizedString("SCREEN", comment: "")
            label.textAlignment = .center

            let imageView: UIImageView = UIImageView()
            imageView.image = CinemaSeatsBundleHelper.readImage(named: "CinemaScreen")

            zoomableView.frame = CGRect(x: 0, y: 0, width: CGFloat(finalWidth) * seatWidth, height: CGFloat(initialSeatY) * seatHeight)
            zoomableView.center = center
            contentSize = zoomableView.frame.size

            label.frame = CGRect(x: 0, y: 0, width: CGFloat(finalWidth) * seatWidth, height: 14)
            imageView.frame = CGRect(x: 0, y: 24, width: CGFloat(finalWidth) * seatWidth, height: 186)

            zoomableView.addSubview(label)
            zoomableView.addSubview(imageView)

            let newContentOffsetX: CGFloat = (contentSize.width - frame.size.width) / 2
            contentOffset = CGPoint(x: newContentOffsetX, y: 0)
            addSubview(zoomableView)

            screenLabel = label
            screenImageView = imageView
        }
    }

    /// Seat Images & Availability.
    func setSeatsImage(_ availableImage: UIImage?, unavailableImage: UIImage?, selectedImage: UIImage?) {
        self.availableImage = availableImage
        self.unavailableImage = unavailableImage
        self.selectedImage = selectedImage
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let subView = scrollView.subviews.first
        let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
        // adjust the center of image view
        subView?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)

        if (scrollView.zoomScale < Constant.zoomScaleValueForChangeMode && !isZoomed) || (scrollView.zoomScale > Constant.zoomScaleValueForChangeMode && isZoomed) {
            debugPrint(scrollView.zoomScale)
            changeMode()
            isZoomed.toggle()
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return subviews.first
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        debugPrint(scale)
    }

}

// MARK: - Private

private extension SeatSelector {

    func createSeatButtonWithPosition(_ initialSeatX: Int,
                                      initialSeatY: Int,
                                      initialRow: Int,
                                      initialColumn: Int,
                                      isAvailable available: Bool) {
        let seatButton = Seat(frame: CGRect(x: CGFloat(initialSeatX) * seatWidth,
                                            y: CGFloat(initialSeatY) * seatHeight,
                                            width: CGFloat(seatWidth),
                                            height: CGFloat(seatHeight)))

        seatButton.hitTestInset = Constant.hitTestInset
        seatButton.contentMode = .center
        seatButton.imageView?.contentMode = .scaleAspectFill

        if available {
            setSeatAsAvaiable(seatButton)
        } else {
            setSeatAsUnavaiable(seatButton)
        }
        seatButton.isAvailable = available
        seatButton.row = initialRow
        seatButton.column = initialColumn
        seatButton.price = seatPrice
        seatButton.addTarget(self, action: #selector(seatSelected(_:)), for: .touchUpInside)
        zoomableView.addSubview(seatButton)
        allSeats.append(seatButton)
    }

    // MARK: - Seat Selector Methods

    @objc func seatSelected(_ sender: Seat) {
        if !sender.isSelectedSeat && sender.isAvailable {
            if selectedSeatLimit != 0 {
                checkSeatLimitWithSeat(sender)
            } else {
                setSeatAsSelected(sender)
                selectedSeats.append(sender)
            }
        } else {
            if let index = selectedSeats.firstIndex(of: sender) {
                selectedSeats.remove(at: index)
            }
            if sender.isAvailable {
                setSeatAsAvaiable(sender)
            }
        }
        seatSelectorDelegate?.seatSelected(sender)
        seatSelectorDelegate?.getSelectedSeats(selectedSeats)
    }

    func checkSeatLimitWithSeat(_ sender: Seat) {
        if selectedSeats.count < selectedSeatLimit {
            setSeatAsSelected(sender)
            selectedSeats.append(sender)
        } else {
            let seatToMakeAvaiable: Seat = selectedSeats[0]
            setSeatAsAvaiable(seatToMakeAvaiable)
            selectedSeats.removeFirst()
            setSeatAsSelected(sender)
            selectedSeats.append(sender)
        }
    }

    func setSeatAsUnavaiable(_ sender: Seat) {
        if let index = allSeats.firstIndex(of: sender) {
            let seat: Seat = allSeats[index]
            seat.isAvailable = false
        }
        sender.setImage(unavailableImage, for: UIControl.State())
        sender.isSelectedSeat = false
    }

    func setSeatAsAvaiable(_ sender: Seat) {
        if let index = allSeats.firstIndex(of: sender) {
            let seat: Seat = allSeats[index]
            seat.isAvailable = true
        }
        sender.setImage(availableImage, for: UIControl.State())
        sender.isSelectedSeat = false
    }

    func setSeatAsSelected(_ sender: Seat) {
        if let index = allSeats.firstIndex(of: sender) {
            let seat: Seat = allSeats[index]
            seat.isSelectedSeat = true
        }
        sender.setImage(selectedImage, for: UIControl.State())
    }

    func changeMode() {
        if isZoomed {
            setSeatsImage(CinemaSeatsBundleHelper.readImage(named: "availableMidSeat"),
                          unavailableImage: CinemaSeatsBundleHelper.readImage(named: "unavailableMidSeat"),
                          selectedImage: CinemaSeatsBundleHelper.readImage(named: "selectedMidSeat"))
        } else {
            setSeatsImage(CinemaSeatsBundleHelper.readImage(named: "availableSeat"),
                          unavailableImage: CinemaSeatsBundleHelper.readImage(named: "unavailableSeat"),
                          selectedImage: CinemaSeatsBundleHelper.readImage(named: "selectedSeat"))
        }
        updateSeats()
    }

    func updateSeats() {
        allSeats.forEach { (seat) in
            if seat.isSelectedSeat {
                setSeatAsSelected(seat)
            } else if seat.isAvailable {
                setSeatAsAvaiable(seat)
            } else {
                setSeatAsUnavaiable(seat)
            }
        }
    }

}
