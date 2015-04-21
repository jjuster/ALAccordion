//
//  ALSingleLineHeaderView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 18/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

class ALSingleLineHeaderView: UIView
{
    //
    // MARK: - Properties
    //

    let topSeparator: ALSeparatorView =
    {
        let view = ALSeparatorView()
        view.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    let bottomSeparator: ALSeparatorView =
    {
        let view = ALSeparatorView()
        view.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(17.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center

        label.setTranslatesAutoresizingMaskIntoConstraints(false)

        return label
    }()

    //
    // MARK: - Initialisers
    //
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)

        self.commonInit()
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()

        self.commonInit()
    }

    func commonInit()
    {
        // Create and setup views
        self.addSubview(self.topSeparator)
        self.addSubview(self.titleLabel)
        self.addSubview(self.bottomSeparator)

        // Setup constraints
        let views = ["topSeparator": self.topSeparator, "titleLabel": self.titleLabel, "bottomSeparator": self.bottomSeparator]

        let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topSeparator(1)]-(15)-[titleLabel]-(15)-[bottomSeparator(1)]|", options: nil, metrics: nil, views: views)

        let horizontal_topSeparator    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[topSeparator]|", options: nil, metrics: nil, views: views)
        let horizontal_titleLabel      = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]-15-|", options: nil, metrics: nil, views: views)
        let horizontal_bottomSeparator = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparator]|", options: nil, metrics: nil, views: views)

        self.addConstraints(vertical + horizontal_topSeparator + horizontal_titleLabel + horizontal_bottomSeparator)
    }
}
