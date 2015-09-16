//
//  ALHomeViewController.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 10/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

import ALAccordion

class ALHomeViewController: ALAccordionController
{
    @IBOutlet var backgroundImageView: UIImageView!

    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.setupBlurredBackground()

        self.createHeaderFooterViews()
        self.createSections()
    }

    func setupBlurredBackground()
    {
        // Add a blur overlay on the background image

        let blurEffect: UIBlurEffect = UIBlurEffect(style: .Dark)

        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundImageView.addSubview(blurView)

        // Setup contraints on blurView (edge to edge)
        let views = ["blurView": blurView]

        let horizontalConstrainsts = NSLayoutConstraint.constraintsWithVisualFormat("H:|[blurView]|", options: [], metrics: nil, views: views)
        let verticalConstrainsts   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[blurView]|", options: [], metrics: nil, views: views)
        self.backgroundImageView.addConstraints(horizontalConstrainsts + verticalConstrainsts)

    }

    func createHeaderFooterViews()
    {
        // Header
        let header = ALSingleLineHeaderView()
        header.titleLabel.text = "Accordion Header"
        header.topSeparator.alpha = 0
        header.bottomSeparator.alpha = 0

        self.headerView = header

        // Footer
        let footer = ALSingleLineHeaderView()
        footer.titleLabel.text = "Accordion Footer"
        footer.topSeparator.alpha = 0
        footer.bottomSeparator.alpha = 0

        self.footerView = footer
    }

    func createSections()
    {
        // Create some sample sections
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

        let section1ViewController = storyboard.instantiateViewControllerWithIdentifier("firstVC") as! ALFirstSectionViewController
        let section2ViewController = storyboard.instantiateViewControllerWithIdentifier("secondVC") as! ALSecondSectionViewController
        let section3ViewController = storyboard.instantiateViewControllerWithIdentifier("thirdVC") as! ALThirdSectionTableViewController

        self.setViewControllers(section1ViewController, section2ViewController, section3ViewController)
    }
}
