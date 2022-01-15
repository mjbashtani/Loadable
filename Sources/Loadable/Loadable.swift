//
//  Loadable.swift
//  
//
//  Created by Mohammad Javad Bashtani on 10/26/1400 AP.
//

import Foundation

/// State manager that  Which handles the common state of a data
public enum Loadable<Value>: LoadableProtocol {
    case idle
    case isLoading
    case loaded(Value)
    case failed(Error)
   
    /// Represent fetched data when state is loaded
    public var value: Value? {
        switch self {
        case let .loaded(value): return value
        default: return nil
        }
    }
   
    /// Represent fetched data when an error occurred in fetching data
    public var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }

    /// Returns true when neither an error occurred nor Data is fetched
    public  var isLoading: Bool {
        switch self {
        case  .isLoading: return true
        default: return false
        }
    }

}
