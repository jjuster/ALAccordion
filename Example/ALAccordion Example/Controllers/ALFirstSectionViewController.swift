//
//  ALFirstSectionViewController.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

import ALAccordion

class ALFirstSectionViewController: UIViewController, ALAccordionSectionDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
    }

    //
    // MARK: - ALAccordionControllerDelegate
    //

    // The header view for this section
    lazy var headerView: UIView =
    {
        let header = ALSingleLineHeaderView()
        header.titleLabel.text = "Section 1 Header"

        // Add a tap gesture recogniser to open the section
        let tapGR = UITapGestureRecognizer(target: self, action: "headerTapped:")
        header.addGestureRecognizer(tapGR)

        return header
    }()

    func sectionWillOpen(animated animated: Bool)
    {
        print("First Section Will Open")

        let duration = animated ? self.accordionController!.animationDuration : 0.0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            let h = self.headerView as! ALSingleLineHeaderView
            h.topSeparator.alpha = 0
        },
        completion: nil)
    }

    func sectionWillClose(animated animated: Bool)
    {
        print("First Section Will Close")

        let duration = animated ? self.accordionController!.animationDuration : 0.0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            let h = self.headerView as! ALSingleLineHeaderView
            h.topSeparator.alpha = 1.0
        },
        completion: nil)
    }

    func sectionDidOpen()
    {
        print("First Section Did Open")
    }

    func sectionDidClose()
    {
        print("First Section Did Close")
    }

    //
    // MARK: - Gesture Recognizer
    //

    func headerTapped(recognizer: UITapGestureRecognizer)
    {
        // Get the section index for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            print("First view controller header tapped")

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

    //
    // MARK: - Button Handlers
    //

    @IBAction func btnClosePressed(sender: UIButton)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            self.accordionController?.closeSectionAtIndex(sectionIndex, animated: true)
        }
    }
}
