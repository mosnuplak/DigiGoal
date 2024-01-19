//
//  UIImageExtension.swift
//  digigoal
//
//  Created by nattachai.nuplak on 19/1/2567 BE.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        self.kf.setImage(with: url)
    }
}
