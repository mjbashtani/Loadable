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
    
    func test_MapToLoadable_EmitingFailureState() throws {
        let subject = CurrentValueSubject<String, Error>("")
        let error = LoadableError()
        subject.send(completion: .failure(error))
        let result = try awaitPublisher(subject
                                        .eraseToAnyPublisher()
                                        .mapToLoadable()
                                            .collect(2)
                                            .last()
                                            .eraseToAnyPublisher())
            
        XCTAssertEqual(result.first, Loadable<String>.failed(error))
        
    }
    
    func test_loadableIsloadingPublisherWhenIsLoading() throws {
        let result = try awaitPublisher(Just(Loadable<String>.isLoading)
                                            .isLoading)
        XCTAssertEqual(result, true)
    }
    func test_loadableIsloadingPublisherWhenIsNotLoading() throws {
        let result = try awaitPublisher(Just(Loadable<String>.loaded(""))
                                            .isLoading)
        XCTAssertEqual(result, false)
    }
    
    func test_loadableLoadedPublisher() throws {
        let value = String.init()
        let result = try awaitPublisher(Just(Loadable<String>.loaded(value))
                                            .loaded)
        XCTAssertEqual(result, value)
    }
    
    func test_loadableFailedPublisher() throws {
        let error = LoadableError()
        let result = try awaitPublisher(Just(Loadable<String>.failed(error))
                                            .isFailed)
        XCTAssertEqual(result.localizedDescription, error.localizedDescription)
    }
}
