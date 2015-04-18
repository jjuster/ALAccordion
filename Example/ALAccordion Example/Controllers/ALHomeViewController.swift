//
//  ALHomeViewController.swift
//  ALAccordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Sam Williams. All rights reserved.
//
//  http://alliants.com
//

import UIKit

import ALAccordion

class ALHomeViewController: ALAccordionController
{ 
    //
    // MARK: - Methods
    //

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.createHeaderFooterViews()
        self.createSections()
    }

    func createHeaderFooterViews()
    {
        // Header
        let header = ALSingleLineHeaderView()
        header.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        header.titleLabel.text = "Accordion Header"

        self.headerView = header

        // Footer
        let footer = ALSingleLineHeaderView()
        footer.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        footer.titleLabel.text = "Accordion Footer"

        self.footerView = footer
    }

    func createSections()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

        let section1ViewController = storyboard.instantiateViewControllerWithIdentifier("firstVC") as! ALFirstViewController
        let section2ViewController = storyboard.instantiateViewControllerWithIdentifier("secondVC") as! ALSecondViewController
        let section3ViewController = storyboard.instantiateViewControllerWithIdentifier("thirdVC") as! ALThirdViewController

        self.setViewControllers(section1ViewController, section2ViewController, section3ViewController)
    }
}
