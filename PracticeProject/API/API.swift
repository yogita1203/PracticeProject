//
//  API.swift
//  API
//

import Foundation
import UIKit
import SwiftUI

protocol API {
    init()

    func fetchUsers(excludingUserWithID: String?, success:@escaping (UsersList) -> Void, failure:@escaping (FetchError) -> Void)
}

extension API {
    static func make() -> API {
        return self.init()
    }
}

final class APIManager : API{
    
    func fetchUsers(excludingUserWithID: String?, success: @escaping (UsersList) -> Void, failure: @escaping (FetchError) -> Void) {
        
            URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/users")!) { data, response, error in
                guard let data = data else {
                    return
                }
                let usersList = try! JSONDecoder.init().decode([User].self, from: data)
                let sortedList = usersList.sorted(by: { $0.id > $1.id })
                let filteredList = sortedList.filter({$0.id != Int(excludingUserWithID!)})
                success(UsersList(filteredList))
            }.resume()
    
    
    }
    
}

// TODO: Create a data type representing users-list (according to expected JSON response)
// (See the JSON response at: https://jsonplaceholder.typicode.com/users)
//
typealias UsersList = [User]

// TODO (Bonus): Create a more specific error type.
// This can help identify the nature of a particular failure case.
// e.g. network timeout, badly formatted request or failing to decode/deserialize
// a response could cause failure in a network request.
//
typealias FetchError = Any
