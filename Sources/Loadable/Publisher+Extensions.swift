//
//  Publisher+Extensions.swift
//  
//
//  Created by Mohammad Javad Bashtani on 10/26/1400 AP.
//

import Foundation
import Combine

@available(macOS 10.15, *)
public extension Publisher {
    /// convert a publisher data to states of a label
    /// - returns: A publisher with ``Loadable`` output type
    func mapToLoadable() -> AnyPublisher<Loadable<Output>, Never> {
        self.map {
            Loadable<Output>.loaded($0)

        }.catch {
            Just(Loadable.failed($0))
        }
        // any crash will not happen because we catch error's of publisher before
        .assertNoFailure()
        // when subscripton happend set state of loadable to loading
        .merge(with: Just(Loadable<Output>.isLoading))
        .eraseToAnyPublisher()
    }
}

/// used type erasure technique to extend publisher where output type is ``Loadable``
@available(macOS 10.15, *)
public extension Publisher where Output: LoadableProtocol, Failure == Never {
    /// Publish when state of loadable is loaded
    var loaded: AnyPublisher<Output.DataType, Failure> {
        self.compactMap(\.value)
            .eraseToAnyPublisher()
    }
    /// Publish loading state of loadable
    var isLoading: AnyPublisher<Bool, Never> {
        self.map(\.isLoading)
            .eraseToAnyPublisher()
    }
    /// Publish when an error occure in fetching data for loadble
    var isFailed: AnyPublisher<Output.Failure, Never> {
        self.compactMap(\.error)
            .eraseToAnyPublisher()
    }
}
