//
//  ALHomeViewController.swift
//  ALAccordion
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Sam Williams. All rights reserved.
//

import UIKit

import ALAccordion

class ALHomeViewController: ALAccordionController
{
    var header: UIView!
    var footer: UIView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.createHeaderFooterViews()
        self.createSections()
    }

    func createHeaderFooterViews()
    {
        let views = NSBundle.mainBundle().loadNibNamed("HeaderFooterViews", owner: self, options: nil) as! [UIView]

        self.header = views[0]
        self.footer = views[1]

        self.header.backgroundColor = UIColor.clearColor()
        self.footer.backgroundColor = UIColor.clearColor()

        self.setupHeaderView(self.header)
        self.setupFooterView(self.footer)
    }

    func createSections()
    {
        let section1 = ALFirstViewController()
        let section2 = ALSecondViewController()
        let section3 = ALThirdViewController()

        self.setSections(section1, section2, section3)
    }
}
