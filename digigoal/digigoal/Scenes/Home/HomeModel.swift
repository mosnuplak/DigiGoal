//
//  HomeModel.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import Foundation
import UIKit

// Model for display on screen
struct GoalSectionDisplay {
    let totalGoal: String
    let totalSavingAmount: String
}

struct BannerSectionDisplay {
    let title: String
    let images: [String]
}

// Model for receive data from API
struct GoalModel {
    let type: String
    let currentAmount: Int
    let expectedAmount: Int
    let title: String
    let status: String
    let dayLeft: String
}

struct BannerModel {
    let title: String
    let detailList: [BannerDetailModel]
}

struct BannerDetailModel {
    let image: String
}

enum GoalStatus: String {
    case good
    case unhappy
    case none
    
    var color: UIColor {
        switch self {
        case .good:
            return #colorLiteral(red: 0.1019545719, green: 0.4736476541, blue: 0.006857927423, alpha: 1)
        case .unhappy:
            return #colorLiteral(red: 0.7829477191, green: 0.2881441116, blue: 0.01826691069, alpha: 1)
        case .none:
            return .clear
        }
    }
    
    var message: String? {
        switch self {
        case .good:
            return "Good"
        case .unhappy:
            return "Unhappy"
        case .none:
            return nil
        }
    }
    
    static func toEnum(_ str: String) -> GoalStatus {
        return GoalStatus(rawValue: str) ?? .none
    }
}

enum GoalType: String {
    case travel
    case education
    case invest
    case clothing
    case none
    
    var image: UIImage? {
        switch self {
        case .travel:
            return UIImage(systemName: "suitcase.cart")
        case .education:
            return UIImage(systemName: "graduationcap")
        case .invest:
            return UIImage(systemName: "banknote")
        case .clothing:
            return UIImage(systemName: "tshirt")
        case .none:
            return nil
        }
    }
    
    static func toEnum(_ str: String) -> GoalType {
        return GoalType(rawValue: str) ?? .none
    }
}
