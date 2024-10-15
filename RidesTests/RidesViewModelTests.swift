//
//  RidesViewModelTests.swift
//  RidesViewModelTests
//
//  Created by Mirold Dabre on 10/12/24.
//

import XCTest
@testable import Rides
import Combine

class RidesViewModelTests: XCTestCase {
    
    var viewModel: VehicleListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = VehicleListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Validation For Input Field Tests

    func test_validationForInputField_withSearchTextBetweenOneToHundred_shouldReturnFalse() {
        let expectedResult = false
        
        viewModel.searchText = "1"
        let result = viewModel.validationForWrongInputField()
        
        XCTAssert(result == expectedResult, "Result is \(result) but expected is \(expectedResult)")
    }
    
    func test_validationForInputField_withSearchTextLessThanOne_shouldReturnTrue() {
        let expectedResult = true
        
        viewModel.searchText = "0"
        let result = viewModel.validationForWrongInputField()
        
        XCTAssert(result == expectedResult, "Result is \(result) but expected is \(expectedResult)")
    }
    
    func test_validationForInputField_withSearchTextNegative_shouldReturnTrue() {
        let expectedResult = true
        
        viewModel.searchText = "-1"
        let result = viewModel.validationForWrongInputField()
        
        XCTAssert(result == expectedResult, "Result is \(result) but expected is \(expectedResult)")
    }
    
    func test_validationForInputField_withSearchTextGreaterThanHundred_shouldReturnTrue() {
        let expectedResult = true
        
        viewModel.searchText = "101"
        let result = viewModel.validationForWrongInputField()
        
        XCTAssert(result == expectedResult, "Result is \(result) but expected is \(expectedResult)")
    }

    // MARK: - Validation For Carbon Emission Calculation Tests
    
    func test_calculateCarbonEmission_withKilometersLessThanFiveThousand_shouldReturnKilometersOnly() {
        let expectedResult: Double = 4500
        
        let kilometers: Double = 4500
        let result = viewModel.calculateCarbonEmission(kilometers: kilometers)
        
        XCTAssert(result == expectedResult, "Result is `\(result)` but expected is `\(expectedResult)`")
    }
    
    func test_calculateCarbonEmission_withKilometersMoreThanFiveThousand_shouldReturnCalculatedCarbonEmission() {
        let expectedResult: Double = 12500
        
        let kilometers: Double = 10000
        let result = viewModel.calculateCarbonEmission(kilometers: kilometers)
        
        XCTAssert(result == expectedResult, "Result is `\(result)` but expected is `\(expectedResult)`")
    }
    
    func test_calculateCarbonEmission_withKilometersEqualToFiveThousand_shouldReturnKilometersOnly() {
        let expectedResult: Double = 5000
        
        let kilometers: Double = 5000
        let result = viewModel.calculateCarbonEmission(kilometers: kilometers)
        
        XCTAssert(result == expectedResult, "Result is `\(result)` but expected is `\(expectedResult)`")
    }
    
    func test_calculateCarbonEmission_withKilometersZero_shouldReturnZeroOnly() {
        let expectedResult: Double = 0
        
        let kilometers: Double = 0
        let result = viewModel.calculateCarbonEmission(kilometers: kilometers)
        
        XCTAssert(result == expectedResult, "Result is `\(result)` but expected is `\(expectedResult)`")
    }
}
