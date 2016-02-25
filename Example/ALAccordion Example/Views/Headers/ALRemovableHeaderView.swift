//
//  ALRemovableHeaderView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 14/02/2016.
//  Copyright © 2016 Alliants Ltd. All rights reserved.
//

import UIKit

class ALRemovableHeaderView: UIView
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

    let closeButton: UIButton =
    {
        let button = UIButton(type: .System)
        button.tintColor = UIColor.whiteColor()
        button.setTitle("X", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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
        self.addSubview(self.bottomSeparator)
        self.addSubview(self.closeButton)

        // Setup constraints
        let views = ["topSeparator": self.topSeparator, "titleLabel": self.titleLabel, "bottomSeparator": self.bottomSeparator, "closeButton": self.closeButton]

        let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topSeparator(1)]-(15)-[titleLabel]-(15)-[bottomSeparator(1)]|", options: [], metrics: nil, views: views)

        let horizontal_topSeparator    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[topSeparator]|", options: [], metrics: nil, views: views)
        let horizontal_titleLabel      = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLabel]-15-[closeButton]-15-|", options: [], metrics: nil, views: views)
        let horizontal_bottomSeparator = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparator]|", options: [], metrics: nil, views: views)

        let closeCenterY = NSLayoutConstraint(item: self.closeButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0)

        self.addConstraints(vertical + horizontal_topSeparator + horizontal_titleLabel + horizontal_bottomSeparator + [closeCenterY])
    }
}
