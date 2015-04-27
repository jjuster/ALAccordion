//
//  UIViewController+ALAccordionSpec.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 27/04/2015.
//    Copyright (c) 2015 Alliants Ltd. All rights reserved.
//

import Quick
import Nimble

import ALAccordion

class UIViewController_ALAccordionSpec: QuickSpec
{
    override func spec() 
    {
        describe("UIViewController+ALAccordion")
        {
            context("when a UIViewController is added as a section of an ALAccordionController")
            {
                it ("the accordionController property should return the ALAccordionController instance")
                {
                    let accordionController = ALAccordionController()
                    let viewController = ALTestSectionViewController()
                    accordionController.setViewControllers(viewController)

                    expect(viewController.accordionController).to(equal(accordionController))
                }
            }

            context("when a UIViewController is not a section of an ALAccordionController")
            {
                it ("the accordionController property should return nil")
                {
                    let viewController = ALTestSectionViewController()
                    expect(viewController.accordionController).to(beNil())
                }
            }
        }
    }
}
