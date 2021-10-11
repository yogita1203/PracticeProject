//
//  API.swift
//  API
//

import Foundation
import UIKit
import SwiftUI

enum CustomError {
    case networkError(errorDescription : String)
    case serverError(statusCode: Int)
    case noData
    case decodingError(errorDescription : String)
    
    var localizedDescription: String {
            switch self {
            case .networkError(errorDescription : let msg):
                return msg
            case .serverError(statusCode: let statusCode):
                return "Server error with Status code \(statusCode)"
            case .noData:
                return "Invalid Data"
            case .decodingError(errorDescription : let msg):
                return msg
            }
        }
}

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
                if let error = error {
                    failure(.networkError(errorDescription : error.localizedDescription))
                    return
                }
                
                if let response = response as? HTTPURLResponse, (response.statusCode != 200) {
                    failure(.serverError(statusCode: response.statusCode))
                    return
                }
                
                guard let data = data else {
                    failure(.noData)
                    return
                }
                
                do
                {
                    let usersList = try JSONDecoder.init().decode([User].self, from: data)
                    let sortedFilteredList = usersList.filter({$0.id != Int(excludingUserWithID!)}).sorted(by: { $0.id > $1.id })
                    success(UsersList(sortedFilteredList))
                }
                catch let error as NSError
                {
                    failure(.decodingError(errorDescription : error.localizedDescription))
                }
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
typealias FetchError = CustomError
