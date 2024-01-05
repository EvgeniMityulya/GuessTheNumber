//
//  UserDefaultsKeys.swift
//  GuessTheNumber
//
//  Created by Евгений Митюля on 1/5/24.
//

import Foundation

enum UserDefaultsKeys: String, CaseIterable {
    case userSettings = "userSettings"
    case randomNum = "randomNum"
    case attempsAmount = "attempsAmount"
    case switchStatus = "switchStatus"
    case isNewGame = "isNewGame"
    case win = "win"
    case lost = "lost"
}
