//
//  User.swift

import Foundation

struct User: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String = "User"
    var currentAmount: Double = .zero
    var targetAmount: Double = .zero
}
