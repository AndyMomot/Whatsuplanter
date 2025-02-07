//
//  FinanceItem.swift
//  Whatsuplanter
//
//  Created by Andrii Momot on 07.02.2025.
//

import Foundation

struct FinanceItem: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var description: String
    var goalAmount: Int
    var durationInDays: Int
    var images: [String]
    var costs: Int
}
