//
//  UserDefaultsManager.swift
//  GuessTheNumber
//
//  Created by Евгений Митюля on 1/5/24.
//

import Foundation

final class UserDefaultsManager {
    static let instance = UserDefaultsManager()
    
    private init() { }
    
    func saveUserSettings(_ user: User)  -> Result<Void, UserDefaultsError> {
        do {
            let encoder = JSONEncoder()
            let encodedData = try? encoder.encode(user)
            UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKeys.userSettings.rawValue)
            return .success(())
        } catch {
            return .failure(.error("Can't save User Settigns!"))
        }
    }
    
    func loadUserSettings() -> User? {
        if let loadedData = UserDefaults.standard.data(forKey: UserDefaultsKeys.userSettings.rawValue) {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(User.self, from: loadedData) {
                return decodedData
            }
        }
        return nil
    }
}
