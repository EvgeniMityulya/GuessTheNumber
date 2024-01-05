//
//  User.swift
//  GuessTheNumber
//
//  Created by Евгений Митюля on 1/5/24.
//

import Foundation

struct User: Codable {
    let randomNum: Int
    let attempsAmount: Int
    let win: Int
    let lost: Int
    let switchStatus: Bool
    let isNewGame: Bool
}
