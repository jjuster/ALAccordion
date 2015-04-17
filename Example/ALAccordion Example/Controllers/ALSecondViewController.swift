//
//  ALSecondViewController.swift
//  ALAccordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Sam Williams. All rights reserved.
//
//  http://alliants.com
//

import UIKit

import ALAccordion

class ALSecondViewController: UIViewController, ALAccordionControllerDelegate
{
    //
    // MARK: - Properties
    //
    
    lazy var headerView: UIView =
    {
        let headerViews = NSBundle.mainBundle().loadNibNamed("SectionHeaderViews", owner: self, options: nil) as! [UIView]

        let view = headerViews[1]

        // Add a tap gesture recogniser to open the section
        let tapGR = UITapGestureRecognizer(target: self, action: "headerTapped:")
        view.addGestureRecognizer(tapGR)

        return view
    }()


    //
    // MARK: - Methods
    //
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    func headerTapped(recognizer: UITapGestureRecognizer)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            println("Second view controller header tapped")

            // If this section is open, close it - otherwise, open it
            if self.accordionController!.openSectionIndex == sectionIndex
            {
                self.accordionController?.closeSectionAtIndex(sectionIndex, animated: true)
            }
            else
            {
                self.accordionController?.openSectionAtIndex(sectionIndex, animated: true)
            }
        }
    }

    // MARK: - ALAccordionControllerDelegate

    func sectionWillOpen(animated: Bool)
    {
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

    func sectionWillClose(animated: Bool)
    {
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