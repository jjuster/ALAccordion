//
//  ALExpandingHeaderView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 18/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//

import UIKit

class ALExpandingHeaderView: UIView
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

    let detailLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14.0)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center

        label.setTranslatesAutoresizingMaskIntoConstraints(false)

        return label
    }()

    private var titleLabel_bottom: NSLayoutConstraint!

    //
    // MARK: Initialisers
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
        self.addSubview(self.detailLabel)
        self.addSubview(self.bottomSeparator)

        // Setup constraints

        let topSeparator_top = NSLayoutConstraint(item: self.topSeparator, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0)
        let topSeparator_height = NSLayoutConstraint(item: self.topSeparator, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1.0)

        let titleLabel_top = NSLayoutConstraint(item: self.titleLabel, attribute: .Top, relatedBy: .Equal, toItem: self.topSeparator, attribute: .Bottom, multiplier: 1.0, constant: 15.0)
        let titleLabel_detailLabel = NSLayoutConstraint(item: self.titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.detailLabel, attribute: .Top, multiplier: 1.0, constant: 2.0)

        self.titleLabel_bottom = NSLayoutConstraint(item: self.titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomSeparator, attribute: .Bottom, multiplier: 1.0, constant: -15.0)

        let detailLabel_bottom = NSLayoutConstraint(item: self.detailLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomSeparator, attribute: .Bottom, multiplier: 1.0, constant: -15.0)
        detailLabel_bottom.priority = 750

        let bottomSeparator_bottom = NSLayoutConstraint(item: self.bottomSeparator, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let bottomSeparator_height = NSLayoutConstraint(item: self.bottomSeparator, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1.0)

        let titleLabel_centerX = NSLayoutConstraint(item: self.titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let detailLabel_centerX = NSLayoutConstraint(item: self.detailLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)

        let views = ["topSeparator": self.topSeparator, "titleLabel": self.titleLabel, "detailLabel": self.detailLabel, "bottomSeparator": self.bottomSeparator]

        let horizontal_topSeparator    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[topSeparator]|", options: nil, metrics: nil, views: views)
        let horizontal_titleLabel      = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]-15-|", options: nil, metrics: nil, views: views)
        let horizontal_detailLabel     = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[detailLabel]-15-|", options: nil, metrics: nil, views: views)
        let horizontal_bottomSeparator = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparator]|", options: nil, metrics: nil, views: views)

        self.addConstraints([topSeparator_top, topSeparator_height, titleLabel_top, titleLabel_detailLabel, titleLabel_bottom, detailLabel_bottom, bottomSeparator_bottom, bottomSeparator_height, titleLabel_centerX, detailLabel_centerX])

        self.addConstraints(horizontal_topSeparator + horizontal_titleLabel + horizontal_detailLabel + horizontal_bottomSeparator)

        self.close()
    }

    //
    // MARK: - Methods
    //

    func open()
    {
        // Expand the view
        self.removeConstraint(titleLabel_bottom)
        self.detailLabel.alpha = 1.0
    }

    func close()
    {
        // Shrink the view
        self.addConstraint(titleLabel_bottom)
        self.detailLabel.alpha = 0
    }
}
