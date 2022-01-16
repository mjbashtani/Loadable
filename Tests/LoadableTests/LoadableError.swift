//
//  File.swift
//  
//
//  Created by Mohammad Javad Bashtani on 10/26/1400 AP.
//

import Foundation
import XCTest

extension XCTestCase {
     struct LoadableError: LocalizedError, Identifiable {
        let id: String = UUID().uuidString
         
         var errorDescription: String? {
             id
         }
    }
}
