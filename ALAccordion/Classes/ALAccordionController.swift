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

public class ALAccordionController: UIViewController
{
    // MARK: - Properties

    public var animationDuration = 0.3

    private let headerContainerView = UIView()
    private let sectionContainerView = UIView()
    private let footerContainerView = UIView()

    private(set) public var sections = [ALAccordionSection]()

    private var sectionTopConstraint: NSLayoutConstraint?
    private var sectionBottomConstraint: NSLayoutConstraint?

    public var openSectionIndex: Int?
    {
        // Return the index of the first section that's marked as open
        for (idx, section) in self.sections.enumerate()
        {
            if section.open
            {
                return idx
            }
        }

        return nil
    }

    public var headerView: UIView?
    {
        didSet
        {
            if headerView != nil
            {
                self.setupHeaderView(headerView!)
            }
        }
    }

    public var footerView: UIView?
    {
        didSet
        {
            if footerView != nil
            {
                self.setupFooterView(footerView!)
            }
        }
    }


    // MARK: - View Methods

    override public func viewDidLoad()
    {
        super.viewDidLoad()

        self.layoutView()

        self.sectionContainerView.clipsToBounds = true
        self.sectionContainerView.backgroundColor = UIColor.clearColor()
    }

    // MARK: - Layout views

    public func setViewControllers(viewControllers: UIViewController...)
    {
        self.setViewControllers(viewControllers, animated: false)
    }

    // Removes any previous sections, and rebuilds the accordion with the new view controllers
    public func setViewControllers(viewControllers: [UIViewController], animated: Bool)
    {
        // Remove existing sections
        self.removeAllSections()

        for vc in viewControllers
        {
            self.addViewController(vc, animated: animated)
        }
    }

    public func addViewController(viewController: UIViewController, animated: Bool)
    {
        // Append view controller to the end
        let index = self.sections.count
        self.insertViewController(viewController, atIndex: index, animated: animated)
    }

    public func insertViewController(viewController: UIViewController, atIndex index: Int, animated: Bool)
    {
        assert(viewController is ALAccordionSectionDelegate, "View Controller \(viewController) must conform to the protocol \(_stdlib_getDemangledTypeName(ALAccordionSectionDelegate))")

        // Setup the section
        let section = ALAccordionSection(viewController: viewController)
        section.sectionView.alpha = 0

        // Move the section below the last section so animation is better
        if let lastSection = self.sections.last
        {
            section.sectionView.frame = lastSection.sectionView.frame
            section.sectionView.setNeedsLayout()
            section.sectionView.layoutIfNeeded()
        }

        // Add section to view
        self.sectionContainerView.addSubview(section.sectionView)
        section.sectionView.translatesAutoresizingMaskIntoConstraints = false

        self.addChildViewController(section.viewController)

        section.accordion = self
        self.sections.insert(section, atIndex: index)

        self.rebuildSectionConstraints()


        // Show / fade in the new section
        let duration = animated ? self.animationDuration : 0

        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()

            section.sectionView.alpha = 1.0
        },
        completion: nil)
    }

    public func removeSectionAtIndex(index: Int, animated: Bool)
    {
        assert(index >= 0 && index < self.sections.count, "Section index \(index) out of bounds")

        let section = self.sections[index]

        // Close section if it's open
        self.closeSection(section, animated: animated)
        {
            let frame = section.sectionView.frame

            // Remove the section from the array
            self.sections.removeAtIndex(index)

            // Rebuild the constraints between sections
            self.rebuildSectionConstraints()

            // Tell system to update the layout
            let duration = animated ? self.animationDuration : 0

            UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
            {
                section.sectionView.alpha = 0

                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()

                // Keep the section in place for animation
                section.sectionView.frame = frame
            },
            completion:
            {
                (completed: Bool) in

                // Remove the view & controller from the parent
                section.sectionView.removeFromSuperview()
                section.viewController.removeFromParentViewController()
            })
        }
    }

    // Layouts out the header, container and footer views

    private func layoutView()
    {
        // Layout views

        self.view.addSubview(self.headerContainerView)
        self.view.addSubview(self.sectionContainerView)
        self.view.addSubview(self.footerContainerView)

        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.sectionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.footerContainerView.translatesAutoresizingMaskIntoConstraints = false

        let headerTop = NSLayoutConstraint(item: self.headerContainerView, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0)
        headerTop.priority = 250

        let footerBottom = NSLayoutConstraint(item: self.bottomLayoutGuide, attribute: .Bottom, relatedBy: .Equal, toItem: self.footerContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        footerBottom.priority = 250


        let views = ["header": self.headerContainerView, "container": self.sectionContainerView, "footer": self.footerContainerView]

        let headerHorizontal    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[header]|", options: [], metrics: nil, views: views)
        let containerHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[container]|", options: [], metrics: nil, views: views)
        let footerHorizontal    = NSLayoutConstraint.constraintsWithVisualFormat("H:|[footer]|", options: [], metrics: nil, views: views)

        let centerYContainer = NSLayoutConstraint(item: self.sectionContainerView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        centerYContainer.priority = 250

        let topContainer = NSLayoutConstraint(item: self.sectionContainerView, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: self.headerContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let bottomContainer = NSLayoutConstraint(item: self.footerContainerView, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: self.sectionContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)

        self.view.addConstraints([headerTop, footerBottom, centerYContainer, topContainer, bottomContainer])
        self.view.addConstraints(headerHorizontal + containerHorizontal + footerHorizontal)
    }

    private func setupHeaderView(header: UIView)
    {
        // Remove any previous header
        for v in self.headerContainerView.subviews 
        {
            v.removeFromSuperview()
        }

        // Add the header view to the header container view
        self.headerContainerView.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false

        // Constraints
        let views = ["header": header]
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[header]|", options: [], metrics: nil, views: views)
        let vertical   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[header]|", options: [], metrics: nil, views: views)

        self.headerContainerView.addConstraints(horizontal + vertical)
    }

    private func setupFooterView(footer: UIView)
    {
        // Remove any previous footer
        for v in self.footerContainerView.subviews 
        {
            v.removeFromSuperview()
        }

        // Add the footer view to the footer container view
        self.footerContainerView.addSubview(footer)
        footer.translatesAutoresizingMaskIntoConstraints = false

        // Constraints
        let views = ["footer": footer]
        let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[footer]|", options: [], metrics: nil, views: views)
        let vertical   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[footer]|", options: [], metrics: nil, views: views)

        self.footerContainerView.addConstraints(horizontal + vertical)
    }

    // Layout the sections within the container view
    private var sectionConstraints = [NSLayoutConstraint]()
    private func rebuildSectionConstraints()
    {
        if self.sections.count == 0
        {
            return
        }

        // Remove any existing constraints
        self.sectionContainerView.removeConstraints(self.sectionConstraints)
        self.sectionConstraints.removeAll()

        // Add all the section views and setup constraints between them
        var previousView = self.sectionContainerView
        for section in self.sections
        {
            // Setup constraints
            let views = ["section": section.sectionView]

            let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[section]|", options: [], metrics: nil, views: views)

            let top = NSLayoutConstraint(item: section.sectionView, attribute: .Top, relatedBy: .Equal, toItem: previousView, attribute: previousView == self.sectionContainerView ? .Top : .Bottom, multiplier: 1.0, constant: 0)

            self.sectionContainerView.addConstraints(horizontal)
            self.sectionContainerView.addConstraint(top)

            // Keep track of constraints, so we can remove when rebuilding
            self.sectionConstraints.append(top)

            previousView = section.sectionView
        }

        // Add final bottom constraint
        let lastSection = sections.last

        let bottom = NSLayoutConstraint(item: lastSection!.sectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self.sectionContainerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        self.sectionContainerView.addConstraint(bottom)

        self.sectionConstraints.append(bottom)
    }

    // Removes all the current sections from the view
    private func removeAllSections()
    {
        for childView in self.sectionContainerView.subviews 
        {
            childView.removeFromSuperview()
        }

        for childVC in self.childViewControllers 
        {
            childVC.removeFromParentViewController()
        }

        self.sections = []
    }


    // Get the ALAccordionSection object that a given view controller is associated with
    public func sectionIndexForViewController(viewController: UIViewController) -> Int?
    {
        for (idx, section) in self.sections.enumerate()
        {
            if section.viewController == viewController
            {
                return idx
            }
        }

        return nil
    }

    // MARK: - Open 'n' Close Methods

    public func openSectionAtIndex(index: Int, animated: Bool)
    {
        assert(index >= 0 && index < self.sections.count, "Section index (\(index)) out of bounds. There are only \(self.sections.count) sections")

        // Get the section at this index
        let section = self.sections[index]
        self.openSection(section, animated: true)
    }

    public func closeSectionAtIndex(index: Int, animated: Bool)
    {
        assert(index >= 0 && index < self.sections.count, "Section index (\(index)) out of bounds. There are only \(self.sections.count) sections")

        // Get the section at this index
        let section = self.sections[index]
        self.closeSection(section, animated: animated)
    }

    public func closeAllSections(animated animated: Bool)
    {
        for section in self.sections
        {
            self.closeSection(section, animated: animated)
        }
    }

    func openSection(section: ALAccordionSection, animated: Bool)
    {
        // Dont open again
        if section.open == true
        {
            return
        }

        // Close all the sections first
        self.closeAllSections(animated: animated)

        let viewController = section.viewController as? ALAccordionSectionDelegate

        // Tell the view controller that it's about to open
        viewController?.sectionWillOpen?(animated: animated)

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
        self.sectionTopConstraint = NSLayoutConstraint(item: section.sectionView, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0)
        self.sectionBottomConstraint = NSLayoutConstraint(item: self.bottomLayoutGuide, attribute: .Bottom, relatedBy: .Equal, toItem: section.sectionView, attribute: .Bottom, multiplier: 1.0, constant: 0)

        self.view.addConstraints([self.sectionTopConstraint!, self.sectionBottomConstraint!])

        // Tell system to update the layout
        let duration = animated ? self.animationDuration : 0

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
                    s.sectionView.alpha = 0
                }
            }
            
            self.view.layoutIfNeeded()
        },
        completion:
        {
            (finished: Bool) in

            // Tell the view controller that it just opened
            viewController?.sectionDidOpen?()
        })
    }

    func closeSection(section: ALAccordionSection, animated: Bool)
    {
        self.closeSection(section, animated: animated, completion: nil)
    }

    func closeSection(section: ALAccordionSection, animated: Bool, completion: (()->())?)
    {
        // Dont close again
        if !section.open
        {
            completion?()
            return
        }

        let viewController = section.viewController as? ALAccordionSectionDelegate

        // Tell the view controller delegate that it's about to close
        viewController?.sectionWillClose?(animated: animated)

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
        let duration = animated ? self.animationDuration : 0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            // Show header & footer
            self.headerContainerView.alpha = 1.0
            self.footerContainerView.alpha = 1.0

            // Show all sections
            for s in self.sections
            {
                s.sectionView.alpha = 1.0
            }

            self.view.layoutIfNeeded()
        },
        completion:
        {
            (finished: Bool) in

            // Tell the view controller that it just closed
            viewController?.sectionDidClose?()

            completion?()
        })
    }
}
