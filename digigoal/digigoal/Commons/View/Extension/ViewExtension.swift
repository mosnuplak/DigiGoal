//
//  ViewExtension.swift
//  digigoal
//
//  Created by nattachai.nuplak on 18/1/2567 BE.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func loadNibToView(nibName: String? = nil) -> UIView {
        let loadNibName = nibName ?? String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: loadNibName, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            addSubview(view)
            view.addConstraintsFitSuperView()
            return view
        }
        return UIView()
    }
    
    @discardableResult
    func addConstraintsFitSuperView(withInsets insets: UIEdgeInsets = .zero) -> Anchored? {
        guard let superView = self.superview else { return nil }
        self.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top)
        let rightConstraint = self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -insets.right)
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom)
        let leftConstraint = self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left)
        NSLayoutConstraint.activate([topConstraint, leftConstraint, bottomConstraint, rightConstraint])
        return .init(
            top: topConstraint,
            left: leftConstraint,
            bottom: bottomConstraint,
            right: rightConstraint
        )
    }
}

struct Anchored {
    var top: NSLayoutConstraint?
    var left: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var right: NSLayoutConstraint?
}
