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
    // MARK: - Properties
    //

    @IBOutlet var backgroundImageView: UIImageView!

    //
    // MARK: - Methods
    //

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
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .Dark)

        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)

        self.backgroundImageView.addSubview(blurView)

        // Setup contraints on blurView (edge to edge)
        let views = ["blurView": blurView]

        let horizontalConstrainsts = NSLayoutConstraint.constraintsWithVisualFormat("H:|[blurView]|", options: nil, metrics: nil, views: views)
        let verticalConstrainsts   = NSLayoutConstraint.constraintsWithVisualFormat("V:|[blurView]|", options: nil, metrics: nil, views: views)
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
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

        let section1ViewController = storyboard.instantiateViewControllerWithIdentifier("firstVC") as! ALFirstViewController
        let section2ViewController = storyboard.instantiateViewControllerWithIdentifier("secondVC") as! ALSecondViewController
        let section3ViewController = storyboard.instantiateViewControllerWithIdentifier("thirdVC") as! ALThirdViewController

        self.setViewControllers(section1ViewController, section2ViewController, section3ViewController)
    }
}
