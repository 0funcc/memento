//
//  dayNumberUtility.swift
//  Memento
//
//  Created by Ali Sajulake Abdul Gafur on 15/02/2026.
//

import Foundation

extension Date {
    static var todayIconDate: Int {
        Calendar.current.component(.day, from: Date())
    }
    
    static var todayIcon = "\(todayIconDate).calendar"
}
