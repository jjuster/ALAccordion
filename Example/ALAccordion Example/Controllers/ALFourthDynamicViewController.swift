//
//  ALFourthDynamicViewController.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 14/02/2016.
//  Copyright © 2016 Alliants Ltd. All rights reserved.
//

import UIKit

import ALAccordion

class ALFourthDynamicViewController: UIViewController, ALAccordionSectionDelegate
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
        let header = ALRemovableHeaderView()
        header.titleLabel.text = "Dynamic Section Header"
        header.closeButton.addTarget(self, action: "btnRemovePressed:", forControlEvents: .TouchUpInside)
        header.topSeparator.alpha = 0

        // Add a tap gesture recogniser to open the section
        let tapGR = UITapGestureRecognizer(target: self, action: "headerTapped:")
        header.addGestureRecognizer(tapGR)

        return header
    }()

    func sectionWillOpen(animated animated: Bool)
    {
        print("Dynamic Section Will Open")
    }

    func sectionWillClose(animated animated: Bool)
    {
        print("Dynamic Section Will Close")
    }

    func sectionDidOpen()
    {
        print("Dynamic Section Did Open")
    }

    func sectionDidClose()
    {
        print("Dynamic Section Did Close")
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

    func btnRemovePressed(sender: UIButton)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            self.accordionController?.removeSectionAtIndex(sectionIndex, animated: true)
        }
    }

    @IBAction func btnAddSectionPressed(sender: AnyObject)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

        let sectionViewController = storyboard.instantiateViewControllerWithIdentifier("fourthVC") as! ALFourthDynamicViewController

        // Add a new section to the accordion, then close
        self.accordionController?.addViewController(sectionViewController, animated: true)

        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            self.accordionController?.closeSectionAtIndex(sectionIndex, animated: true)
        }
    }
}
