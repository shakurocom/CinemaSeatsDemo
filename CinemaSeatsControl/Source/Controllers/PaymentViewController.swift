//
//  PaymentViewController.swift
//  ShakuroApp

import Shakuro_CommonTypes
import UIKit

class Info {
    let title: String?
    let value: String?

    init(title: String?, value: String?) {
        self.title = title
        self.value = value
    }
}

class PaymentViewController: UIViewController {

    struct Option {
        let paymentInfo: [Info]
        let ticketInfo: [Info]
    }

    @IBOutlet private var topView: UIView!
    @IBOutlet private var topLabel: UILabel!
    @IBOutlet private var confirmButton: ContentModeSelectButton!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var scrollView: UIScrollView!

    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var infoTableView: UITableView!

    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var summaryTableView: UITableView!

    @IBOutlet private var contactDetailsView: UIView!
    @IBOutlet private var contactDetailsLabel: UILabel!
    @IBOutlet private var contactDetailsValueLabel: UILabel!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var telephoneTextField: UITextField!

    @IBOutlet private var paymentLabel: UILabel!
    @IBOutlet private var paymentView: UIView!
    @IBOutlet private var privacyLabel: UILabel!

    @IBOutlet private var infoTableViewHeight: NSLayoutConstraint!
    @IBOutlet private var summaryTableViewHeight: NSLayoutConstraint!
    @IBOutlet private var contentViewBottomConstraint: NSLayoutConstraint!

    var paymentInfo: [Info] = []
    var ticketInfo: [Info] = []

    private var keyboardHandler: KeyboardHandler?

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never
        setupUI()
        setActorData()

        keyboardHandler = KeyboardHandler(enableCurveHack: true, heightDidChange: { [weak self] (change: KeyboardHandler.KeyboardChange) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.contentViewBottomConstraint.constant = change.newHeight
            strongSelf.view.layoutIfNeeded()
        })

        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        keyboardHandler?.isActive = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.endEditing(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboardHandler?.isActive = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        infoTableViewHeight.constant = infoTableView.contentSize.height
        summaryTableViewHeight.constant = summaryTableView.contentSize.height
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PaymentViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case infoTableView:
            return paymentInfo.count
        case summaryTableView:
            return ticketInfo.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === infoTableView {
            let cell: InfoCell = tableView.dequeueReusableCell(indexPath: indexPath, reuseIdentifier: "InfoCell")
            cell.setInfo(info: paymentInfo[indexPath.row])
            return cell
        } else {
            let cell: TicketInfoCell = tableView.dequeueReusableCell(indexPath: indexPath, reuseIdentifier: "TicketInfoCell")
            cell.setInfo(info: ticketInfo[indexPath.row])
            if indexPath.row == ticketInfo.count - 1 {
                cell.setUI()
            }
            return cell
        }
    }
}

// MARK: - UITextFieldDelegate

extension PaymentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return false
    }
}

// MARK: - Actions

private extension PaymentViewController {

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

}

// MARK: - Private

private extension PaymentViewController {

    private func setupUI() {
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 32
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        let bundle: Bundle
        if let podBundleURL = Bundle(for: PaymentViewController.self).url(forResource: "CinemaSeats", withExtension: "bundle"),
           let podBundle = Bundle(url: podBundleURL) {
            bundle = podBundle
        } else {
            bundle = Bundle.main
        }
        infoTableView.register(UINib(nibName: "InfoCell", bundle: bundle), forCellReuseIdentifier: "InfoCell")
        infoTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: infoTableView.frame.size.width, height: 1))
        infoTableView.tableFooterView?.backgroundColor = UIColor.white
        infoTableView.layer.cornerRadius = 8

        summaryTableView.register(UINib(nibName: "TicketInfoCell", bundle: bundle), forCellReuseIdentifier: "TicketInfoCell")
        summaryTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: summaryTableView.frame.size.width, height: 1))
        summaryTableView.tableFooterView?.backgroundColor = UIColor.white
        summaryTableView.layer.cornerRadius = 8

        contactDetailsView.layer.cornerRadius = 8
        paymentView.layer.cornerRadius = 8

        infoLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18)
        summaryLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18)
        contactDetailsLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18)
        paymentLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18)
        emailTextField.font = CinemaStyleSheet.FontFace.poppinsRegular.fontWithSize(14)
        telephoneTextField.font = CinemaStyleSheet.FontFace.poppinsRegular.fontWithSize(14)
        contactDetailsValueLabel.font = CinemaStyleSheet.FontFace.poppinsRegular.fontWithSize(12)
        summaryLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18)

        topLabel.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(18)
        backButton.titleLabel?.font = CinemaStyleSheet.FontFace.poppinsMedium.fontWithSize(16)
        confirmButton.titleLabel?.font = CinemaStyleSheet.FontFace.poppinsSemiBold.fontWithSize(16)
        confirmButton.isSelected = true
    }

    private func setActorData() {
        infoLabel.text = "Details"
        summaryLabel.text = NSLocalizedString("Summary", comment: "")
        contactDetailsLabel.text = NSLocalizedString("Contact details", comment: "")
        contactDetailsValueLabel.text = NSLocalizedString("Enter an email or phone number to send you information about ordering", comment: "")
        paymentLabel.text = NSLocalizedString("Payment", comment: "")
        topLabel.text = NSLocalizedString("Payment", comment: "")
        privacyLabel.text = NSLocalizedString("I have read and accept the Terms of Service and Privacy Policy", comment: "")

        backButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        confirmButton.setTitle(NSLocalizedString("Confirm & Pay", comment: ""), for: .normal)
    }
}
