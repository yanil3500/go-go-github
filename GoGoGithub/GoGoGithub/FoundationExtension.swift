//
//  FoundationExtension.swift
//  GoGoGithub
//
//  Created by Elyanil Liranzo Castro on 4/3/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation


//MARK: UserDefaultsExtension
extension UserDefaults {
    func getAccessToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: "access_token") else { return nil }
        return token
     }
    
    func save(accessToken: String) -> Bool {
        UserDefaults.standard.set(accessToken, forKey: "access_token")
        return UserDefaults.standard.synchronize()
    }
}

extension String{
    func dateToString() -> String?{
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withFullTime]
        let string = dateFormatter.date(from: self).map { (date) -> String in
            String(describing: date)
        }
        let time = string!.components(separatedBy: " ").dropLast().joined(separator: " ")
        

        return time
    }
    
}
