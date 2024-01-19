//
//  GoalCollectionViewCell.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var viewBackground: UIView!
    @IBOutlet private weak var goalImage: UIImageView!
    @IBOutlet private weak var currentAmountLabel: UILabel!
    @IBOutlet private weak var expectedAmountLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var goalMessageLabel: UILabel!
    @IBOutlet private weak var goalStatusLabel: UILabel!
    @IBOutlet private weak var goalDayLeftLabel: UILabel!
    static let identifier: String = "GoalCollectionViewCell"
    
    struct Display {
        let goalType: GoalType
        let goalStatus: GoalStatus
        let currentAmount: String
        let expectedAmount: String
        var goalMessage: String?
        var goalProgress: Double
        let goalDayLeft: String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 1)
        progressView.tintColor = #colorLiteral(red: 0.7889479399, green: 0.3668174744, blue: 0.2804781497, alpha: 1)
        goalImage.tintColor = #colorLiteral(red: 0.7889479399, green: 0.3668174744, blue: 0.2804781497, alpha: 1)
        progressView.backgroundColor = #colorLiteral(red: 0.1960784197, green: 0.1960784197, blue: 0.1960784197, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 0
        progressView.subviews[1].clipsToBounds = true
        viewBackground.layer.cornerRadius = 8
        viewBackground.layer.borderWidth = 2
    }

    func setViewDisplay(with display: Display) {
        goalImage.image = display.goalType.image
        currentAmountLabel.text = display.currentAmount
        expectedAmountLabel.text = display.expectedAmount
        goalMessageLabel.text = display.goalMessage
        goalStatusLabel.text = display.goalStatus.message
        progressView.progress = Float(display.goalProgress)
        goalStatusLabel.textColor = display.goalStatus.color
        goalDayLeftLabel.text = display.goalDayLeft
        viewBackground.layer.borderColor = display.goalStatus.color.cgColor
    }
}
