//
//  User.swift

import Foundation

struct User: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String = "User \(Int.random(in: 1..<100))"
    var currentAmount: Float = .zero
    var targetAmount: Float = .zero
}
