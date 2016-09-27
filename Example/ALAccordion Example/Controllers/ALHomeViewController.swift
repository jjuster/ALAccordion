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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

        let blurEffect: UIBlurEffect = UIBlurEffect(style: .dark)

        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundImageView.addSubview(blurView)

        // Setup contraints on blurView (edge to edge)
        let views = ["blurView": blurView]

        let horizontalConstrainsts = NSLayoutConstraint.constraints(withVisualFormat: "H:|[blurView]|", options: [], metrics: nil, views: views)
        let verticalConstrainsts   = NSLayoutConstraint.constraints(withVisualFormat: "V:|[blurView]|", options: [], metrics: nil, views: views)
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
        let footer = ALDoubleLineHeaderView()
        footer.titleLabel.text = "Accordion Footer"
        footer.detailLabel.text = "Tap to add a new section"
        footer.topSeparator.alpha = 0
        footer.bottomSeparator.alpha = 0

        let tapGR = UITapGestureRecognizer(target: self, action: #selector(footerTapped(_:)))
        footer.addGestureRecognizer(tapGR)

        self.footerView = footer
    }

    func createSections()
    {
        // Create some sample sections
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let section1ViewController = storyboard.instantiateViewController(withIdentifier: "firstVC") as! ALFirstSectionViewController
        let section2ViewController = storyboard.instantiateViewController(withIdentifier: "secondVC") as! ALSecondSectionViewController
        let section3ViewController = storyboard.instantiateViewController(withIdentifier: "thirdVC") as! ALThirdSectionTableViewController
        let section4ViewController = storyboard.instantiateViewController(withIdentifier: "fourthVC") as! ALFourthDynamicViewController

        self.setViewControllers(section1ViewController, section2ViewController, section3ViewController, section4ViewController)
    }

    func footerTapped(_ sender: AnyObject)
    {
        // Add a new section

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let sectionViewController = storyboard.instantiateViewController(withIdentifier: "fourthVC") as! ALFourthDynamicViewController

        // Add a new section to the accordion, then close
        self.addViewController(sectionViewController, animated: true)
    }
}
