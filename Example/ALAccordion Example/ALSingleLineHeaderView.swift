//
//  ALSingleLineHeaderView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 18/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//

import UIKit

class ALSingleLineHeaderView: UIView
{
    //
    // MARK: Properties
    //

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
        self.backgroundColor = UIColor(red: 216.0/255.0, green: 71.0/255.0, blue: 69.0/255.0, alpha: 1.0)

        self.addSubview(titleLabel)

        // Setup constraints
        let views = ["titleLabel": titleLabel]

        let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(10)-[titleLabel]-(10)-|", options: nil, metrics: nil, views: views)
        let centerX = NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)

        self.addConstraints(vertical)
        self.addConstraint(centerX)
    }
}
