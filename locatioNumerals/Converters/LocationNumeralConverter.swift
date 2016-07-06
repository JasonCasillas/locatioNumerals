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

    let maxInlineZs = 10

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
        let zInteger:Int! = lettersToIntegerRepresentationsDictionary["z"]
        let numberOfZsForInteger:Int! = integer/zInteger

        var locationNumeralsArray:[Character] = []
        var remainingInteger = integer - (numberOfZsForInteger * zInteger)
        while remainingInteger > 0 {
            let integerForNextLocationNumeral = largestIntegerFromArrayThatIsLessThanOrEqualToInteger(integerRepresentationsArray, integer: remainingInteger)
            let nextLocationNumeral:Character! = integerRepresentationsToLettersDictionary[integerForNextLocationNumeral]
            locationNumeralsArray.append(nextLocationNumeral)
            remainingInteger = remainingInteger - integerForNextLocationNumeral
        }

        var locationNumeral:String = ""
        if locationNumeralsArray.count > 0 {
            locationNumeral = String(locationNumeralsArray.sort())
        }

        if numberOfZsForInteger > 0 {
            let stringForZs = zStringToDisplay(numberOfZsForInteger)
            if locationNumeral.isEmpty {
                locationNumeral = stringForZs
            } else {
                if numberOfZsForInteger > maxInlineZs {
                    locationNumeral = "\(locationNumeral) + \(stringForZs)"
                } else {
                    locationNumeral = "\(locationNumeral)\(stringForZs)"
                }
            }
        }

        return locationNumeral
    }

    func zStringToDisplay(numberOfZs:Int) -> String {
        if numberOfZs > maxInlineZs {
            return "z * \(numberOfZs)"
        } else {
            var zsString = ""
            for _ in 1...numberOfZs {
                zsString.append("z" as Character)
            }
            return zsString
        }
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
