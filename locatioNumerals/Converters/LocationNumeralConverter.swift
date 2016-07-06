//
//  locationNumeralConverter.swift
//  locatioNumerals
//
//  Created by Jason Casillas on 7/5/16.
//  Copyright © 2016 TWNH. All rights reserved.
//

import UIKit

class LocationNumeralConverter: NSObject {
    private let lettersArray: [Character]
    private let integerRepresentationsArray: [Int]
    private let lettersToIntegerRepresentationsDictionary: [Character: Int]
    private let integerRepresentationsToLettersDictionary: [Int: Character]

    override init() {
        lettersArray = Array("abcdefghijklmnopqrstuvwxyz".characters)

        var mutableIntegerRepresentationsArray: [Int] = []
        var mutableLettersToIntegerRepresentationsDictionary: [Character: Int] = [:]
        var mutableIntegerRepresentationsToLettersDictionary: [Int: Character] = [:]
        for (index, letter) in lettersArray.enumerate() {
            let integerRepresentationOfLetter = Int(pow(Double(2), Double(index)))

            mutableIntegerRepresentationsArray.append(integerRepresentationOfLetter)
            mutableLettersToIntegerRepresentationsDictionary[letter] = integerRepresentationOfLetter
            mutableIntegerRepresentationsToLettersDictionary[integerRepresentationOfLetter] = letter
        }

        integerRepresentationsArray = mutableIntegerRepresentationsArray
        lettersToIntegerRepresentationsDictionary = mutableLettersToIntegerRepresentationsDictionary
        integerRepresentationsToLettersDictionary = mutableIntegerRepresentationsToLettersDictionary
    }

    func convertIntegerToLocationNumeral(integer:Int) -> String {
        // Might want to add error checking for integers < 1, but for this test, we'll only pass in correct data
        // Max convertible value will be limited by max integer allowed by Swift, but calculations will slow down the app greatly before that
        var locationNumeralsArray:[Character] = []

        var remainingInteger = integer
        while remainingInteger > 0 {
            let integerForNextLocationNumeral = largestIntegerFromArrayThatIsLessThanOrEqualToInteger(integerRepresentationsArray, integer: remainingInteger)
            let nextLocationNumeral:Character! = integerRepresentationsToLettersDictionary[integerForNextLocationNumeral]
            locationNumeralsArray.append(nextLocationNumeral)
            remainingInteger = remainingInteger - integerForNextLocationNumeral
        }

        let locationNumeral = String(locationNumeralsArray.sort())
        return locationNumeral
    }

    func largestIntegerFromArrayThatIsLessThanOrEqualToInteger(integerArray: [Int], integer: Int) -> Int {
        let arrayOfIntegersLessThanOrEqualToInteger:[Int] = integerArray.filter({ $0 <= integer })
        let arrayOfIntegersLessThanOrEqualToIntegerSortedDescending = (arrayOfIntegersLessThanOrEqualToInteger.sort { $0 > $1 })

        var largestInteger = 0
        if let largestIntegerInArray = arrayOfIntegersLessThanOrEqualToIntegerSortedDescending.first {
            largestInteger = largestIntegerInArray
        }

        return largestInteger
    }

    func convertLocationNumeralToInteger(locationNumeral:String) -> Int {
        // Might want to add error checking for non a-z characters, but for this test, we'll only pass in correct data
        var integer = 0
        for locationNumeralCharacter in locationNumeral.characters {
            integer = integer + lettersToIntegerRepresentationsDictionary[locationNumeralCharacter]!
        }

        return integer
    }
    
    func abbreviatedLocationNumeral(locationNumeral:String) -> String {
        let abbreviatedLocationNumeral = convertIntegerToLocationNumeral(convertLocationNumeralToInteger(locationNumeral))

        return abbreviatedLocationNumeral
    }
}
