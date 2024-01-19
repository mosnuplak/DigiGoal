//
//  TitleWithBannerView.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import Foundation
import UIKit

class TitleWithBannerView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    var model: Display?
    
    struct Display {
        let title: String
        let images: [String]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibToView()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibToView()
        setupView()
    }
    
    func setupData(_ model: Display) {
        self.model = model
        self.titleLabel.text = model.title
    }
    
    func setupView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }
}

extension TitleWithBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setViewDisplay(.init(image: model?.images[indexPath.row]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 232, height: 132)
    }
}
