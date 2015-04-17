//
//  ALAccordionSectionDelegate.swift
//  ALAccordion
//
//  Created by Sam Williams on 16/04/2015.
//  Copyright (c) 2015 Alliants Ltd. All rights reserved.
//
//  http://alliants.com
//

import UIKit

@objc public protocol ALAccordionControllerDelegate: class
{
    var headerView: UIView { get }

    optional func sectionWillOpen()
    optional func sectionWillClose()

    optional func sectionDidOpen()
    optional func sectionDidClose()
}