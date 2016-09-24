//
//  ALExpandingHeaderView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 18/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
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

    let detailLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    fileprivate var titleLabel_bottom: NSLayoutConstraint!

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

        let topSeparator_top = NSLayoutConstraint(item: self.topSeparator, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let topSeparator_height = NSLayoutConstraint(item: self.topSeparator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1.0)

        let titleLabel_top = NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.topSeparator, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        let titleLabel_detailLabel = NSLayoutConstraint(item: self.titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self.detailLabel, attribute: .top, multiplier: 1.0, constant: 2.0)

        self.titleLabel_bottom = NSLayoutConstraint(item: self.titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self.bottomSeparator, attribute: .bottom, multiplier: 1.0, constant: -15.0)

        let detailLabel_bottom = NSLayoutConstraint(item: self.detailLabel, attribute: .bottom, relatedBy: .equal, toItem: self.bottomSeparator, attribute: .bottom, multiplier: 1.0, constant: -15.0)
        detailLabel_bottom.priority = 750

        let bottomSeparator_bottom = NSLayoutConstraint(item: self.bottomSeparator, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let bottomSeparator_height = NSLayoutConstraint(item: self.bottomSeparator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1.0)

        let titleLabel_centerX = NSLayoutConstraint(item: self.titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let detailLabel_centerX = NSLayoutConstraint(item: self.detailLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)

        let views = ["topSeparator": self.topSeparator, "titleLabel": self.titleLabel, "detailLabel": self.detailLabel, "bottomSeparator": self.bottomSeparator]

        let horizontal_topSeparator    = NSLayoutConstraint.constraints(withVisualFormat: "H:|[topSeparator]|", options: [], metrics: nil, views: views)
        let horizontal_titleLabel      = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[titleLabel]-15-|", options: [], metrics: nil, views: views)
        let horizontal_detailLabel     = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[detailLabel]-15-|", options: [], metrics: nil, views: views)
        let horizontal_bottomSeparator = NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomSeparator]|", options: [], metrics: nil, views: views)

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
