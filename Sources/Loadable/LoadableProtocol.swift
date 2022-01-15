//
//  LoadableProtocol.swift
//  
//
//  Created by Mohammad Javad Bashtani on 10/26/1400 AP.
//

import Foundation

/// Use for type erasuring  ``Loadable`` for extending ``Combine.Publisher``
protocol LoadableProtocol {
    associatedtype DataType
    associatedtype Failure

    var value: DataType? { get }
    var error: Failure? { get }
    var isLoading: Bool { get }

}
