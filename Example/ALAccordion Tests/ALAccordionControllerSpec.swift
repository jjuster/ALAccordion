//
//  ALAccordionControllerSpec.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 27/04/2015.
//    Copyright (c) 2015 Alliants Ltd. All rights reserved.
//

import Quick
import Nimble

import ALAccordion

class ALAccordionControllerSpec: QuickSpec
{
    override func spec() 
    {
        describe("ALAccordionController")
        {
            var accordion: ALAccordionController!

            var viewController1: ALTestSectionViewController!
            var viewController2: ALTestSectionViewController!

            beforeEach
            {
                accordion = ALAccordionController()

                viewController1 = ALTestSectionViewController()
                viewController2 = ALTestSectionViewController()

                accordion.setViewControllers(viewController1, viewController2)
            }

            describe("setViewControllers")
            {
                it("should add the view controllers to its view hierarchy")
                {
                    expect(viewController1.view.isDescendantOfView(accordion.view)).to(beTrue())
                    expect(viewController2.view.isDescendantOfView(accordion.view)).to(beTrue())
                }

                it("should add the sections header view to its view hierarchy")
                {
                    expect(viewController1.headerView.isDescendantOfView(accordion.view)).to(beTrue())
                    expect(viewController2.headerView.isDescendantOfView(accordion.view)).to(beTrue())
                }
            }

            describe("addViewController:")
            {
                var viewController3: ALTestSectionViewController!

                beforeEach
                {
                    viewController3 = ALTestSectionViewController()

                    accordion.addViewController(viewController3, animated: false)
                }

                it("should add the view controller to its view hierarchy")
                {
                    expect(viewController3.view.isDescendantOfView(accordion.view)).to(beTrue())
                }

                it("should add the sections header view to its view hierarchy")
                {
                    expect(viewController3.headerView.isDescendantOfView(accordion.view)).to(beTrue())
                }

                it("should append the section to the end off its section list")
                {
                    expect(accordion.sectionIndexForViewController(viewController3)).to(equal(2))
                }
            }

            describe("insertViewController:atIndex:")
            {
                var viewController3: ALTestSectionViewController!

                beforeEach
                {
                    viewController3 = ALTestSectionViewController()

                    accordion.insertViewController(viewController3, atIndex: 0, animated: false)
                }

                it("should add the view controller to its view hierarchy")
                {
                    expect(viewController3.view.isDescendantOfView(accordion.view)).to(beTrue())
                }

                it("should add the sections header view to its view hierarchy")
                {
                    expect(viewController3.headerView.isDescendantOfView(accordion.view)).to(beTrue())
                }

                it("should insert the section to the correct index")
                {
                    expect(accordion.sectionIndexForViewController(viewController3)).to(equal(0))
                }
            }

            describe("removeSectionAtIndex:")
            {
                beforeEach
                {
                    accordion.removeSectionAtIndex(0, animated: false)
                }

                it("should remove the view controller from its view hierarchy")
                {
                    expect(viewController1.view.isDescendantOfView(accordion.view)).toEventually(beFalse())
                }

                it("should remove the sections header view to its view hierarchy")
                {
                    expect(viewController1.headerView.isDescendantOfView(accordion.view)).toEventually(beFalse())
                }

                it("should remove the section its section list")
                {
                    expect(accordion.sectionIndexForViewController(viewController1)).to(beNil())
                }
            }

            describe("sectionIndexForViewController:")
            {
                context("when the viewController is a section of the accordion")
                {
                    it ("should return the correct section index, based on its position")
                    {
                        expect(accordion.sectionIndexForViewController(viewController1)).to(equal(0))
                        expect(accordion.sectionIndexForViewController(viewController2)).to(equal(1))
                    }
                }

                context("when the viewController is not a section of the accordion")
                {
                    it ("should return nil")
                    {
                        let randomViewController = ALTestSectionViewController()
                        expect(accordion.sectionIndexForViewController(randomViewController)).to(beNil())
                    }
                }
            }


            describe("openSectionAtIndex:animated:")
            {
                beforeEach
                {
                    accordion.openSectionAtIndex(0, animated: false)
                }


                it("should mark the section as open")
                {
                    expect(accordion.openSectionIndex).to(equal(0))
                }

                it("should close all other sections")
                {
                    accordion.openSectionAtIndex(1, animated: false)

                    expect(accordion.openSectionIndex).to(equal(1))
                }
            }

            describe("closeSectionAtIndex:animated:")
            {
                it("should mark the section as closed")
                {
                    // First open a section, then close it
                    accordion.openSectionAtIndex(1, animated: false)
                    accordion.closeSectionAtIndex(1, animated: false)

                    expect(accordion.openSectionIndex).to(beNil())
                }
            }

            describe("closeAllSections:")
            {
                it("should mark all sections as closed")
                {
                    accordion.openSectionAtIndex(1, animated: false)
                    accordion.closeAllSections(animated: false)

                    expect(accordion.openSectionIndex).to(beNil())
                }
            }
        }
    }
}
