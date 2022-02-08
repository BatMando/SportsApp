//
//  SelfSizedTableView.swift
//  SportsApp
//
//  Created by admin on 1/29/22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit


class SelfSizedTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}
