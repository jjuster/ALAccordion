//
//  ALSeparatorView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 20/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//

import UIKit

class ALSeparatorView: UIView
{
    //
    // MARK: - Properties
    //

    var separatorColor: UIColor = UIColor.whiteColor() { didSet { self.setNeedsDisplay() }}

    @IBInspectable var lineWidth: CGFloat = 1.0 { didSet { self.setNeedsDisplay() }}

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
        self.backgroundColor = UIColor.clearColor()
    }

    //
    // MARK: - Methods
    //

    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)

        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, self.separatorColor.CGColor)

        CGContextSetLineWidth(context, self.lineWidth)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, rect.width, 0)

        CGContextStrokePath(context)
    }
}
