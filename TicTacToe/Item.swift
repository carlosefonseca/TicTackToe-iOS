//
//  Item.swift
//  TicTacToe
//
//  Created by Carlos Fonseca on 28/09/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
