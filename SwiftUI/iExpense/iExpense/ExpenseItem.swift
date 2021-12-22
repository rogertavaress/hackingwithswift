//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Rogério Tavares on 22/11/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
