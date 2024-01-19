//
//  BannerCollectionViewCell.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    static let identifier: String = "BannerCollectionViewCell"
    
    struct Display {
        let image: String?
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setViewDisplay(_ model: Display) {
        bannerImageView.load(url: model.image ?? "")
    }
}
