//
//  WorkProduct.swift
//  Worker
//
//  Created by John Siracusa on 6/26/25.
//

import Foundation

nonisolated final class WorkProduct {
    var id = UUID()
    var name : String? = nil
    var data = Data(repeating: 0xFF, count: 1024)
}
