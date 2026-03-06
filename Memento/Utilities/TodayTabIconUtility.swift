//
//  dayNumberUtility.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 15/02/2026.
//

import Foundation

extension Date {
    static var today: Int {
        Calendar.current.component(.day, from: Date())
    }
    
    static func todayDate() -> String {
        "\(today).calendar"
    }
}
