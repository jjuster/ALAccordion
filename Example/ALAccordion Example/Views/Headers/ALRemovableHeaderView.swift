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
        view.separatorColor = UIColor.white.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bottomSeparator: ALSeparatorView =
    {
        let view = ALSeparatorView()
        view.separatorColor = UIColor.white.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.textColor = UIColor.white
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let closeButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setTitle("X", for: UIControlState())
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

        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[topSeparator(1)]-(15)-[titleLabel]-(15)-[bottomSeparator(1)]|", options: [], metrics: nil, views: views)

        let horizontal_topSeparator    = NSLayoutConstraint.constraints(withVisualFormat: "H:|[topSeparator]|", options: [], metrics: nil, views: views)
        let horizontal_titleLabel      = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[titleLabel]-15-[closeButton]-15-|", options: [], metrics: nil, views: views)
        let horizontal_bottomSeparator = NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomSeparator]|", options: [], metrics: nil, views: views)

        let closeCenterY = NSLayoutConstraint(item: self.closeButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)

        self.addConstraints(vertical + horizontal_topSeparator + horizontal_titleLabel + horizontal_bottomSeparator + [closeCenterY])
    }
}
