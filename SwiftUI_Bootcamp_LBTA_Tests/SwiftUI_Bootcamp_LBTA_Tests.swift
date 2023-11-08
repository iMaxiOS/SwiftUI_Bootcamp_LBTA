//
//  SwiftUI_Bootcamp_LBTA_Tests.swift
//  SwiftUI_Bootcamp_LBTA_Tests
//
//  Created by Maxim Hranchenko on 08.11.2023.
//

import XCTest
@testable import SwiftUI_Bootcamp_LBTA
import Combine

final class SwiftUI_Bootcamp_LBTA_Tests: XCTestCase {
    
    var viewModel: UnitTestingViewModel?
    var cancellable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellable.removeAll()
    }

    func test_UnitTestViewModel_isPremium_shouldBeTrue() throws {
        let isPremiumTrue = true
        
        let vm = UnitTestingViewModel(isPremium: isPremiumTrue)
        
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeFalse() throws {
        let isPremiumTrue = false
        
        let vm = UnitTestingViewModel(isPremium: isPremiumTrue)
        
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeInjectValue() throws {
        for _ in 0..<10 {
            let isPremiumTrue = Bool.random()
            
            let vm = UnitTestingViewModel(isPremium: isPremiumTrue)
            
            XCTAssertEqual(isPremiumTrue, vm.isPremium)
        }
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeEqual() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopTimes = 10
        
        for _ in 0..<loopTimes {
            vm.appendItem(UUID().uuidString)
        }
        
        
        XCTAssertTrue(!vm.arrayData.isEmpty)
        XCTAssertFalse(vm.arrayData.isEmpty)
        XCTAssertNotNil(vm.arrayData)
        XCTAssertGreaterThan(vm.arrayData.count, 0)
        XCTAssertEqual(vm.arrayData.count, loopTimes)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeBlankEmpty() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        vm.appendItem("")
        
        XCTAssertTrue(vm.arrayData.isEmpty)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeSelectedNil() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        XCTAssertNil(vm.selectedItem)
        XCTAssertTrue(vm.selectedItem == nil)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeSelectedItem() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let id = UUID().uuidString
        vm.appendItem(id)
        vm.selectedItem(id)
        
        XCTAssertTrue(!vm.arrayData.isEmpty)
        XCTAssertFalse(vm.arrayData.isEmpty)
        XCTAssertEqual(vm.selectedItem, id)
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertLessThanOrEqual(vm.selectedItem ?? "", id)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeThrowError() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        let id = UUID().uuidString
        XCTAssertThrowsError(try vm.saveItem(id))
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeThrowError_ItemNotFound() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopTimes = 10
        for _ in 0..<loopTimes {
            vm.appendItem(UUID().uuidString)
        }
        
        XCTAssertThrowsError(try vm.saveItem(UUID().uuidString), "Item not found!!!") { error in
            let returnError = error as? UnitTestingViewModel.ErrorData
            XCTAssertEqual(returnError, UnitTestingViewModel.ErrorData.itemNotFound)
        }
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeThrowError_noData() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopTimes = 10
        for _ in 0..<loopTimes {
            vm.appendItem(UUID().uuidString)
        }
        
        XCTAssertThrowsError(try vm.saveItem(""), "No Data!!!") { error in
            let returnError = error as? UnitTestingViewModel.ErrorData
            XCTAssertEqual(returnError, UnitTestingViewModel.ErrorData.noData)
        }
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeSaveItem() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        let loopTimes: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopTimes {
            let newItem = UUID().uuidString
            vm.appendItem(newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        
        XCTAssertFalse(randomItem.isEmpty)
        XCTAssertNoThrow(try vm.saveItem(randomItem))
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeDownloadWithEscaping() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        
        vm.$arrayData
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        vm.downloadWithEscaping()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.arrayData.count, 0)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeDownloadWithCombine() throws {
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        let expectation = XCTestExpectation(description: "Should return items after a second.")
        
        vm.$arrayData
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        vm.downloadWithCombine()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.arrayData.count, 0)
    }
    
    func test_NewMockDataSource_DownloadingCombine() {
        let dataSource = NewMockDataSource(items: nil)
        
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataSource.downloadingWithCombine()
            .sink { completion in
                switch completion {
                case .finished: 
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
                }
            } receiveValue: { returnItems in
                items = returnItems
            }
            .store(in: &cancellable)

        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(dataSource.arrayItems.count)
        XCTAssertEqual(items.count, dataSource.arrayItems.count)
    }
    
//    func test_NewMockDataSource_DownloadingCombine_Fail() {
//        let dataSource = NewMockDataSource(items: [])
//        
//        var items: [String] = []
//        let expectation = XCTestExpectation()
//        
//        dataSource.downloadingWithCombine()
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    XCTFail()
//                case .failure(_):
//                    expectation.fulfill()
//                }
//            } receiveValue: { returnItems in
//                items = returnItems
//            }
//            .store(in: &cancellable)
//
//        XCTAssertEqual(items.count, dataSource.arrayItems.count)
//    }
    
}
