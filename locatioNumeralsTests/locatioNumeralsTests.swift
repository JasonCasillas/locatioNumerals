//
//  locatioNumeralsTests.swift
//  locatioNumeralsTests
//
//  Created by Jason Casillas on 7/5/16.
//  Copyright © 2016 TWNH. All rights reserved.
//

import XCTest
@testable import locatioNumerals

class locatioNumeralsTests: XCTestCase {
    var locationNumeralConverter:LocationNumeralConverter!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        locationNumeralConverter = LocationNumeralConverter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConvertingIntegerToLocationNumeral() {
        let locationNumeralForInteger = locationNumeralConverter.convertIntegerToLocationNumeral(9)

        XCTAssertEqual(locationNumeralForInteger, "ad")
    }

    func testConvertingLargeIntegerToLocationNumeral() {
        let largeInteger = 67108864*2
        let locationNumeralForInteger = locationNumeralConverter.convertIntegerToLocationNumeral(largeInteger)

        XCTAssertEqual(locationNumeralForInteger, "zzzz")
    }

    func testConvertingLocationNumeralToInteger() {
        let integerForLocationNumeral = locationNumeralConverter.convertLocationNumeralToInteger("ad")

        XCTAssertEqual(integerForLocationNumeral, 9)
    }

    func testAbbreviatingLocationNumeral() {
        let abbreviatedLocationNumeral = locationNumeralConverter.abbreviatedLocationNumeral("abbc")

        XCTAssertEqual(abbreviatedLocationNumeral, "ad")
    }
}
