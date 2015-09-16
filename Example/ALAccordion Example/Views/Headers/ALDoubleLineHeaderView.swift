//
//  ALDoubleLineHeaderView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 21/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

class ALDoubleLineHeaderView: UIView
{
    //
    // MARK: - Properties
    //

    let topSeparator: ALSeparatorView =
    {
        let view = ALSeparatorView()
        view.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bottomSeparator: ALSeparatorView =
    {
        let view = ALSeparatorView()
        view.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(17.0)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let detailLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14.0)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var titleLabel_bottom: NSLayoutConstraint!

    //
    // MARK: - Initialisers
    //

    required init?(coder aDecoder: NSCoder)
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
        self.addSubview(self.detailLabel)
        self.addSubview(self.bottomSeparator)

        // Setup constraints

        let views = ["topSeparator": self.topSeparator, "titleLabel": self.titleLabel, "detailLabel": self.detailLabel, "bottomSeparator": self.bottomSeparator]

        let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topSeparator(1)]-(15)-[titleLabel]-1-[detailLabel]-(15)-[bottomSeparator(1)]|", options: [], metrics: nil, views: views)

        let horizontal_topSeparator    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[topSeparator]|", options: [], metrics: nil, views: views)
        let horizontal_titleLabel      = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]-15-|", options: [], metrics: nil, views: views)
        let horizontal_detailLabel      = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[detailLabel]-15-|", options: [], metrics: nil, views: views)
        let horizontal_bottomSeparator = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparator]|", options: [], metrics: nil, views: views)

        self.addConstraints(vertical + horizontal_topSeparator + horizontal_titleLabel + horizontal_detailLabel + horizontal_bottomSeparator)
    }
}