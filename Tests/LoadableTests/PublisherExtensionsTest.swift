//
//  PublisherExtensionsTest.swift
//  
//
//  Created by Mohammad Javad Bashtani on 10/26/1400 AP.
//

import Foundation
import Combine
import XCTest
@testable import Loadable

final class PublisherExtensionsTest: XCTestCase {
    func test_MapToLoadable_EmitingLoadingState() throws {
       let publisher =  Just("")
            .mapToLoadable()
        let value = try awaitPublisher(publisher)
        XCTAssertEqual(value, Loadable<String>.isLoading)
    }
    
    func test_MapToLoadable_EmitingLoadedState() throws {
       let publisher =  Just("")
            .mapToLoadable()
        let value = try awaitPublisher(publisher
                                        .collect(2))
        XCTAssertEqual(value, [Loadable<String>.loaded(""), .isLoading])
    }
}
