//
//  ALThirdSectionTableViewController.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 20/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//

import UIKit

import ALAccordion

class ALThirdSectionTableViewController: UITableViewController, ALAccordionSectionDelegate
{
    //
    // MARK: - Properties
    //

    lazy var headerView: UIView =
    {
        let header = ALSingleLineHeaderView()
        header.titleLabel.text = "UITableViewController Example"
        header.topSeparator.alpha = 0

        // Add a tap gesture recogniser to open the section
        let tapGR = UITapGestureRecognizer(target: self, action: "headerTapped:")
        header.addGestureRecognizer(tapGR)

        return header
    }()

    let names = ["Olivia", "Melissa", "Adrian", "Barbera", "Fred", "Joyce", "Annita", "Johanne", "Walt", "Danny", "Pablo", "Kala", "Albertina", "Carmelina", "Malcolm", "Alan", "Gene", "Diane", "Merlyn", "Azzie"]


    //
    // MARK: - Methods
    //

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)

        // Fix undesired cell animation when section first opened
        self.view.layoutIfNeeded()
    }

    func headerTapped(recognizer: UITapGestureRecognizer)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            println("Third view controller header tapped")

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
        println("Third Section Will Open")
    }

    func sectionWillClose(#animated: Bool)
    {
        println("Third Section Will Close")
    }

    func sectionDidOpen()
    {
        println("Third Section Did Open")
    }

    func sectionDidClose()
    {
        println("Third Section Did Close")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return self.names.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = self.names[indexPath.row] ?? ""

        return cell
    }
}
