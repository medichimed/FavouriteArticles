//
//  RoundedCornersView.swift
//  Articles
//
//  Created by Оксана Котілевська on 14.11.2020.
//

import UIKit

class RoundedCornersView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
    }
}
