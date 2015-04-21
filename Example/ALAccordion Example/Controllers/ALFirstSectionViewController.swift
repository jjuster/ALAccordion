//
//  ALFirstSectionViewController.swift
//  ios-accordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Sam Williams. All rights reserved.
//
//  http://alliants.com
//

import UIKit

import ALAccordion

class ALFirstSectionViewController: UIViewController, ALAccordionSectionDelegate
{
    //
    // MARK: - Properties
    // 

    lazy var headerView: UIView =
    {
        let header = ALSingleLineHeaderView()
        header.titleLabel.text = "Section 1 Header"

        // Add a tap gesture recogniser to open the section
        let tapGR = UITapGestureRecognizer(target: self, action: "headerTapped:")
        header.addGestureRecognizer(tapGR)

        return header
    }()


    //
    // MARK: - Methods
    //

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
    }

    func headerTapped(recognizer: UITapGestureRecognizer)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            println("First view controller header tapped")

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

    func sectionWillOpen(#animated: Bool)
    {
        println("First Section Will Open")

        let duration = animated ? self.accordionController!.animationDuration : 0.0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            let h = self.headerView as! ALSingleLineHeaderView
            h.topSeparator.alpha = 0
        },
        completion: nil)
    }

    func sectionWillClose(#animated: Bool)
    {
        println("First Section Will Close")

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
        println("First Section Did Open")
    }

    func sectionDidClose()
    {
        println("First Section Did Close")
    }
}
