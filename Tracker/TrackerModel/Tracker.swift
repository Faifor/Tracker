//
//  Untitled.swift
//  Tracker
//
//  Created by Данила Спиридонов on 08.10.2025.
//

import UIKit

enum Weekday: Int, CaseIterable, Codable {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct Tracker: Equatable, Hashable {
    let id: UUID
    let title: String
    let color: UIColor
    let emoji: String
    let schedule: [Weekday]
}




