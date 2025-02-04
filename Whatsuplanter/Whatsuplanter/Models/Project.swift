//
//  Project.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import Foundation

struct Project: Identifiable, Codable, Equatable, Hashable {
    private(set) var id = UUID().uuidString
    var isFinished = false
    
    var name: String
    var date: Date
    var address: String
    var teamID: String?
    var description: String
    var budget: Int
}
