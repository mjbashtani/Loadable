//
//  File.swift
//  
//
//  Created by Mohammad Bashtani on 12/10/23.
//

import Foundation

@available(macOS 10.15, *)
extension Task {
    func mapToLoadable() async  -> Loadable<Success> {
        do {
            let data = try await self.value
            return .loaded(data)
        }
        catch {
            return .failed(error)
        }
    }
}
