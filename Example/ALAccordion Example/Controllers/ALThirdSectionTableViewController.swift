//
//  ALThirdSectionTableViewController.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 20/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

import ALAccordion

class ALThirdSectionTableViewController: UITableViewController, ALAccordionSectionDelegate
{
    let names = ["Olivia", "Melissa", "Adrian", "Barbera", "Fred", "Joyce", "Annita", "Johanne", "Walt", "Danny", "Pablo", "Kala", "Albertina", "Carmelina", "Malcolm", "Alan", "Gene", "Diane", "Merlyn", "Azzie"]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        // Fix undesired cell animation when section first opened
        self.view.layoutIfNeeded()

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
        let header = ALDoubleLineHeaderView()
        header.titleLabel.text = "Section 3 Header"
        header.detailLabel.text = "UITableViewController Example"
        header.topSeparator.alpha = 0

        return header
    }()

    func sectionWillOpen(animated: Bool)
    {
        print("Third Section Will Open")
    }

    func sectionWillClose(animated: Bool)
    {
        print("Third Section Will Close")
    }

    func sectionDidOpen()
    {
        print("Third Section Did Open")
    }

    func sectionDidClose()
    {
        print("Third Section Did Close")
    }

    //
    // MARK: - Gesture Recognizer
    //

    func headerTapped(_ recognizer: UITapGestureRecognizer)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            print("Third view controller header tapped")

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
    // MARK: - Table view data source
    //

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return self.names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 

        // Configure the cell...
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = self.names[(indexPath as NSIndexPath).row]

        return cell
    }
}
