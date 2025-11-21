//
//  Untitled.swift
//  Tracker
//
//  Created by Данила Спиридонов on 21.11.2025.
//

extension Weekday {
    static var fullName: [String] {
        return allCases.map { $0.fullName }
    }
}
