//
//  ALAccordionSectionViewController.swift
//  ALAccordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

public class ALAccordionSectionViewController: UIViewController
{
    // MARK: - Properties
    
    weak var accordion: ALAccordionViewController?

    private let headerContainerView = UIView()
    private let bodyContainerView = UIView()

    private var openConstraint: NSLayoutConstraint!
    private var closeConstraint: NSLayoutConstraint!
    
    public var open = false

    // MARK: - View Methods

    override public func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.clipsToBounds = true

        self.layoutViews()

        // Start off closed
        self.closeSection(animated: false)
    }

    // MARK: - Layout Methods

    private func layoutViews()
    {
        // Layout the header and body views

        self.view.addSubview(self.headerContainerView)
        self.view.addSubview(self.bodyContainerView)
        
        self.headerContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bodyContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)

        // Header should hug tightly - body loosly
        self.headerContainerView.setContentHuggingPriority(1000, forAxis: .Vertical)
        self.headerContainerView.setContentCompressionResistancePriority(1000, forAxis: .Vertical)

        self.bodyContainerView.setContentHuggingPriority(250, forAxis: .Vertical)
        self.bodyContainerView.setContentCompressionResistancePriority(250, forAxis: .Vertical)

        self.headerContainerView.clipsToBounds = true
        self.bodyContainerView.clipsToBounds = true

        // Constraints
        let views = ["header": self.headerContainerView, "body": self.bodyContainerView]

        let headerHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[header]|", options: nil, metrics: nil, views: views)
        let bodyHorizontal   = NSLayoutConstraint.constraintsWithVisualFormat("H:|[body]|", options: nil, metrics: nil, views: views)

        let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[header][body]", options: nil, metrics: nil, views: views)

        self.view.addConstraints(headerHorizontal + bodyHorizontal + vertical)

        // Create the constraint for opening / closing section
        self.openConstraint = NSLayoutConstraint(item: self.view, attribute: .Bottom, relatedBy: .Equal, toItem: self.bodyContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        self.closeConstraint = NSLayoutConstraint(item: self.headerContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
    }

    public func setupHeaderView(header: UIView)
    {
        // Add the header view to the header container view
        self.headerContainerView.addSubview(header)
        header.setTranslatesAutoresizingMaskIntoConstraints(false)

        // Constraints
        let views = ["header": header]
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[header]|", options: nil, metrics: nil, views: views)
        let vertical   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[header]", options: nil, metrics: nil, views: views)

        // Low priority bottom view that can break if needed
        let bottom = NSLayoutConstraint(item: self.headerContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: header, attribute: .Bottom, multiplier: 1.0, constant: 0)
        //bottom.priority = 250

        self.headerContainerView.addConstraints(horizontal + vertical)
        self.headerContainerView.addConstraint(bottom)
    }

    public func setupBodyView(body: UIView)
    {
        // Add the footer view to the footer container view
        self.bodyContainerView.addSubview(body)
        body.setTranslatesAutoresizingMaskIntoConstraints(false)

        // Constraints
        let views = ["body": body]
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[body]|", options: nil, metrics: nil, views: views)
        let vertical   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[body]", options: nil, metrics: nil, views: views)

        // Low priority bottom view that can break if the containing body view is a fixed height
        let bottom = NSLayoutConstraint(item: self.bodyContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: body, attribute: .Bottom, multiplier: 1.0, constant: 0)
        bottom.priority = 250

        self.bodyContainerView.addConstraints(horizontal + vertical)
        self.bodyContainerView.addConstraint(bottom)
    }

    // MARK: - Opening / closing the section
    public func openSection(#animated: Bool)
    {
        // Dont open again
        if self.open
        {
            return
        }

        println("Opening section \(self)")

        self.open = true

        self.accordion?.openSection(self, animated: animated)
    }

    public func closeSection(#animated: Bool)
    {
        println("Closing section \(self)")

        self.open = false

        self.accordion?.closeSection(self, animated: animated)
    }

    func activateOpenConstraints()
    {
        // Swap open / close constraints
        self.view.removeConstraint(self.closeConstraint)
        self.view.addConstraint(self.openConstraint)
    }

    func activateCloseConstraints()
    {
        // Swap open / close constraints
        self.view.removeConstraint(self.openConstraint)
        self.view.addConstraint(self.closeConstraint)
    }
}
