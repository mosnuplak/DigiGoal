//
//  HomeViewController.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet private weak var contentStackView: UIStackView!
    @IBOutlet private weak var goalCollectionView: UICollectionView!
    @IBOutlet private weak var totalGoalLabel: UILabel!
    @IBOutlet private weak var totalSavingLabel: UILabel!
    @IBOutlet private weak var addGoalButton: UIButton!
    
    var cancellables = Set<AnyCancellable>()
    
    let viewModel: HomeViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sinkData()
        viewModel.getGoalList()
        viewModel.getAllBanner()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGoalButton.layer.cornerRadius = 8
    }
    
    private func setupView() {
        goalCollectionView.delegate = self
        goalCollectionView.dataSource = self
        goalCollectionView.register(UINib(nibName: GoalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GoalCollectionViewCell.identifier)
    }
    
    private func sinkData() {
        viewModel.goalSubject.sink { [weak self] goalModel in
            self?.setupGoalSection(goalModel)
        }.store(in: &cancellables)
        
        viewModel.bannerSubject.sink { [weak self] goalModel in
            self?.setupBannerSection(goalModel)
        }.store(in: &cancellables)
    }
    
    private func setupGoalSection(_ model: GoalSectionDisplay?) {
        guard let model = model else { return }
        totalGoalLabel.text = model.totalGoal
        totalSavingLabel.text = model.totalSavingAmount
        goalCollectionView.reloadData()
    }
    
    private func setupBannerSection(_ model: BannerSectionDisplay?) {
        guard let model = model else { return }
        let bannerView: TitleWithBannerView = .init()
        bannerView.setupData(.init(title: model.title, images: model.images))
        contentStackView.addArrangedSubview(bannerView)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.goalListDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCollectionViewCell.identifier, for: indexPath) as? GoalCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.setViewDisplay(with: viewModel.goalListDisplay[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}
