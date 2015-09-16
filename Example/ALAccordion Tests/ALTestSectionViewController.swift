//
//  ALTestSectionViewController.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 27/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//

import UIKit

import ALAccordion

class ALTestSectionViewController: UIViewController, ALAccordionSectionDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //
    // MARK: - ALAccordionControllerDelegate
    //

    lazy var headerView = UIView()

    func sectionWillOpen(animated animated: Bool)
    {

    }

    func sectionWillClose(animated animated: Bool)
    {

    }

    func sectionDidOpen()
    {

    }
    
    func sectionDidClose()
    {

    }
}
