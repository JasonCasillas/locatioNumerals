//
//  StringExtensions.swift
//  locatioNumerals
//
//  Created by Jason Casillas on 7/6/16.
//  Copyright © 2016 TWNH. All rights reserved.
//

import Foundation

extension String {
    func onlyContainsValuesInExptectedSet(expectedCharacterSet:NSCharacterSet) -> Bool {
        let unexpectedCharacters = expectedCharacterSet.invertedSet
        
        if self.rangeOfCharacterFromSet(unexpectedCharacters) == nil {
            return true
        } else {
            return false
        }
    }

    func onlyContainsNumericValues() -> Bool {
        return onlyContainsValuesInExptectedSet(NSCharacterSet.decimalDigitCharacterSet())
    }

    func onlyContainsAlphabeticalValues() -> Bool {
        return onlyContainsValuesInExptectedSet(NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyz"))
    }
}
