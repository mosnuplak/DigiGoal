//
//  HomeViewModel.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import Foundation
import Combine

class HomeViewModel {
    var goalSubject = CurrentValueSubject<GoalSectionDisplay?, Never>(nil)
    var bannerSubject = PassthroughSubject<BannerSectionDisplay, Never>()
    var goalListDisplay: [GoalCollectionViewCell.Display] = []
    
    func getGoalList() {
        // You can change value goalList by API call
        var goalList: [GoalModel] = []
        goalList.append(.init(type: "clothing", currentAmount: 500, expectedAmount: 1000, title: "แฟชั่น", status: "good", dayLeft: "45"))
        goalList.append(.init(type: "travel", currentAmount: 500, expectedAmount: 5000, title: "ไปบ้านยาย", status: "unhappy", dayLeft: "100"))
        goalList.append(.init(type: "invest", currentAmount: 500, expectedAmount: 500, title: "อาหารแมว", status: "good", dayLeft: "11"))
        goalList.append(.init(type: "education", currentAmount: 500, expectedAmount: 2000, title: "เรียน", status: "unhappy", dayLeft: "55"))
        
        // Map display
        goalListDisplay = goalList.map({
            .init(goalType: GoalType.toEnum($0.type),
                  goalStatus: GoalStatus.toEnum($0.status),
                  currentAmount: "\($0.currentAmount) THB",
                  expectedAmount: "\($0.expectedAmount) THB",
                  goalMessage: $0.title,
                  goalProgress: Double(($0.currentAmount * 100) / $0.expectedAmount)/100.00,
                  goalDayLeft: "\($0.dayLeft) days left")
        })
        
        // Send data to view
        goalSubject.send(.init(
            totalGoal: "\(goalListDisplay.count) Goals",
            totalSavingAmount: "All Saving \(goalList.map({ $0.currentAmount }).reduce(0, { $0 + $1 })) THB"))
    }
    
    func getAllBanner() {
        bannerSubject.send(getBaseOfferList())
        bannerSubject.send(getSuggestList())
        bannerSubject.send(completion: .finished)
    }
    
    private func getBaseOfferList() -> BannerSectionDisplay {
        let detailList: [BannerDetailModel] = [
            .init(image: "https://upload.wikimedia.org/wikipedia/commons/7/74/California_sea_lion_in_La_Jolla_%2870568%29.jpg"),
            .init(image: "https://upload.wikimedia.org/wikipedia/commons/7/74/California_sea_lion_in_La_Jolla_%2870568%29.jpg"),
            .init(image: "https://upload.wikimedia.org/wikipedia/commons/7/74/California_sea_lion_in_La_Jolla_%2870568%29.jpg")
        ]
        let offerList: BannerModel = .init(title: "Base Offer", detailList: detailList)
        
        let images: [String] = detailList.map({ $0.image })
        let bannerSection: BannerSectionDisplay = .init(title: offerList.title, images: images)
        
        return bannerSection
    }
    
    private func getSuggestList() -> BannerSectionDisplay {
        let detailList: [BannerDetailModel] = [
            .init(image: "https://upload.wikimedia.org/wikipedia/commons/7/74/California_sea_lion_in_La_Jolla_%2870568%29.jpg"),
            .init(image: "https://upload.wikimedia.org/wikipedia/commons/7/74/California_sea_lion_in_La_Jolla_%2870568%29.jpg"),
            .init(image: "https://upload.wikimedia.org/wikipedia/commons/7/74/California_sea_lion_in_La_Jolla_%2870568%29.jpg")
        ]
        let offerList: BannerModel = .init(title: "Suggest For you", detailList: detailList)
        
        let images: [String] = detailList.map({ $0.image })
        let bannerSection: BannerSectionDisplay = .init(title: offerList.title, images: images)
    
        return bannerSection
    }
}


