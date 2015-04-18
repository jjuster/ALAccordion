//
//  ALFirstViewController.swift
//  ios-accordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Sam Williams. All rights reserved.
//
//  http://alliants.com
//

import UIKit

import ALAccordion

class ALFirstViewController: UIViewController, ALAccordionControllerDelegate
{
    //
    // MARK: - Properties
    // 

    lazy var headerView: UIView =
    {
        let header = ALSingleLineHeaderView()
        header.backgroundColor = UIColor(red: 216.0/255.0, green: 71.0/255.0, blue: 69.0/255.0, alpha: 1.0)
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
    }

    func sectionWillClose(#animated: Bool)
    {
        println("First Section Will Close")
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
