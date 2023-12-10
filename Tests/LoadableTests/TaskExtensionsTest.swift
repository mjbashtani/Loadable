//
//  File.swift
//
//
//  Created by Mohammad Bashtani on 12/10/23.
//

import Foundation
@testable import Loadable
import XCTest

final class TaskExtensionsTest: XCTestCase {
    func test_MapToLoadable_returning_value() async throws {
        let valueToBeReturn = "value"
        var loadable: Loadable<String> = .idle
        loadable = await Task.init {
            return valueToBeReturn
        }.mapToLoadable()
        XCTAssertEqual(loadable.value, valueToBeReturn)
    }

    func test_MapToLoadable_throwing_error() async throws {
        let errorToBeThrown = LoadableError()
        var loadable: Loadable<String> = .idle
        loadable = await Task.init {
            throw errorToBeThrown
        }.mapToLoadable()
        XCTAssertEqual(loadable.error?.localizedDescription, errorToBeThrown.localizedDescription)
    }
}
