//
//  ALAccordionViewController.swift
//  ALAccordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

public class ALAccordionViewController: UIViewController
{
    private let ACCORDION_ANIMATION_DURATION = 0.3

    // MARK: - Properties

    private let headerContainerView = UIView()
    private let sectionContainerView = UIView()
    private let footerContainerView = UIView()

    private var sections = [ALAccordionSectionViewController]()

    private var sectionTopConstraint: NSLayoutConstraint?
    private var sectionBottomConstraint: NSLayoutConstraint?

    // MARK: - View Methods

    override public func viewDidLoad()
    {
        super.viewDidLoad()

        self.layoutView()

        self.sectionContainerView.clipsToBounds = true
        self.sectionContainerView.backgroundColor = UIColor.clearColor()
    }

    // MARK: - Layout views

    public func setSections(sections: ALAccordionSectionViewController...)
    {
        for s in sections
        {
            s.accordion = self
            self.sections.append(s)
        }

        self.layoutSectionViews()
    }

    // Layouts out the header, container and footer views

    private func layoutView()
    {
        // Layout views

        self.view.addSubview(self.headerContainerView)
        self.view.addSubview(self.sectionContainerView)
        self.view.addSubview(self.footerContainerView)

        self.headerContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.sectionContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.footerContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)


        let headerTop = NSLayoutConstraint(item: self.headerContainerView, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0)
        headerTop.priority = 250

        let footerBottom = NSLayoutConstraint(item: self.bottomLayoutGuide, attribute: .Bottom, relatedBy: .Equal, toItem: self.footerContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        footerBottom.priority = 250


        let views = ["header": self.headerContainerView, "container": self.sectionContainerView, "footer": self.footerContainerView]

        let headerHorizontal    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[header]|", options: nil, metrics: nil, views: views)
        let containerHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[container]|", options: nil, metrics: nil, views: views)
        let footerHorizontal    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[footer]|", options: nil, metrics: nil, views: views)

        let centerYContainer = NSLayoutConstraint(item: self.sectionContainerView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        centerYContainer.priority = 250

        let topContainer = NSLayoutConstraint(item: self.sectionContainerView, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: self.headerContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let bottomContainer = NSLayoutConstraint(item: self.footerContainerView, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: self.sectionContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)

        self.view.addConstraints([headerTop, footerBottom, centerYContainer, topContainer, bottomContainer])
        self.view.addConstraints(headerHorizontal + containerHorizontal + footerHorizontal)
    }

    public func setupHeaderView(header: UIView)
    {
        // Add the header view to the header container view
        self.headerContainerView.addSubview(header)
        header.setTranslatesAutoresizingMaskIntoConstraints(false)

        // Constraints
        let views = ["header": header]
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[header]|", options: nil, metrics: nil, views: views)
        let vertical   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[header]|", options: nil, metrics: nil, views: views)

        self.headerContainerView.addConstraints(horizontal + vertical)
    }

    public func setupFooterView(footer: UIView)
    {
        // Add the footer view to the footer container view
        self.footerContainerView.addSubview(footer)
        footer.setTranslatesAutoresizingMaskIntoConstraints(false)

        // Constraints
        let views = ["footer": footer]
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[footer]|", options: nil, metrics: nil, views: views)
        let vertical   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[footer]|", options: nil, metrics: nil, views: views)

        self.footerContainerView.addConstraints(horizontal + vertical)
    }

    // Layout the sections within the container view
    private func layoutSectionViews()
    {
        // Remove current sections
        self.removeCurrentSections()

        if self.sections.count == 0
        {
            return
        }

        // Add all the section views and setup constraints between them
        var previousView = self.sectionContainerView
        for section in self.sections
        {
            // Add section to view
            self.sectionContainerView.addSubview(section.view)
            section.view.setTranslatesAutoresizingMaskIntoConstraints(false)

            // Setup constraints
            let views = ["section": section.view]

            let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[section]|", options: nil, metrics: nil, views: views)

            var top = NSLayoutConstraint(item: section.view, attribute: .Top, relatedBy: .Equal, toItem: previousView, attribute: previousView == self.sectionContainerView ? .Top : .Bottom, multiplier: 1.0, constant: 0)


            self.sectionContainerView.addConstraints(horizontal)
            self.sectionContainerView.addConstraint(top)

            self.addChildViewController(section)

            previousView = section.view
        }

        // Add final bottom constraint
        let lastSection = sections.last

        let bottom = NSLayoutConstraint(item: lastSection!.view, attribute: .Bottom, relatedBy: .Equal, toItem: self.sectionContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        self.sectionContainerView.addConstraint(bottom)

        self.view.setNeedsLayout()
    }

    // Removes all the current sections from the view
    private func removeCurrentSections()
    {
        for childVC in self.childViewControllers as! [UIViewController]
        {
            childVC.view.removeFromSuperview()
            childVC.removeFromParentViewController()
        }
    }

    // MARK: - Section callback methods

    // Called by a section when it gets marked for opening
    func openSection(section: ALAccordionSectionViewController, animated: Bool)
    {
        // Open up the section to full screen

        // Remove previous top/bottom constraints on section and add them to the current section
        if let top = self.sectionTopConstraint
        {
            self.view.removeConstraint(top)
        }

        if let bottom = self.sectionBottomConstraint
        {
            self.view.removeConstraint(bottom)
        }

        section.activateOpenConstraints()

        // Create the top & bottom constraints to pull the section to full screen
        self.sectionTopConstraint = NSLayoutConstraint(item: section.view, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0)
        self.sectionBottomConstraint = NSLayoutConstraint(item: self.bottomLayoutGuide, attribute: .Bottom, relatedBy: .Equal, toItem: section.view, attribute: .Bottom, multiplier: 1.0, constant: 0)

        self.view.addConstraints([self.sectionTopConstraint!, self.sectionBottomConstraint!])

        // Tell system to update the layout
        let duration = animated ? ACCORDION_ANIMATION_DURATION : 0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            // Hide header & footer
            self.headerContainerView.alpha = 0
            self.footerContainerView.alpha = 0

            // Hide other sections
            for s in self.sections
            {
                if s != section
                {
                    s.view.alpha = 0
                }
            }

            self.view.layoutIfNeeded()
        },
        completion: nil)
    }

    // Called by a section when it gets marked for closing
    func closeSection(section: ALAccordionSectionViewController, animated: Bool)
    {
        // We need to break the top and bottom constraints (if full screen mode is enabled)
        if let top = self.sectionTopConstraint
        {
            self.view.removeConstraint(top)
        }

        if let bottom = self.sectionBottomConstraint
        {
            self.view.removeConstraint(bottom)
        }

        section.activateCloseConstraints()
        
        // Tell system to update the layout
        let duration = animated ? ACCORDION_ANIMATION_DURATION : 0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            // Show header & footer
            self.headerContainerView.alpha = 1.0
            self.footerContainerView.alpha = 1.0

            // Show all sections
            for s in self.sections
            {
                s.view.alpha = 1.0
            }

            self.view.layoutIfNeeded()
        },
        completion: nil)
    }
}
