//
//  StringUtilsTests.swift
//  FetchRecipesTests
//
//  Created by Brandon LaRue on 6/17/24.
//

@testable import FetchRecipes
import XCTest

final class StringUtilsTests: XCTestCase {
    func testCapitalizeFirstLetters() {
        XCTAssertEqual(capitalizeFirstLetters(of: "apple pie"), "Apple Pie")
        XCTAssertEqual(capitalizeFirstLetters(of: "banana split"), "Banana Split")
        XCTAssertEqual(capitalizeFirstLetters(of: "cherry tart"), "Cherry Tart")
        XCTAssertEqual(capitalizeFirstLetters(of: ""), "")
        XCTAssertEqual(capitalizeFirstLetters(of: "hello world"), "Hello World")
        XCTAssertEqual(capitalizeFirstLetters(of: "this is a test"), "This Is A Test")
    }
}
