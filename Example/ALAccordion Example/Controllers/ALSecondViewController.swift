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

class ALSecondViewController: UIViewController, ALAccordionSectionDelegate
{
    //
    // MARK: - Properties
    //

    var headerBottomConstraint: NSLayoutConstraint?
    
    lazy var headerView: UIView =
    {
        let header = ALExpandingHeaderView()
        header.backgroundColor = UIColor(red: 164.0/255.0, green: 73.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        header.titleLabel.text = "Section 2 Header"
        header.detailLabel.text = "Dynamic Sized Header"

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

    func sectionWillOpen(#animated: Bool)
    {
        println("Second Section Will Open")

        let duration = animated ? self.accordionController!.animationDuration : 0.0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            let h = self.headerView as! ALExpandingHeaderView
            h.open()
        },
        completion: nil)
    }

    func sectionWillClose(#animated: Bool)
    {
        println("Second Section Will Close")

        let duration = animated ? accordionController!.animationDuration : 0.0
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations:
        {
            let h = self.headerView as! ALExpandingHeaderView
            h.close()
        },
        completion: nil)
    }

    func sectionDidOpen()
    {
        println("Second Section Did Open")
    }

    func sectionDidClose()
    {
        println("Second Section Did Close")
    }
}