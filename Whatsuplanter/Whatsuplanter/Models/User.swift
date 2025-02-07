//
//  User.swift

import Foundation

struct User: Identifiable, Codable {
    private(set) var id = "User"
    var name: String = "User"
    var currentAmount: Int = .zero
    var targetAmount: Int = .zero
}
