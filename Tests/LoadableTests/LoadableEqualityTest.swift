//
//  LoadableEquality.swift
//  
//
//  Created by Mohammad Javad Bashtani on 10/26/1400 AP.
//

import Foundation
import XCTest
@testable import Loadable

final class LoadableEquality: XCTestCase {
    typealias StringLoadable = Loadable<String>
    func test_idleStateEquality() {
        let first = StringLoadable.idle
        let second = StringLoadable.idle
        XCTAssertEqual(first, second)
    }
    
    func test_diffrentStateEquality() {
        let idleState = StringLoadable.idle
        let loadingState = StringLoadable.isLoading
        let loadadState = StringLoadable.loaded("")
        let errorState = StringLoadable.failed(LoadableError())
        XCTAssertNotEqual(idleState, loadingState)
        XCTAssertNotEqual(idleState, loadadState)
        XCTAssertNotEqual(idleState, errorState)
        XCTAssertNotEqual(loadingState, loadadState)
        XCTAssertNotEqual(loadingState, errorState)
        XCTAssertNotEqual(errorState, loadadState)
        
    }
    
    func test_loadingStateEquality() {
        let first = StringLoadable.isLoading
        let second = StringLoadable.isLoading
        XCTAssertEqual(first, second)
    }
    
    func test_loadedStateEquality() {
        let first = StringLoadable.loaded("")
        let second = first
        let third = StringLoadable.loaded("  ")
        XCTAssertEqual(first, second)
        XCTAssertNotEqual(first, third)

    }
    
    func test_ErrorStateEquality() {
        let (firstError, LastError) = (LoadableError(),LoadableError())
        let first = StringLoadable.failed(firstError)
        let second = first
        let third = StringLoadable.failed(LastError)
        XCTAssertEqual(first, second)
        XCTAssertNotEqual(first, third)

    }
}
