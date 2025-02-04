//
//  Team.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import Foundation

struct Team: Identifiable, Codable, Equatable, Hashable {
    private(set) var id = UUID().uuidString
    var name: String
    var members: [TeamMember] = []
}
