//
//  ALSeparatorView.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 20/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

class ALSeparatorView: UIView
{
    //
    // MARK: - Properties
    //

    var separatorColor: UIColor = UIColor.white { didSet { self.setNeedsDisplay() }}

    @IBInspectable var lineWidth: CGFloat = 1.0 { didSet { self.setNeedsDisplay() }}

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
        self.backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect)
    {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.separatorColor.cgColor)

        context?.setLineWidth(self.lineWidth)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: rect.width, y: 0))

        context?.strokePath()
    }
}
