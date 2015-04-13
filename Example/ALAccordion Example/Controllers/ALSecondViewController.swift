//
//  ALSecondViewController.swift
//  ALAccordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Sam Williams. All rights reserved.
//

import UIKit

import ALAccordion

class ALSecondViewController: ALAccordionSectionViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.createHeaderBodyViews()
    }

    func createHeaderBodyViews()
    {
        let views = NSBundle.mainBundle().loadNibNamed("Section2Views", owner: self, options: nil) as! [UIView]

        let header = views[0]
        let body = views[1]

        self.setupHeaderView(header)
        self.setupBodyView(body)

        // Add a tap gesture recogniser to open the section
        let tapGR = UITapGestureRecognizer(target: self, action: "headerTapped:")
        self.view.addGestureRecognizer(tapGR)
    }

    func headerTapped(recognizer: UITapGestureRecognizer)
    {
        println("Date header tapped")
        if (self.open)
        {
            self.closeSection(animated: true)
        }
        else
        {
            self.openSection(animated: true)
        }
    }

    // MARK: - Open 'n' close methods
    override func openSection(#animated: Bool)
    {
        // Actually open the section
        super.openSection(animated: animated)

        //        self.headerContainer.removeConstraint(self.dateLabelBottomConstraint)
        //
        //        // Animate the labels
        //        let duration = animated ? ANIMATION_DURATION : 0
        //        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        //        {
        //            self.view.layoutIfNeeded()
        //            self.selectDatesLabel.alpha = 1.0
        //            self.selectedDateRangeView.alpha = 0
        //            return
        //        },
        //        completion: nil)
    }

    override func closeSection(#animated: Bool)
    {
        // Actually close the section
        super.closeSection(animated: animated)

        //        if self.dateLabelBottomConstraint != nil
        //        {
        //            self.headerContainer.addConstraint(self.dateLabelBottomConstraint)
        //        }
        //
        //        // Animate the labels
        //        let duration = animated ? ANIMATION_DURATION : 0
        //        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        //            {
        //                self.view.layoutIfNeeded()
        //                self.selectDatesLabel?.alpha = 0
        //                self.selectedDateRangeView?.alpha = 1.0
        //                return
        //            },
        //            completion: nil)
    }
}