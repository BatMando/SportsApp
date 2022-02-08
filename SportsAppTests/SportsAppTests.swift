//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Mohamed Ahmed on 08/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import XCTest
@testable import SportsApp

class SportsAppTests: XCTestCase {
    
    var networkManager = NetworkManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadDataFromURL() {
        let expectaion = expectation(description: "waiting for the API")
        networkManager.request(fromEndpoint: .allSports, parameters: nil){(result:Result<GetAllSportsResponseModel , Error>) in
            switch result {
            case .success(let response):
                guard let count = response.sports?.count else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(count , 34, "API Faild")
                expectaion.fulfill()
            case .failure(let _):
                XCTFail()
            }
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

