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
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        // Add gesture recognizer to header
        self.headerView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        )
    }

    //
    // MARK: - ALAccordionControllerDelegate
    //

    // The header view for this section
    let headerView: UIView =
    {
        let header = ALSingleLineHeaderView()
        header.titleLabel.text = "Section 1 Header"

        return header
    }()

    func sectionWillOpen(animated: Bool)
    {
        print("First Section Will Open")

        let duration = animated ? self.accordionController!.animationDuration : 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations:
        {
            let h = self.headerView as! ALSingleLineHeaderView
            h.topSeparator.alpha = 0
        },
        completion: nil)
    }

    func sectionWillClose(animated: Bool)
    {
        print("First Section Will Close")

        let duration = animated ? self.accordionController!.animationDuration : 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations:
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

    func headerTapped(_ recognizer: UITapGestureRecognizer)
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

    @IBAction func btnClosePressed(_ sender: UIButton)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            self.accordionController?.closeSectionAtIndex(sectionIndex, animated: true)
        }
    }
}
